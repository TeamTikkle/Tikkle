//
//  Reuseable.swift
//  Tikkle
//
//  Created by 김도현 on 2023/09/18.
//

protocol Reusable {
    static var identifier: String { get }
}

extension Reusable {
    static var identifier: String { "\(self)" }
}
