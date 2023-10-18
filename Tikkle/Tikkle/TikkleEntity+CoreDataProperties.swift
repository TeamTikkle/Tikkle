//
//  TikkleEntity+CoreDataProperties.swift
//  Tikkle
//
//  Created by 김도현 on 2023/10/18.
//
//

import Foundation
import CoreData
import UIKit


extension TikkleEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TikkleEntity> {
        return NSFetchRequest<TikkleEntity>(entityName: "TikkleEntity")
    }

    @NSManaged public var image: Data?
    @NSManaged public var isCompletion: Bool
    @NSManaged public var title: String?
    @NSManaged public var uuid: UUID?
    @NSManaged public var tikkleSheet: TikkleSheetEntity?

}

extension TikkleEntity : Identifiable {
    var toStruct: Tikkle {
        return Tikkle(id: self.uuid ?? UUID(), title: self.title ?? "", image: UIImage(data: self.image ?? Data()), isCompletion: self.isCompletion)
    }
}
