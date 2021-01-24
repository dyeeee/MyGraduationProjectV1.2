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
    @Published var allWordsToLearnList:[LearningWordItem] = []
    @Published var learningWordList:[LearningWordItem] = []
    @Published var knownWordList:[LearningWordItem] = []
    @Published var unlearnedWordList:[LearningWordItem] = []
    
    init() {
        getAllItems()
        getKnownWordItems()
        getLearningWordItems()
        getUnlearnedWordItems()
    }
    
    func getAllItems() {
        let fetchRequest: NSFetchRequest<LearningWordItem> = LearningWordItem.fetchRequest()
        let sort = NSSortDescriptor(key: "wordContent", ascending: true,selector: #selector(NSString.caseInsensitiveCompare(_:)))
        
        //fetchRequest.fetchLimit = 50
        //fetchRequest.predicate = pre
        fetchRequest.sortDescriptors = [sort]
        
        let viewContext = PersistenceController.shared.container.viewContext
        do {
            //获取所有的Item
            allWordsToLearnList = try viewContext.fetch(fetchRequest)
        } catch {
            NSLog("Error fetching tasks: \(error)")
        }
    }
    
    func getLearningWordItems() {
        let fetchRequest: NSFetchRequest<LearningWordItem> = LearningWordItem.fetchRequest()
        let sort = NSSortDescriptor(key: "wordContent", ascending: true,selector: #selector(NSString.caseInsensitiveCompare(_:)))
        let pre =  NSPredicate(format: "status == %@", "learning")
        
        //fetchRequest.fetchLimit = 50
        fetchRequest.predicate = pre
        fetchRequest.sortDescriptors = [sort]
        
        let viewContext = PersistenceController.shared.container.viewContext
        do {
            learningWordList = try viewContext.fetch(fetchRequest)
        } catch {
            NSLog("Error fetching tasks: \(error)")
        }
    }
    
    func getKnownWordItems() {
        let fetchRequest: NSFetchRequest<LearningWordItem> = LearningWordItem.fetchRequest()
        let sort = NSSortDescriptor(key: "wordContent", ascending: true,selector: #selector(NSString.caseInsensitiveCompare(_:)))
        let pre =  NSPredicate(format: "status == %@", "known")
        
        //fetchRequest.fetchLimit = 50
        fetchRequest.predicate = pre
        fetchRequest.sortDescriptors = [sort]
        
        let viewContext = PersistenceController.shared.container.viewContext
        do {
            knownWordList = try viewContext.fetch(fetchRequest)
        } catch {
            NSLog("Error fetching tasks: \(error)")
        }
    }
    
    func getUnlearnedWordItems() {
        let fetchRequest: NSFetchRequest<LearningWordItem> = LearningWordItem.fetchRequest()
        let sort = NSSortDescriptor(key: "wordContent", ascending: true,selector: #selector(NSString.caseInsensitiveCompare(_:)))
        let pre =  NSPredicate(format: "status == %@", "unlearned")
        
        //fetchRequest.fetchLimit = 50
        fetchRequest.predicate = pre
        fetchRequest.sortDescriptors = [sort]
        
        let viewContext = PersistenceController.shared.container.viewContext
        do {
            unlearnedWordList = try viewContext.fetch(fetchRequest)
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
            for i in 1 ..< 401 {  //有标题就从1开始，测试400个
                let word = LearningWordItem(context: context)
                var id = csvRows[i][0]
                id.removeFirst()
                word.wordID =  Int32(id) ?? 0// 去除最开始的引号
                var content = csvRows[i][1]
                content.removeLast()
                word.wordContent = content
                
                //print("doing \(word.wordID)")
                if i < 100{
                    word.status = "unlearned"
                }else if i < 200{
                    word.status = "learning"
                }else if i < 300{
                    word.status = "known"
                }else{
                    word.status = "unlearned"
                }
                word.reviewTimes = 0
                word.nextReviewDay = 0
                
                //关联单词对象
                let pre =  NSPredicate(format: "wordID == %@", "\(id)")
                fetchRequest.predicate = pre
                
                do {
                    //print(id)
                    testList = try context.fetch(fetchRequest)
                    //print(testList)
                    if testList.count > 0 {
                        word.sourceWord = testList[0]  //id唯一
                        print("get\(i)")
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
                    self.getKnownWordItems()
                    self.getLearningWordItems()
                    self.getUnlearnedWordItems()
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
            saveToPersistentStore()
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
