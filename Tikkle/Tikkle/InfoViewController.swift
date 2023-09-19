//
//  MyPageViewController.swift
//  Tikkle
//
//  Created by 김도현 on 2023/08/15.
//

import UIKit

class InfoViewController: UIViewController {
    
    var tikkleSheet: TikkleSheet?
    var tikkleList: TikkleListManager = TikkleListManager()
    
    @IBOutlet weak var myPageMyImg: UIImageView!
    @IBOutlet weak var myPageMyIDLabel: UILabel!
    @IBOutlet weak var myPageMyEditBtn: UIButton!
    
    @IBOutlet weak var ingTikkleView: UIView!
    @IBOutlet weak var ingTikkleCountLabel: UILabel!
    @IBOutlet weak var doneTikkleView: UIView!
    @IBOutlet weak var doneTikkleCountLabel: UILabel!
    
    @IBOutlet weak var MyPageTableView: UITableView!
    
    //MARK: - MyPage 더미데이터
    let menuIcon: [UIImage?] = [
        UIImage(named: "heart.png"),
        UIImage(named: "vector.png"),
        UIImage(named: "setting.png"),
        UIImage(named: "contract.png"),
        UIImage(named: "email.png")
    ]
    var menu: [String] = ["내가 찜한 티끌판", "친구 초대", "앱 설정", "서비스 약관", "기능 추가 요청"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myInfoStyle()
        countViewStyle()
        MyPageTableView.delegate = self
        MyPageTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //MARK: - tikkleList.completList 개수가 나오면 되는거기는 한데... 어찌 처리해야하는거지???
        ingTikkleCountLabel.text = String("\(tikkleList.getTikkleList().count - tikkleList.completList().count)개")
        doneTikkleCountLabel.text = String("\(tikkleList.completList().count)개")
    }
    
    //MARK: - MyPage info 커스텀
    func myInfoStyle() {
        myPageMyImg.image = UIImage(named: "TikkleON.png")
        myPageMyIDLabel.text = "티끌이"
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16, weight: .bold), // semibold 굵기 설정
            .foregroundColor: UIColor.black
        ]
        let attributedText = NSAttributedString(string: "편집", attributes: attributes)
        myPageMyEditBtn.setAttributedTitle(attributedText, for: .normal)
        myPageMyEditBtn.backgroundColor = UIColor.mainColor
        myPageMyEditBtn.layer.cornerRadius = 10
        
    }
    
    //MARK: - MyPage count view 커스텀
    func countViewStyle() {
        ingTikkleView.layer.borderWidth = 1.0
        ingTikkleView.layer.borderColor = UIColor.gray.cgColor
        ingTikkleView.layer.cornerRadius = 30
        ingTikkleView.layer.masksToBounds = true
        
        //MARK: - tikkleList.completList 개수가 나오면 되는거기는 한데... 어찌 처리해야하는거지???
        ingTikkleCountLabel.text = String("\(tikkleList.getTikkleList().count - tikkleList.completList().count)개")
    
        doneTikkleView.layer.borderWidth = 1.0
        doneTikkleView.layer.borderColor = UIColor.gray.cgColor
        doneTikkleView.layer.cornerRadius = 30
        doneTikkleView.layer.masksToBounds = true
        
        //MARK: - tikkleList.completList 개수가 나오면 되는거기는 한데... 어찌 처리해야하는거지???
        doneTikkleCountLabel.text = String("\(tikkleList.completList().count)개")
    }
    
}

//MARK: - MyPage TableView Setting
extension InfoViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MypageTableViewCell", for: indexPath) as? InfoTableViewCell else {
            return UITableViewCell()
        }
        
        cell.mypageMenuImg.image = menuIcon[indexPath.row]
        cell.mypageMenuLabel.text = menu[indexPath.row]
        return cell
    }
}
