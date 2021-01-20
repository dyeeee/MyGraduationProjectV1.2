//
//  DayContentViewModel.swift
//  MyCalendar
//
//  Created by YES on 2021/1/16.
//

import Foundation
import CoreData
import SwiftUI


class DayContentViewModel: ObservableObject{
    @Published var itemList:[DayContentItem] = []
    @Published var currentMonthList:[DayContentItem] = []
    @Published var dateStringList:[String] = []
    
        init() {
            getAllItems()
        }
    
    func getAllItems() {
        let fetchRequest: NSFetchRequest<DayContentItem> = DayContentItem.fetchRequest()
        //        let pre =  NSPredicate(format: "monthString == %@", "\(monthString)")
        //        fetchRequest.predicate = pre
        let viewContext = PersistenceController.shared.container.viewContext
        do {
            //获取所有的Item
            print("加载所有Item")
            itemList = try viewContext.fetch(fetchRequest)
            getDateStringList()
        } catch {
            NSLog("Error fetching tasks: \(error)")
        }
        
    }
    
    func getDateStringList(){
        print("获取日期字符串列表")
        for item in itemList {
            self.dateStringList.append(item.dateString ?? "")
            //print(item.dateString ?? "")
        }
    }
    
    func haveContent(dateString:String,isCurrentMonth:Bool = false) -> Bool {
        // 在全部数据中匹配
        if !isCurrentMonth {
            if self.dateStringList.contains(dateString) {
                return true
            }else{
                return false
            }
        }else {
            var resultItem:[String] = []
            for item in currentMonthList {
                resultItem.append(item.dateString ?? "")
            }
            if resultItem.contains(dateString) {
                return true
            }else{
                return false
            }
        }
    }
    
    func getCurrentMonthItems() {
        let fetchRequest: NSFetchRequest<DayContentItem> = DayContentItem.fetchRequest()
        let monthString = Date().dateToString(format: "yyyyMM")
        let pre =  NSPredicate(format: "monthString == %@", "\(monthString)")
        fetchRequest.predicate = pre
        let viewContext = PersistenceController.shared.container.viewContext
        do {
            //获取所有的Item
            currentMonthList = try viewContext.fetch(fetchRequest)
        } catch {
            NSLog("Error fetching tasks: \(error)")
        }
        print("获取当前月的数据")
    }
    
    
    func showContent(dateString:String) -> String {
        for item in itemList {
            if item.dateString == dateString {
                return item.detail ?? "null_1"
            }
        }
        return "null_2"
    }
    
    func createTestItem() {
        let container = PersistenceController.shared.container
        let viewContext = container.viewContext
        
        for i in 1..<10{
            let item = DayContentItem(context: viewContext)
            item.dateString = "2021010\(i)"
            item.monthString = "202101"
            item.done = true
            item.detail = "aaaaaa"
        }
        saveToPersistentStore()
        //保存后刷新
        getAllItems()
    }
    
    func createItem(dateString: String) {
        let monthString = dateString.prefix(6)
        let item = DayContentItem(context: PersistenceController.shared.container.viewContext)
        item.dateString = dateString
        item.monthString = String(monthString)
        item.done = true
        item.detail = "aaaaaa"
        saveToPersistentStore()
        getAllItems()
        //        getAllItems(monthString: String(monthString))
    }
    
    //保存
    func saveToPersistentStore() {
        let viewContext = PersistenceController.shared.container.viewContext
        do {
            try viewContext.save()
            print("完成保存")
        } catch {
            NSLog("Error saving managed object context: \(error)")
        }
    }
    
    func deleteAll()  {
        let viewContext = PersistenceController.shared.container.viewContext
        let allItems = NSFetchRequest<NSFetchRequestResult>(entityName: "DayContentItem")
        let delAllRequest = NSBatchDeleteRequest(fetchRequest: allItems)
        do {
            try viewContext.execute(delAllRequest)
            dateStringList = []
            print("删除全部数据")
            saveToPersistentStore()
        }
        catch { print(error) }
    }
}
