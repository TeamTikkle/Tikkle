//
//  CustomButton.swift
//  Tikkle
//
//  Created by FUTURE on 2023/08/16.
//


import UIKit



/*
 
 Tikkle 앱에서 공통으로 사용하는 버튼들 정리한 class
 
 <사용 예시>
    let 버튼_상수명짓기 = CustomButton.makePrivateTrueButton()
    outlet한_버튼이름.addSubview(버튼_상수명짓기)
 */



class CustomButton: UIButton {
    
    static func makeButton(title: String, color: UIColor) -> UIButton {
        let button = CustomButton()
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 20)
        
        // 버튼의 텍스트 설정
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 14), // Bold 폰트 설정
            .foregroundColor: UIColor.black
        ]
        let attributedText = NSAttributedString(string: title, attributes: attributes)
        button.setAttributedTitle(attributedText, for: .normal)
        // 버튼의 색상 설정
        button.backgroundColor = color
        
        //버튼의 둥글기
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        
        return button
    }
    
    static func makePrivateTrueButton() -> UIButton {
        return makeButton(title: "비공개", color: UIColor.gray)
    }


    static func makePrivateFalseButton() -> UIButton {
        return makeButton(title: "공개", color: UIColor.mainColor)
    }
    
    
    static func makeTogetherButton() -> UIButton {
        return makeButton(title: "함께", color: UIColor.mainColor)
    }
    
    
    static func makeEditButton() -> UIButton {
        return makeButton(title: "편집", color: UIColor.mainColor)
    }
    
    
    static func makeHotButton() -> UIButton {
        return makeButton(title: "HOT", color: UIColor.white)
    }
    
    
    //티끌 생성 페이지에서 사용
    static func makePrivateFalseGrayButton() -> UIButton {
        return makeButton(title: "비공개", color: UIColor.subTitleColor)
    }
    
    
    //티끌 생성 페이지에서 사용
    static func makePrivateTrueGrayButton() -> UIButton {
        return makeButton(title: "공개", color: UIColor.subTitleColor)
    }
    
    
    //티끌 생성 페이지에서 사용
    static func tikkle30() -> UIButton {
        return makeButton(title: "30개", color: UIColor.subTitleColor)
    }
    
    
    //티끌 생성 페이지에서 사용
    static func tikkle60() -> UIButton {
        return makeButton(title: "60개", color: UIColor.subTitleColor)
    }
    
    //tikklesheet
    static func challengeButton() -> UIButton {
        return makeButton(title: "도전하기", color: UIColor.subTitleColor)
    }
    
}
