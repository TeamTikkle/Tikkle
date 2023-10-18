//
//  Stamp.swift
//  Tikkle
//
//  Created by 김도현 on 2023/08/15.
//
import Foundation
import UIKit

class Tikkle {
    let id: UUID
    var title: String
    var image: UIImage?
    var isCompletion: Bool
    
    init(id: UUID = UUID(), title: String, image: UIImage? = nil, isCompletion: Bool) {
        self.id = id
        self.title = title
        self.image = image
        self.isCompletion = isCompletion
    }
}
