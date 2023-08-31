//
//  HomeHeader.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/17.
//

import UIKit

final class HomeView: UIView {
    
    // MARK: - Properties
    var user : User? {
        didSet {
            guard let user = self.user else { return }
            self.imgString = [user.dawn, user.morning, user.sunset, user.night]
            // 첫 화면을 0으로 설정
            self.segmentValue = 0
        }
    }
    var backgroundData: BackgroundImg? {
        didSet {
            homeSecondCollection.backgroundData = self.backgroundData
        }
    }
    
    
    
    // header_View
    private let headerView = HeaderView.shared
    
    
    
    // 서버에 저장되어 있는 user의 시간별 background_Image
    var imgString: [String] = ["blueSky"]
    
    
    
    // segement 선택 시 해당 변수가 바뀜 -> 이미지 바꿈
    private var segmentValue: Int = 0 {
        didSet {
            // Background_Image 바꾸기
            self.mainImg.image = UIImage(named: self.imgString[self.segmentValue])
            self.diaryTableImg.image = UIImage(named: self.imgString[self.segmentValue])
            self.diaryViewImg.image = UIImage(named: self.imgString[self.segmentValue])
        }
    }
    
    
    
    
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
// MARK: - Header
    // UISegmentedControl
    lazy var headerSegment: UISegmentedControl = {
        let control = UISegmentedControl(items: ["새벽", "아침", "노을", "밤"])
            // segment 배경색 (비 선택창)
            control.backgroundColor = .clear
            // segement 선택창 배경 색
            control.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor : UIColor.white], for: .normal)
        
            control.selectedSegmentTintColor = UIColor(white: 1, alpha: 0.3)
        
            control.selectedSegmentIndex = 0
            control.addTarget(self, action: #selector(valueChanged(segment:)), for: .valueChanged)
            
        return control
    }()
    
    private lazy var homeView: UIView = {
        return UIView().viewConfig(backgroundColor: UIColor(white: 1, alpha: 0.3))
    }()
    
    
    
    // MARK: - Main_View
    private lazy var mainImg: UIImageView = {
        return UIImageView(image: UIImage(named: "dawn1"))
    }()
    private lazy var mainLbl: UILabel = {
        return UILabel().labelConfig(labelText: "추억 일기",
                               LabelTextColor: UIColor.white,
                               fontName: .bold,
                               fontSize: 10)
    }()
    private lazy var menuButton: UIButton = {
        return UIButton().buttonSustemImage(btnSize: 10, imageString: .menu)
    }()
    private lazy var moonButton: UIButton = {
        return UIButton().buttonSustemImage(btnSize: 10, imageString: .moon)
    }()
    
    
    
    // MARK: - Diary_Table
    private lazy var diaryTableImg: UIImageView = {
        return UIImageView(image: UIImage(named: "dawn1"))
    }()
    private lazy var backButton1: UIButton = {
        return UIButton().buttonSustemImage(btnSize: 10, imageString: .back)
    }()
    private lazy var diaryTableLbl: UILabel = {
        return UILabel().labelConfig(labelText: "일기 목록",
                               LabelTextColor: UIColor.white,
                               fontName: .bold,
                               fontSize: 10)
    }()
    private lazy var diaryTable1: UILabel = {
        return UILabel().homeMiniDiary(title: "오늘 떠올린 추억")
    }()
    private lazy var diaryTable2: UILabel = {
        return UILabel().homeMiniDiary(title: "어제 떠올린 추억")
    }()
    private lazy var diaryTable3: UILabel = {
        return UILabel().homeMiniDiary(title: "그저께 떠올린 추억")
    }()
    
    
    
    // MARK: - Diary_View
    private lazy var diaryViewImg: UIImageView = {
        return UIImageView(image: UIImage(named: "dawn1"))
    }()
    private lazy var diaryViewLbl: UILabel = {
        return UILabel().labelConfig(labelText: "일기 작성",
                               LabelTextColor: UIColor.white,
                               fontName: .bold,
                               fontSize: 10)
    }()
    private lazy var viewTitleLbl: UILabel = {
        return UILabel().labelConfig(labelText: "오늘의 하루는 어땠나요?",
                                     LabelTextColor: .white,
                                     fontSize: 8)
    }()
    private lazy var separatorView: UIView = {
        return UIView().viewConfig(backgroundColor: UIColor.white)
    }()
    private lazy var textView: UILabel = {
        return UILabel().labelConfig(labelText: "오늘 하루는...",
                                     LabelTextColor: .white,
                                     fontSize: 8)
    }()
    private lazy var backButton2: UIButton = {
        return UIButton().buttonSustemImage(btnSize: 10, imageString: .back)
    }()
    private lazy var shareButton: UIButton = {
        return UIButton().buttonSustemImage(btnSize: 10, imageString: .share)
    }()
    
    
    
// MARK: - Bottom
    lazy var bottomsegement: UISegmentedControl = {
        let control = UISegmentedControl(items: ["글자 색상", "배경 화면"])
            // segment 배경색 (비 선택창)
            control.backgroundColor = .clear
            // segement 선택창 배경 색
            control.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor : UIColor.white], for: .normal)
        
            control.selectedSegmentTintColor = UIColor(white: 1, alpha: 0.3)
        
            control.selectedSegmentIndex = 0
            control.addTarget(self, action: #selector(homeSegmentedChanged(segment:)), for: .valueChanged)
            
        return control
    }()
    
    
    
    // MARK: - Collection_View
    lazy var homeFirstcollection: HomeFirstView = {
        let frame = CGRect(x: 0,
                           y: 305,
                           width: self.frame.width,
                           height: self.frame.height - 455)
        let view = HomeFirstView(frame: frame)
            view.firstHomeDelegate = self
        return view
    }()
    lazy var homeSecondCollection: HomeSecondView = {
        let frame = CGRect(x: self.frame.width,
                           y: 305,
                           width: self.frame.width,
                           height: self.frame.height - 455)
        let view = HomeSecondView(frame: frame)
            view.secondHomeDelegate = self
        return view
    }()
    
    
    

    
    
    
    
    
    
    
    
    
    
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureHeader()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
    // MARK: - ConfigureUI
    private func configureHeader() {
        // self.alpha = 0
        self.alpha = 0
        // headerSegment
        self.addSubview(self.headerSegment)
        self.headerSegment.anchor(top: self.topAnchor,
                                  leading: self.leadingAnchor,
                                  trailing: self.trailingAnchor,
                                  height: 40)
        // homeView
        self.addSubview(self.homeView)
        self.homeView.anchor(top: self.headerSegment.bottomAnchor,
                             leading: self.leadingAnchor,
                             trailing: self.trailingAnchor,
                             height: 225)
        // bottomsegement
        self.addSubview(self.bottomsegement)
        self.bottomsegement.anchor(top: self.homeView.bottomAnchor,
                                   leading: self.leadingAnchor,
                                   trailing: self.trailingAnchor,
                                   height: 40)
        // homeFirstcollection
        self.addSubview(self.homeFirstcollection)
        // homeSecondCollection
        self.addSubview(self.homeSecondCollection)
        
        
        
        let width = (self.frame.width - 20) / 3
        
// Main_View
        // mainImg
        self.addSubview(self.mainImg)
        self.mainImg.anchor(top: self.homeView.topAnchor, paddingTop: 10,
                            bottom: self.homeView.bottomAnchor, paddingBottom: 10,
                            leading: self.homeView.leadingAnchor, paddingLeading: 5,
                            width: width)
        // mainLbl
        self.addSubview(self.mainLbl)
        self.mainLbl.anchor(top: self.mainImg.topAnchor, paddingTop: 10,
                            centerX: self.mainImg)
        // menuButton
        self.addSubview(self.menuButton)
        self.menuButton.anchor(leading: self.mainImg.leadingAnchor, paddingLeading: 10,
                               centerY: self.mainLbl)
        // moonButton
        self.addSubview(self.moonButton)
        self.moonButton.anchor(bottom: self.mainImg.bottomAnchor, paddingBottom: 10,
                               centerX: self.mainImg)
        
        
        
// Diary_Table
        // diaryTableImg
        self.addSubview(self.diaryTableImg)
        self.diaryTableImg.anchor(top: self.homeView.topAnchor, paddingTop: 10,
                                  bottom: self.homeView.bottomAnchor, paddingBottom: 10,
                                  leading: self.mainImg.trailingAnchor, paddingLeading: 5,
                                  width: width)
        // diaryTableLbl
        self.addSubview(self.diaryTableLbl)
        self.diaryTableLbl.anchor(top: self.diaryTableImg.topAnchor, paddingTop: 10,
                                  centerX: self.diaryTableImg)
        // backButton1
        self.addSubview(self.backButton1)
        self.backButton1.anchor(leading: self.diaryTableImg.leadingAnchor, paddingLeading: 10,
                                centerY: self.diaryTableLbl)
        // diaryTable1
        self.addSubview(self.diaryTable1)
        self.diaryTable1.anchor(top: self.diaryTableLbl.bottomAnchor, paddingTop: 10,
                                leading: self.diaryTableImg.leadingAnchor, paddingLeading: 10,
                                trailing: self.diaryTableImg.trailingAnchor, paddingTrailing: 10,
                                height: 30)
        // diaryTable2
        self.addSubview(self.diaryTable2)
        self.diaryTable2.anchor(top: self.diaryTable1.bottomAnchor, paddingTop: 10,
                                leading: self.diaryTableImg.leadingAnchor, paddingLeading: 10,
                                trailing: self.diaryTableImg.trailingAnchor, paddingTrailing: 10,
                                height: 30)
        // diaryTable3
        self.addSubview(self.diaryTable3)
        self.diaryTable3.anchor(top: self.diaryTable2.bottomAnchor, paddingTop: 10,
                                leading: self.diaryTableImg.leadingAnchor, paddingLeading: 10,
                                trailing: self.diaryTableImg.trailingAnchor, paddingTrailing: 10,
                                height: 30)
        
        
        
// Diary_View
        // diaryViewImg
        self.addSubview(self.diaryViewImg)
        self.diaryViewImg.anchor(top: self.homeView.topAnchor, paddingTop: 10,
                                 bottom: self.homeView.bottomAnchor, paddingBottom: 10,
                                 leading: self.diaryTableImg.trailingAnchor, paddingLeading: 5,
                                 width: width)
        // diaryViewLbl
        self.addSubview(self.diaryViewLbl)
        self.diaryViewLbl.anchor(top: self.diaryViewImg.topAnchor, paddingTop: 10,
                                 centerX: self.diaryViewImg)
        // backButton2
        self.addSubview(self.backButton2)
        self.backButton2.anchor(leading: self.diaryViewImg.leadingAnchor, paddingLeading: 10,
                                centerY: self.diaryViewLbl)
        // viewTitleLbl
        self.addSubview(self.viewTitleLbl)
        self.viewTitleLbl.anchor(top: self.diaryViewLbl.bottomAnchor, paddingTop: 10,
                                 centerX: self.diaryViewImg)
        // separatorView
        self.addSubview(self.separatorView)
        self.separatorView.anchor(top: self.viewTitleLbl.bottomAnchor, paddingTop: 5,
                                  leading: self.diaryViewImg.leadingAnchor, paddingLeading: 10,
                                  trailing: self.diaryViewImg.trailingAnchor, paddingTrailing: 10,
                                  height: 1.2)
        // textView
        self.addSubview(self.textView)
        self.textView.anchor(top: self.separatorView.bottomAnchor, paddingTop: 5,
                             leading: self.diaryViewImg.leadingAnchor, paddingLeading: 10,
                             trailing: self.diaryViewImg.trailingAnchor, paddingTrailing: 10,
                             height: 30)
        // shareButton
        self.addSubview(self.shareButton)
        self.shareButton.anchor(bottom: self.diaryViewImg.bottomAnchor, paddingBottom: 10,
                                centerX: self.diaryViewImg)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: - Helper Functions
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: - Selectors
    @objc private func valueChanged(segment: UISegmentedControl) {
        switch segment.selectedSegmentIndex {
        case 0:
            self.segmentValue = 0
            self.homeSecondCollection.currentTime = .dawn
            
        case 1:
            self.segmentValue = 1
            self.homeSecondCollection.currentTime = .morning
            
        case 2:
            self.segmentValue = 2
            self.homeSecondCollection.currentTime = .sunset
            
        case 3:
            self.segmentValue = 3
            self.homeSecondCollection.currentTime = .night
            
        default:
            self.segmentValue = 0
            self.homeSecondCollection.currentTime = .dawn
        }
    }
    
    
    @objc private func homeSegmentedChanged(segment: UISegmentedControl) {
        if segment.selectedSegmentIndex == 0 {
            UIView.animate(withDuration: 0.5) {
                // first 보이게 하기
                self.homeFirstcollection.alpha = 1
                self.homeFirstcollection.frame.origin.x = 0
                // second 숨기기
                self.homeSecondCollection.alpha = 0
                self.homeSecondCollection.frame.origin.x = self.frame.width
            }
            
            
        } else {
            UIView.animate(withDuration: 0.5) {
                // first 숨기기
                self.homeFirstcollection.alpha = 0
                self.homeFirstcollection.frame.origin.x = -self.frame.width * 2
                // second 보이게 하기
                self.homeSecondCollection.alpha = 1
                self.homeSecondCollection.frame.origin.x = 0
            }
        }
    }
}












// MARK: - Delegate
extension HomeView: FirstHomeDelegate, SecondHomeDelegate {
    func homeFirstTapped(index: Int) {
        print("\(#function) ---- \(index)")
        // right_Button 생기게 함
        self.headerView.rightButtonShow(.check)
            // right_Button을 누르면
                // -> db에 저장
                // -> user에 저장
        
        // 다른 segement를 누르면 초기화
        
    }
    
    func homeSecondTapped(index: Int) {
        print("\(#function) ---- \(index)")
        // right_Button 생기게 함
            // right_Button을 누르면
                // -> db에 저장
                // -> user에 저장
        
        // 다른 segement를 누르면 초기화
    }
}
