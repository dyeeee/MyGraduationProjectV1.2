//
//  WordItem+CoreDataProperties.swift
//  MyGraduationProjectV1
//
//  Created by YES on 2021/1/20.
//
//

import Foundation
import CoreData


extension WordItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WordItem> {
        return NSFetchRequest<WordItem>(entityName: "WordItem")
    }

    @NSManaged public var bncLevel: Int16
    @NSManaged public var collinsLevel: Int16
    @NSManaged public var definition: String?
    @NSManaged public var exampleSentences: String?
    @NSManaged public var frqLevel: Int16
    @NSManaged public var historyCount: Int16
    @NSManaged public var latestSearchDate: Date?
    @NSManaged public var oxfordLevel: Int16
    @NSManaged public var phonetic_EN: String?
    @NSManaged public var phonetic_US: String?
    @NSManaged public var starLevel: Int16
    @NSManaged public var translation: String?
    @NSManaged public var wordContent: String?
    @NSManaged public var wordExchanges: String?
    @NSManaged public var wordID_UUID: UUID?
    @NSManaged public var wordNote: String?
    @NSManaged public var wordTags: String?
    @NSManaged public var wordID: Int32
    @NSManaged public var learningState: LearningWordItem?
    
    
}

extension WordItem : Identifiable {

}
