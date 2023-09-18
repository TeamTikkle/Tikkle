//
//  Tikkle.swift
//  Tikkle
//
//  Created by 김도현 on 2023/08/15.
//
import Foundation
import UIKit

class TikkleSheet {
    let id: UUID = UUID() //id는 바뀌면 안되니 let
    var image: UIImage?
    var title: String
    var description: String
    var isSharedProject: Bool
    var stampList: [Tikkle]
    var createDate: Date = Date()
    //MARK: - 연산프로퍼티!!!
    var tikkleCompleted: Bool {
        return stampList.filter{ $0.isCompletion }.count == stampList.count
    }
    //전체에서 완료될걸 뺴라
    init(image: UIImage? = nil, title: String, description: String, isSharedProject: Bool, stampList: [Tikkle]) {
        self.image = image
        self.title = title
        self.description = description
        self.stampList = stampList
        self.isSharedProject = isSharedProject
    }
}
