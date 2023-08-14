//
//  DummyData.swift
//  T!kkle
//
//  Created by 김도현 on 2023/08/15.
//

// 더미 데이터 생성 방법
// tikkleTitle: 티끌 제목, description: 티끌 설명, stampList: 도장 이름 문자열 ,는 무조건 넣어줘야함 (ex: "한라산, 관악산, 백두산")

class DummyDataCreator {
    static func create(tikkleTitle: String, description: String, stampTitleStr: String) -> Tikkle {
        let stampTitleList = stampTitleStr.replacingOccurrences(of: " ", with: "").split(separator: ",")
        var stampList = [Stamp]()
        for stampTitle in stampTitleList {
            stampList.append(Stamp(title: String(stampTitle), isCompletion: false))
        }
        
        return Tikkle(title: tikkleTitle, description: description, stampList: stampList)
    }
}

let beerTikkle: Tikkle = Tikkle(title: "편의점 해외 맥주 도장깨기", description: "편의점의 해외 맥주를 마셔보아요!", stampList: [
    Stamp(title: "하이네켄", isCompletion: false),
    Stamp(title: "버드와이저", isCompletion: false),
    Stamp(title: "호가든로제", isCompletion: false),
    Stamp(title: "써머스비", isCompletion: false),
    Stamp(title: "칭타오", isCompletion: false),
    Stamp(title: "삿포로", isCompletion: false),
    Stamp(title: "아사히", isCompletion: false),
    Stamp(title: "블랑로제", isCompletion: false),
    Stamp(title: "스텔라", isCompletion: false),
    Stamp(title: "칼스버그", isCompletion: false),
    Stamp(title: "블루문", isCompletion: false),
    Stamp(title: "구스아일랜드", isCompletion: false),
    Stamp(title: "블랑", isCompletion: false),
])
let tripInKoreaTikkle: Tikkle = Tikkle(title: "국내여행지 도장깨기", description: "국내 여행지를 돌아다녀 보아요!", stampList: [
    Stamp(title: "제주도", isCompletion: false),
    Stamp(title: "강릉", isCompletion: false),
    Stamp(title: "서울", isCompletion: false),
    Stamp(title: "부산", isCompletion: false),
    Stamp(title: "대전", isCompletion: false),
    Stamp(title: "속초", isCompletion: false),
    Stamp(title: "양평", isCompletion: false),
    Stamp(title: "춘천", isCompletion: false),
    Stamp(title: "영월", isCompletion: false),
    Stamp(title: "여수", isCompletion: false),
    Stamp(title: "서산", isCompletion: false),
    Stamp(title: "광주", isCompletion: false),
])
let climbingTikkle = Tikkle(title: "국내의 산 도장깨기", description: "국내에 여러 산들을 등산해보아요!", stampList: [
    Stamp(title: "지리산", isCompletion: false),
    Stamp(title: "금강산", isCompletion: false),
    Stamp(title: "계방산", isCompletion: false),
    Stamp(title: "오대산", isCompletion: false),
    Stamp(title: "덕유산", isCompletion: false),
    Stamp(title: "한라산", isCompletion: false),
    Stamp(title: "운악산", isCompletion: false),
    Stamp(title: "삼악산", isCompletion: false),
    Stamp(title: "백암산", isCompletion: false),
    Stamp(title: "아차산", isCompletion: false),
    Stamp(title: "운문산", isCompletion: false),
    Stamp(title: "소백산", isCompletion: false),
    Stamp(title: "내장산", isCompletion: false),
    Stamp(title: "천마산", isCompletion: false),
    Stamp(title: "설악산", isCompletion: false),
    Stamp(title: "화악산", isCompletion: false),
])
let tripOverseasTikkle: Tikkle = Tikkle(title: "해외여행지 도장깨기", description: "해외 여행지를 돌아다녀 보아요!", stampList: [
    Stamp(title: "일본", isCompletion: false),
    Stamp(title: "중국", isCompletion: false),
    Stamp(title: "미국", isCompletion: false),
    Stamp(title: "캐나다", isCompletion: false),
    Stamp(title: "태국", isCompletion: false),
    Stamp(title: "말레이시아", isCompletion: false),
    Stamp(title: "필리핀", isCompletion: false),
    Stamp(title: "싱가포르", isCompletion: false),
    Stamp(title: "태국", isCompletion: false),
    Stamp(title: "호주", isCompletion: false),
    Stamp(title: "인도", isCompletion: false),
    Stamp(title: "러시아", isCompletion: false),
    Stamp(title: "우크라이나", isCompletion: false),
    Stamp(title: "베트남", isCompletion: false),
    Stamp(title: "로마", isCompletion: false),
    Stamp(title: "프랑스", isCompletion: false),
    Stamp(title: "스위스", isCompletion: false),
    Stamp(title: "스웨덴", isCompletion: false),
    Stamp(title: "터키", isCompletion: false),
    Stamp(title: "뉴질랜드", isCompletion: false),
    Stamp(title: "이집트", isCompletion: false),
    Stamp(title: "인도네시아", isCompletion: false),
    Stamp(title: "브라질", isCompletion: false),
    Stamp(title: "체코", isCompletion: false),
    Stamp(title: "영국", isCompletion: false),
    Stamp(title: "잉글랜드", isCompletion: false),
    Stamp(title: "아르엔티나", isCompletion: false),
])
