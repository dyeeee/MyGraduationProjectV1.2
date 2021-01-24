//
//  LearningWordItem+CoreDataProperties.swift
//  MyGraduationProjectV1
//
//  Created by YES on 2021/1/22.
//
//

import Foundation
import CoreData


extension LearningWordItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LearningWordItem> {
        return NSFetchRequest<LearningWordItem>(entityName: "LearningWordItem")
    }

    @NSManaged public var reviewTimes: Int16
    @NSManaged public var nextReviewDateString: String?
    @NSManaged public var wordContent: String?
    @NSManaged public var wordID: Int32
    @NSManaged public var status: String?
    @NSManaged public var nextReviewDay: Int16 //下一次复习是在学习周期的第几天
    @NSManaged public var listID: Int16
    @NSManaged public var sourceWord: WordItem?

}

extension LearningWordItem : Identifiable {

}
