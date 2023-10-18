//
//  TikkleSheetEntity+CoreDataProperties.swift
//  Tikkle
//
//  Created by 김도현 on 2023/10/18.
//
//

import Foundation
import CoreData
import UIKit


extension TikkleSheetEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TikkleSheetEntity> {
        return NSFetchRequest<TikkleSheetEntity>(entityName: "TikkleSheetEntity")
    }

    @NSManaged public var createDate: Date?
    @NSManaged public var image: Data?
    @NSManaged public var sheetDescription: String?
    @NSManaged public var title: String?
    @NSManaged public var uuid: UUID?
    @NSManaged public var stampList: NSOrderedSet?

}

// MARK: Generated accessors for stampList
extension TikkleSheetEntity {

    @objc(insertObject:inStampListAtIndex:)
    @NSManaged public func insertIntoStampList(_ value: TikkleEntity, at idx: Int)

    @objc(removeObjectFromStampListAtIndex:)
    @NSManaged public func removeFromStampList(at idx: Int)

    @objc(insertStampList:atIndexes:)
    @NSManaged public func insertIntoStampList(_ values: [TikkleEntity], at indexes: NSIndexSet)

    @objc(removeStampListAtIndexes:)
    @NSManaged public func removeFromStampList(at indexes: NSIndexSet)

    @objc(replaceObjectInStampListAtIndex:withObject:)
    @NSManaged public func replaceStampList(at idx: Int, with value: TikkleEntity)

    @objc(replaceStampListAtIndexes:withStampList:)
    @NSManaged public func replaceStampList(at indexes: NSIndexSet, with values: [TikkleEntity])

    @objc(addStampListObject:)
    @NSManaged public func addToStampList(_ value: TikkleEntity)

    @objc(removeStampListObject:)
    @NSManaged public func removeFromStampList(_ value: TikkleEntity)

    @objc(addStampList:)
    @NSManaged public func addToStampList(_ values: NSOrderedSet)

    @objc(removeStampList:)
    @NSManaged public func removeFromStampList(_ values: NSOrderedSet)

}

extension TikkleSheetEntity : Identifiable {
    var toStruct: TikkleSheet {
        var tikkleList = [Tikkle]()
        if let stampList {
            tikkleList = stampList.array.compactMap { $0 as? [TikkleEntity] }.flatMap { $0 }.compactMap { $0.toStruct }
        } else {
            tikkleList = []
        }
        return TikkleSheet(image: UIImage(data: self.image ?? Data()), title: self.title ?? "", description: self.sheetDescription ?? "", stampList: tikkleList)
    }
}
