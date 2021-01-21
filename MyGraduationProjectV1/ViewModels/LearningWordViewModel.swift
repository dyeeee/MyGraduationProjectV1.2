//
//  LearningWordViewModel.swift
//  MyGraduationProjectV1
//
//  Created by YES on 2021/1/20.
//

import SwiftUI
import Foundation
import CoreData

class LearningWordViewModel: ObservableObject{
    @Published var learningWordList:[LearningWordItem] = []
    
    func getAllItems() {
        let fetchRequest: NSFetchRequest<LearningWordItem> = LearningWordItem.fetchRequest()
        let sort = NSSortDescriptor(key: "wordContent", ascending: true,selector: #selector(NSString.caseInsensitiveCompare(_:)))
        
        fetchRequest.fetchLimit = 50
        //fetchRequest.predicate = pre
        fetchRequest.sortDescriptors = [sort]
        
        let viewContext = PersistenceController.shared.container.viewContext
        do {
            //获取所有的Item
            learningWordList = try viewContext.fetch(fetchRequest)
        } catch {
            NSLog("Error fetching tasks: \(error)")
        }
    }
    
    func preloadLearningWordFromCSV() {
        let container = PersistenceController.shared.container
        let csvTool = CSVTools()
        
        var data = csvTool.readDataFromCSV(fileName: "IELTS_Words_wordonly", fileType: "csv")
        data = csvTool.cleanRows(file: data ?? "d")
        let csvRows = csvTool.csv(data: data ?? "d")
        let fetchRequest: NSFetchRequest<WordItem> = WordItem.fetchRequest()
        var testList:[WordItem] = []
        
        container.performBackgroundTask() { (context) in
            for i in 1 ..< 400 {  //有标题就从1开始，测试400个
                let word = LearningWordItem(context: context)
                var id = csvRows[i][0]
                id.removeFirst()
                word.wordID =  Int32(id) ?? 0// 去除最开始的引号
                word.wordContent = csvRows[i][1]
                
                let pre =  NSPredicate(format: "wordID == %@", "\(id)")
                fetchRequest.predicate = pre
                
                do {
                    //print(fetchRequest)
                    testList = try context.fetch(fetchRequest)
                    //print(testList)
                    if testList.count > 0 {
                        word.sourceWord = testList[0]  //id唯一
                    }
                } catch {
                    NSLog("Error fetching tasks: \(error)")
                }
                

            }
            do {
                context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
                try context.save()
                print("后台加载完成")
                //在主队列异步加载一次
                DispatchQueue.main.async {
                    self.getAllItems()
                    print("重新获取数据完成")
                }
            }
            catch {
                fatalError("Failure to save context: \(error)")
            }
        }
    }
    
    func deleteAll()  {
        let viewContext = PersistenceController.shared.container.viewContext
        let allItems = NSFetchRequest<NSFetchRequestResult>(entityName: "LearningWordItem")
        let delAllRequest = NSBatchDeleteRequest(fetchRequest: allItems)
         do {
            try viewContext.execute(delAllRequest)
            try viewContext.save()
            print("删除全部数据并保存")
//            saveToPersistentStore()
         }
         catch { print(error) }
    }
    
    //保存
    func saveToPersistentStore() {
        let viewContext = PersistenceController.shared.container.viewContext
        do {
            try viewContext.save()
            //getAllItems()
            print("完成保存")
        } catch {
            NSLog("Error saving managed object context: \(error)")
        }
    }
    
}
