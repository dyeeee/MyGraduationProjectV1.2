//
//  LearningWordViewModel.swift
//  MyGraduationProjectV1
//
//  Created by YES on 2021/1/20.
//

import SwiftUI
import Foundation
import CoreData

class LearnWordViewModel: ObservableObject{
    @Published var allWordsToLearnList:[LearningWordItem] = []
    @Published var learningWordList:[LearningWordItem] = []
    @Published var knownWordList:[LearningWordItem] = []
    @Published var unlearnedWordList:[LearningWordItem] = []
    
    @Published var todayNewWordList:[LearningWordItem] = []
    @Published var todayReviewWordList:[LearningWordItem] = []
    
    var todayAllCount:Int = 1
    var todayNewCount:Int = 0
    var todayReviewCount:Int = 0
    
    init() {
        getAllItems()
        getKnownWordItems()
        getLearningWordItems()
        getUnlearnedWordItems()
    }
    
    func getTodayList(newWordNum:Int = 6,learnDayCount:Int) {
        getTodayNewWordItems(num:newWordNum,learnDayCount:learnDayCount)
        self.todayNewCount = todayNewWordList.count
        
        
        //getTodayReviewWordItems(learnDayCount: learnDayCount)
        //仅获取一个数量，真正把数据加载到视图中再nextCard_Learn中执行
        let fetchRequest: NSFetchRequest<LearningWordItem> = LearningWordItem.fetchRequest()
        let pre =  NSPredicate(format: "nextReviewDay == %@", "\(learnDayCount)") // pre会改为下次复习时间为今天的单词
        fetchRequest.predicate = pre
        let viewContext = PersistenceController.shared.container.viewContext
        do {
            self.todayReviewCount = try viewContext.fetch(fetchRequest).count
        } catch {
            NSLog("Error fetching tasks: \(error)")
        }
        
        self.todayAllCount = self.todayNewCount + self.todayReviewCount
        print("总量：\(todayAllCount)个，新词：\(todayNewCount)个，复习：\(todayReviewCount)个")
    }
    
    func getTodayNewWordItems(num:Int = 6,learnDayCount:Int) {
        let fetchRequest: NSFetchRequest<LearningWordItem> = LearningWordItem.fetchRequest()
        let sort = NSSortDescriptor(key: "wordContent", ascending: true,selector: #selector(NSString.caseInsensitiveCompare(_:)))
        let pre =  NSPredicate(format: "status == %@", "unlearned")
        fetchRequest.fetchLimit = num
        fetchRequest.predicate = pre
        fetchRequest.sortDescriptors = [sort]
        
        let viewContext = PersistenceController.shared.container.viewContext
        do {
            //获取所有的Item
            todayNewWordList = try viewContext.fetch(fetchRequest).reversed()
            for item in todayNewWordList{
                item.nextReviewDay = Int16(learnDayCount) //补充把下次复习时间添加为今天
            }
            saveToPersistentStore()
            //先执行这个函数获取要新学的，再执行要复习的
            print("新词加载完成,\(todayNewCount)个")
            showItems(list: todayNewWordList)
        } catch {
            NSLog("Error fetching tasks: \(error)")
        }
    }
    
    func getTodayReviewWordItems(learnDayCount:Int) {
        let fetchRequest: NSFetchRequest<LearningWordItem> = LearningWordItem.fetchRequest()
        let sort = NSSortDescriptor(key: "wordContent", ascending: true,selector: #selector(NSString.caseInsensitiveCompare(_:)))
        let pre =  NSPredicate(format: "nextReviewDay == %@", "\(learnDayCount)") // pre会改为下次复习时间为今天的单词
        fetchRequest.fetchLimit = 6
        fetchRequest.predicate = pre
        fetchRequest.sortDescriptors = [sort]
        
        let viewContext = PersistenceController.shared.container.viewContext
        do {
            //获取所有的Item
            todayReviewWordList = try viewContext.fetch(fetchRequest)
            for item in todayReviewWordList {
                item.todayReviewCount = 0
            }
            print("复习的词加载完成")
            //showItems(list: todayReviewWordList)
        } catch {
            NSLog("Error fetching tasks: \(error)")
        }
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
    
    func nextCard_Learn(item:LearningWordItem) {
        self.todayNewWordList.remove(at: 0)
        print("新词\(item.wordContent ?? "noContent")学习完成")
        self.showItems(list:self.todayNewWordList)
        //最后再来加载页面，优化性能表现。
        //复习的词也可以分批加载处理，后续再优化（先获取完整列表，再分批载入视图中）
        if todayNewWordList.count == 2 {
            DispatchQueue.main.asyncAfter(deadline:DispatchTime.now() + 0.1) {
                self.getTodayReviewWordItems(learnDayCount: 1)
            }
        }
    }
    
    func nextCard_Review(item:LearningWordItem) {
        self.todayReviewWordList.remove(at: 0)
        if item.todayReviewCount != 2{
            self.todayReviewWordList.append(item)
        }
        print("\(item.wordContent ?? "noContent")复习")
        //self.showItems(list:self.todayReviewWordList)
    }
    
    func showItems(list:[LearningWordItem]) {
        var tmp:[String] = []
        var tmp2:[Int16] = []
        for item in list {
            tmp.append(item.wordContent ?? "null")
            tmp2.append(item.nextReviewDay)
        }
        
        print(tmp)
        print(tmp2)
    }
    
    
}
