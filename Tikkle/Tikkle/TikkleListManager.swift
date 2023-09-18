//
//  TikkleListManager.swift
//  Tikkle
//
//  Created by FUTURE on 2023/08/18.
//

import Foundation

//MARK: -데이터매니저
class TikkleListManager {
    
    private static var tikkleList: [TikkleSheet] = []
    
    //빈 배열에 더미데이터 추가
    func makeTikkleListDatas() {
        TikkleListManager.tikkleList = DataList.list
    }
    
    //전체 티끌판 리스트를 리턴해주는 함수
    func getTikkleList() -> [TikkleSheet] {
        return TikkleListManager.tikkleList
    }
    
    //이름으로 특정 리스트를 리턴해주는 함수
    func getTikkle(where id: UUID) -> TikkleSheet? {
        return TikkleListManager.tikkleList.first { $0.id == id }
    }
    
    
    //새로운 티끌판 만들기
    func addTikkle(_ tikkle: TikkleSheet) {
        TikkleListManager.tikkleList.append(tikkle)
    }
    
    
    //기존 티끌판 정보 업데이트
    func updateTikkleInfo(index: Int, _ tikkle: TikkleSheet) {
        if let index = TikkleListManager.tikkleList.firstIndex(where: { $0.id == tikkle.id }) {
            TikkleListManager.tikkleList[index] = tikkle
        }
    }
    
    //티끌판 이름으로 해당 티끌판 삭제
    func deleteTikkle(where id: UUID) {
        guard let index = TikkleListManager.tikkleList.firstIndex(where: { $0.id == id }) else { return }
        let stampList = TikkleListManager.tikkleList[index].stampList
        for stamp in stampList {
            stamp.isCompletion = false
        }
        TikkleListManager.tikkleList.removeAll { $0.id == id }
    }
    
    //MARK: - 완료 리스트
    func completList() -> [TikkleSheet] {
        return TikkleListManager.tikkleList.filter{ $0.tikkleCompleted == true }
    }
    
    //subscript : 객체의 내부 요소에 접근할 수 있는 짧은 경로(shortcut)를 제공하는 문법
    //사용 법 : 특정 티끌판 리턴해야 할 때 [tikkleListManager.getTikkleList() 대신에 사용]
    subscript(index: Int) -> TikkleSheet {
        get {
            return TikkleListManager.tikkleList[index]
        }
        set {
            TikkleListManager.tikkleList[index] = newValue
        }
    }
}
