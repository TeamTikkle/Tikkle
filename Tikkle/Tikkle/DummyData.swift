//
//  DummyData.swift
//  Tikkle
//
//  Created by 김도현 on 2023/08/15.
//

import UIKit


struct DataList {
    //티끌 더미데이터
    static var list: [TikkleSheet] = [beer, tripInKoreaTikkle, climbingTikkle, tripOverseasTikkle]
}


let beer: TikkleSheet = TikkleSheet(image: UIImage(named: "beer"), title: "편의점 해외맥주 도장깨기", description: "편의점의 해외 맥주를 마셔보아요!", isSharedProject: true, stampList:  [
    Tikkle(title: "하이네켄", isCompletion: false),
    Tikkle(title: "버드와이저", isCompletion: false),
    Tikkle(title: "호가든로제", isCompletion: false),
    Tikkle(title: "써머스비", isCompletion: false),
    Tikkle(title: "칭타오", isCompletion: false),
    Tikkle(title: "삿포로", isCompletion: false),
    Tikkle(title: "아사히", isCompletion: false),
    Tikkle(title: "블랑로제", isCompletion: false),
    Tikkle(title: "스텔라", isCompletion: false),
    Tikkle(title: "칼스버그", isCompletion: false),
    Tikkle(title: "블루문", isCompletion: false),
    Tikkle(title: "구스아일랜드", isCompletion: false),
    Tikkle(title: "블랑", isCompletion: false),
])

 
let tripInKoreaTikkle: TikkleSheet = TikkleSheet(image: UIImage(named: "travel"), title: "꼭 가봐야 할 국내여행지", description: "국내 여행지를 돌아다녀 보아요!", isSharedProject: false, stampList: [
    Tikkle(title: "제주도", isCompletion: false),
    Tikkle(title: "강릉", isCompletion: false),
    Tikkle(title: "서울", isCompletion: false),
    Tikkle(title: "부산", isCompletion: false),
    Tikkle(title: "대전", isCompletion: false),
    Tikkle(title: "속초", isCompletion: false),
    Tikkle(title: "양평", isCompletion: false),
    Tikkle(title: "춘천", isCompletion: false),
    Tikkle(title: "영월", isCompletion: false),
    Tikkle(title: "여수", isCompletion: false),
    Tikkle(title: "서산", isCompletion: false),
    Tikkle(title: "광주", isCompletion: false),
])


let climbingTikkle = TikkleSheet(image: UIImage(named: "mountain"), title: "우리나라 등산코스 30곳 가보기", description: "국내에 여러 산들을 등산해보아요!", isSharedProject: false, stampList: [
    Tikkle(title: "지리산", isCompletion: false),
    Tikkle(title: "금강산", isCompletion: false),
    Tikkle(title: "계방산", isCompletion: false),
    Tikkle(title: "오대산", isCompletion: false),
    Tikkle(title: "덕유산", isCompletion: false),
    Tikkle(title: "한라산", isCompletion: false),
    Tikkle(title: "운악산", isCompletion: false),
    Tikkle(title: "삼악산", isCompletion: false),
    Tikkle(title: "백암산", isCompletion: false),
    Tikkle(title: "아차산", isCompletion: false),
    Tikkle(title: "운문산", isCompletion: false),
    Tikkle(title: "소백산", isCompletion: false),
    Tikkle(title: "내장산", isCompletion: false),
    Tikkle(title: "천마산", isCompletion: false),
    Tikkle(title: "설악산", isCompletion: false),
    Tikkle(title: "화악산", isCompletion: false),
])


let tripOverseasTikkle: TikkleSheet = TikkleSheet(image: UIImage(named: "plane"), title: "해외여행지 도장깨기", description: "해외 여행지를 돌아다녀 보아요!", isSharedProject: false, stampList: [
    Tikkle(title: "일본", isCompletion: false),
    Tikkle(title: "중국", isCompletion: false),
    Tikkle(title: "미국", isCompletion: false),
    Tikkle(title: "캐나다", isCompletion: false),
    Tikkle(title: "태국", isCompletion: false),
    Tikkle(title: "말레이시아", isCompletion: false),
    Tikkle(title: "필리핀", isCompletion: false),
    Tikkle(title: "싱가포르", isCompletion: false),
    Tikkle(title: "태국", isCompletion: false),
    Tikkle(title: "호주", isCompletion: false),
    Tikkle(title: "인도", isCompletion: false),
    Tikkle(title: "러시아", isCompletion: false),
    Tikkle(title: "우크라이나", isCompletion: false),
    Tikkle(title: "베트남", isCompletion: false),
    Tikkle(title: "로마", isCompletion: false),
    Tikkle(title: "프랑스", isCompletion: false),
    Tikkle(title: "스위스", isCompletion: false),
    Tikkle(title: "스웨덴", isCompletion: false),
    Tikkle(title: "터키", isCompletion: false),
    Tikkle(title: "뉴질랜드", isCompletion: false),
    Tikkle(title: "이집트", isCompletion: false),
    Tikkle(title: "인도네시아", isCompletion: false),
    Tikkle(title: "브라질", isCompletion: false),
    Tikkle(title: "체코", isCompletion: false),
    Tikkle(title: "영국", isCompletion: false),
    Tikkle(title: "잉글랜드", isCompletion: false),
    Tikkle(title: "아르엔티나", isCompletion: false),
])

//
struct DummyList {
    //티끌 더미데이터
    static var dummylist: [TikkleSheet] = [coding,morning]
}

let coding: TikkleSheet = TikkleSheet(image: UIImage(named: "coding"), title: "8월 한달동안 1일 1커밋하기", description: "하루에 한번 의미있는 커밋을 하겠다!", isSharedProject: true, stampList:  [


    Tikkle(title: "1일", isCompletion: true),
    Tikkle(title: "2일", isCompletion: true),
    Tikkle(title: "3일", isCompletion: true),
    Tikkle(title: "4일", isCompletion: true),
    Tikkle(title: "5일", isCompletion: true),
    Tikkle(title: "6일", isCompletion: true),
    Tikkle(title: "7일", isCompletion: true),
    Tikkle(title: "8일", isCompletion: true),
    Tikkle(title: "9일", isCompletion: true),
    Tikkle(title: "10일", isCompletion: true),
    Tikkle(title: "11일", isCompletion: true),
    Tikkle(title: "12일", isCompletion: true),
    Tikkle(title: "13일", isCompletion: true),
    Tikkle(title: "14일", isCompletion: true),
    Tikkle(title: "15일", isCompletion: true),
    Tikkle(title: "16일", isCompletion: true),
    Tikkle(title: "17일", isCompletion: true),
    Tikkle(title: "18일", isCompletion: true),
    Tikkle(title: "19일", isCompletion: true),
    Tikkle(title: "20일", isCompletion: true),
    Tikkle(title: "21일", isCompletion: false),
    Tikkle(title: "22일", isCompletion: false),
    Tikkle(title: "23일", isCompletion: false),
    Tikkle(title: "24일", isCompletion: false),
    Tikkle(title: "25일", isCompletion: false),
    Tikkle(title: "26일", isCompletion: false),
    Tikkle(title: "27일", isCompletion: false),
    Tikkle(title: "28일", isCompletion: false),
    Tikkle(title: "29일", isCompletion: false),
    Tikkle(title: "30일", isCompletion: false),
    Tikkle(title: "31일", isCompletion: false)

])

let coding2: TikkleSheet = TikkleSheet(image: UIImage(named: "coding"), title: "1일 1 커밋하기2222", description: "하루에 한번씩 커밋해보아요", isSharedProject: true, stampList:  [
    Tikkle(title: "1일", isCompletion: false),
    Tikkle(title: "2일", isCompletion: false),
    Tikkle(title: "3일", isCompletion: false),
    Tikkle(title: "4일", isCompletion: false),
    Tikkle(title: "5일", isCompletion: false)
])

let morning: TikkleSheet = TikkleSheet(image: UIImage(named: "morning"), title: "30일간 미라클 모닝 도전", description: "매일 6시 기상\n독서와 운동 꾸준히 해보기", isSharedProject: true, stampList:  [
    Tikkle(title: "1일", isCompletion: true),
    Tikkle(title: "2일", isCompletion: true),
    Tikkle(title: "3일", isCompletion: true),
    Tikkle(title: "4일", isCompletion: true),
    Tikkle(title: "5일", isCompletion: true),
    Tikkle(title: "6일", isCompletion: true),
    Tikkle(title: "7일", isCompletion: true),
    Tikkle(title: "8일", isCompletion: true),
    Tikkle(title: "9일", isCompletion: true),
    Tikkle(title: "10일", isCompletion: false),
    Tikkle(title: "11일", isCompletion: false),
    Tikkle(title: "12일", isCompletion: false),
    Tikkle(title: "13일", isCompletion: false),
    Tikkle(title: "14일", isCompletion: false),
    Tikkle(title: "15일", isCompletion: false),
    Tikkle(title: "16일", isCompletion: false),
    Tikkle(title: "17일", isCompletion: false),
    Tikkle(title: "18일", isCompletion: false),
    Tikkle(title: "19일", isCompletion: false),
    Tikkle(title: "20일", isCompletion: false),
    Tikkle(title: "21일", isCompletion: false),
    Tikkle(title: "22일", isCompletion: false),
    Tikkle(title: "23일", isCompletion: false),
    Tikkle(title: "24일", isCompletion: false),
    Tikkle(title: "25일", isCompletion: false),
    Tikkle(title: "26일", isCompletion: false),
    Tikkle(title: "27일", isCompletion: false),
    Tikkle(title: "28일", isCompletion: false),
    Tikkle(title: "29일", isCompletion: false),
    Tikkle(title: "30일", isCompletion: false),
    Tikkle(title: "31일", isCompletion: false)
])
