//
//  LearningWordItem+CoreDataProperties.swift
//  MyGraduationProjectV1
//
//  Created by YES on 2021/1/20.
//
//

import Foundation
import CoreData


extension LearningWordItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LearningWordItem> {
        return NSFetchRequest<LearningWordItem>(entityName: "LearningWordItem")
    }

    @NSManaged public var wordID: Int32
    @NSManaged public var wordContent: String?
    @NSManaged public var nextDateString: String?
    @NSManaged public var learnTimes: Int16
    @NSManaged public var sourceWord: WordItem?

}

extension LearningWordItem : Identifiable {

}
