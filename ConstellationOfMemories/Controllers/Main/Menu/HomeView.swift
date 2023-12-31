//
//  HomeHeader.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/17.
//

import UIKit
import FirebaseAuth

final class HomeView: UIView {
    
    // MARK: - Properties
// [DB_Data]
    var backgroundData: HaveImg? {
        didSet { self.homeFirstView.backgroundData = self.backgroundData }
    }
    
    var imageFont : UserImgFont? {
        didSet {
            if let user = self.imageFont {
                // img 바꾸기
                self.imgString = [user.dawnImg,
                                  user.morningImg,
                                  user.sunsetImg,
                                  user.nightImg]
                // font 바꾸기
                self.fontInt = [user.dawnFont,
                                user.morningFont,
                                user.sunsetFont,
                                user.nightFont]
                
                self.homeFirstView.firstCollection.reloadData()
            }
        }
    }
// [Img_Font_Data]
    // 서버에 저장되어 있는 user의 시간별 Image_String
    private var imgString: [String] = ["100", "200", "300", "400"]
    // 서버에 저장되어 있는 user의 시간별 Font_Int
    private var fontInt: [Int] = [-1, -1, -1, -1]
    
    private var temporaryFont: Int = -1
    private var temporaryImg: String = "100"

    
// [Segement_Value_Changed]
    // segement 선택 시 해당 변수가 바뀜 -> 이미지 바꿈
    private var topSegementValue: Int = 0 {
        didSet {
            // Background_Image 바꾸기 (원상복구)
            self.homeImageChange(indexString: self.imgString[self.topSegementValue])
            // Font_Color 바꾸기
            self.homeFontChange(Int_index: self.fontInt[self.topSegementValue])
            // right_Button 숨기기
            self.homeHeaderDelegaet?.hideRightBtn()
        }
    }
    
    
    
// [Delegate]
    // Home_Main_Delegate
    var homeMainDelegate: HomeMainDelegate?
    // home_HeaderView_Delegate
    var homeHeaderDelegaet: homeHeaderViewDelegate?
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
// MARK: - Header
    // UISegmentedControl
    private lazy var headerSegment: UISegmentedControl = {
        let control = UISegmentedControl(items: ["새벽", "아침", "노을", "밤"])
            // segment 배경색 (비 선택창)
            control.backgroundColor = .clear
            // segement 선택창 배경 색
            control.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor : UIColor.white], for: .normal)
        
            control.selectedSegmentTintColor = UIColor(white: 1, alpha: 0.3)
        
            control.selectedSegmentIndex = 0
            control.addTarget(self, action: #selector(self.valueChanged(segment:)), for: .valueChanged)
            
        return control
    }()
    
    private lazy var homeView: UIView = {
        return UIView().viewConfig(backgroundColor: UIColor(white: 1, alpha: 0.3))
    }()
    
    
    
    // MARK: - Main_View
    private lazy var mainImg: UIImageView = {
        return UIImageView(image: UIImage(named: "100"))
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
        return UIImageView(image: UIImage(named: "100"))
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
        return UIImageView(image: UIImage(named: "100"))
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
    
    
    
// MARK: - Bottom
    lazy var bottomsegement: UISegmentedControl = {
        let control = UISegmentedControl(items: ["배경 화면", "글자 색상"])
            // segment 배경색 (비 선택창)
            control.backgroundColor = .clear
            // segement 선택창 배경 색
            control.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor : UIColor.white], for: .normal)
        
            control.selectedSegmentTintColor = UIColor(white: 1, alpha: 0.3)
        
            control.selectedSegmentIndex = 0
            control.addTarget(self, action: #selector(self.homeSegmentedChanged(segment:)), for: .valueChanged)
            
        return control
    }()
    
    
    
    // MARK: - Collection_View
    private lazy var homeSecondView: HomeSecondView = {
        let frame = CGRect(x: self.frame.width,
                           y: 305,
                           width: self.frame.width,
                           height: self.frame.height - 455)
        let view = HomeSecondView(frame: frame)
            view.secondHomeDelegate = self
        return view
    }()
    private lazy var homeFirstView: HomeFirstView = {
        let frame = CGRect(x: 0,
                           y: 305,
                           width: self.frame.width,
                           height: self.frame.height - 455)
        let view = HomeFirstView(frame: frame)
            view.firstHomeDelegate = self
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
        self.addSubview(self.homeSecondView)
        // homeSecondCollection
        self.addSubview(self.homeFirstView)
        
        
        
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
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
// MARK: - Helper Functions
    func resetHomeView() {
        // [Top_Segement]
        self.headerSegment.selectedSegmentIndex = 0
        self.topSegementValue = 0
        
        // [Bottom_Segement]
        self.firstViewShow(show: true)
        self.bottomsegement.selectedSegmentIndex = 0
        self.homeFirstView.currentTime = .dawn
        self.homeFirstView.upCollectionView()
    }
    
    
    
    // MARK: - Image
    private func homeImageChange(indexString: String) {
        // 이미지 바꾸기
        self.mainImg.image = UIImage(named: indexString)
        self.diaryTableImg.image = UIImage(named: indexString)
        self.diaryViewImg.image = UIImage(named: indexString)
        // 이미지 임시저장
        self.temporaryImg = indexString
    }

    
    
    // MARK: - Font
    private func homeFontChange(Int_index: Int = 1, UI_color: UIColor? = nil) {
        let color = UI_color != nil
            ? UI_color ?? .white
            : fontColor(index: Int_index)
        
        // Main_View
        self.mainLbl.textColor = color
        self.menuButton.tintColor = color
        self.moonButton.tintColor = color
        
        // Diary_Table
        self.backButton1.tintColor = color
        self.diaryTableLbl.textColor = color
        
        self.diaryTable1.textColor = color
        self.diaryTable2.textColor = color
        self.diaryTable3.textColor = color
        
        self.diaryTable1.layer.borderColor = color.cgColor
        self.diaryTable2.layer.borderColor = color.cgColor
        self.diaryTable3.layer.borderColor = color.cgColor
        
        // Diary_View
        self.diaryViewLbl.textColor = color
        self.viewTitleLbl.textColor = color
        self.separatorView.backgroundColor = color
        self.textView.textColor = color
        self.backButton2.tintColor = color
        
        // 폰트 임시저장
        self.temporaryFont = Int_index
    }
    
    // MARK: - Font_DB
    func homeColor(_ color: UIColor) {
        self.headerSegment.setTitleTextAttributes(
            [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14),
             NSAttributedString.Key.foregroundColor : color], for: .normal)
        self.bottomsegement.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14),
            NSAttributedString.Key.foregroundColor : color], for: .normal)
        
        self.homeFontChange(UI_color: color)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: - Selectors
    @objc private func valueChanged(segment: UISegmentedControl) {
        switch segment.selectedSegmentIndex {
        case 0:
            self.topSegementValue = 0
            self.homeFirstView.currentTime = .dawn
            
        case 1:
            self.topSegementValue = 1
            self.homeFirstView.currentTime = .morning
            
        case 2:
            self.topSegementValue = 2
            self.homeFirstView.currentTime = .sunset
            
        case 3:
            self.topSegementValue = 3
            self.homeFirstView.currentTime = .night
            
        default:
            self.topSegementValue = 0
            self.homeFirstView.currentTime = .dawn
        }
    }
    
    
    @objc private func homeSegmentedChanged(segment: UISegmentedControl) {
        segment.selectedSegmentIndex == 0
            ? self.firstViewShow(show: true)
            : self.firstViewShow(show: false)
    }
    private func firstViewShow(show: Bool) {
        if show == true {
            UIView.animate(withDuration: 0.5) {
                // first 보이게 하기
                self.homeFirstView.alpha = 1
                self.homeFirstView.frame.origin.x = 0
                // second 숨기기
                self.homeSecondView.alpha = 0
                self.homeSecondView.frame.origin.x = self.frame.width
            }
            
            
        } else {
            UIView.animate(withDuration: 0.5) {
                // first 숨기기
                self.homeFirstView.alpha = 0
                self.homeFirstView.frame.origin.x = -self.frame.width
                // second 보이게 하기
                self.homeSecondView.alpha = 1
                self.homeSecondView.frame.origin.x = 0
            }
        }
    }
}












// MARK: - Delegate
extension HomeView: SecondHomeDelegate, FirstHomeDelegate {
    func homeSecondTapped(index: Int) {
        // right_Button 생기게 함
        self.homeHeaderDelegaet?.showCheckRightBtn()
        // 폰트 바꾸기
        self.homeFontChange(Int_index: index)
    }
    
    func homeFirstTapped(index: Int, backgroundImg: HaveImg) {
        // right_Button 생기게 함
        self.homeHeaderDelegaet?.showCheckRightBtn()
        
        // String
        var indexString: String = ""
        // 다른 segement를 누르면 초기화
        switch self.topSegementValue {
        case 0: indexString = String(backgroundImg.havedawn[index])
        case 1: indexString = String(backgroundImg.haveMorning[index])
        case 2: indexString = String(backgroundImg.haveSunset[index])
        case 3: indexString = String(backgroundImg.haveNight[index])
            
        default: indexString = String(backgroundImg.havedawn[index])
        }
        // home_Header의 이미지 바꾸기
        self.homeImageChange(indexString: indexString)
    }
}



// DB업데이트
extension HomeView: HeaderHomeDelegate {
    func checkButtonTapped() {
        // right_Button을 누르면
            // -> db에 저장
            // -> user에 저장
        var currentTime: CurrentTime = .dawn
        
        switch self.topSegementValue {
        case 0:
            currentTime = .dawn
            self.fontInt[0] = self.temporaryFont
            self.imgString[0] = self.temporaryImg
        case 1:
            currentTime = .morning
            self.fontInt[1] = self.temporaryFont
            self.imgString[1] = self.temporaryImg
        case 2:
            currentTime = .sunset
            self.fontInt[2] = self.temporaryFont
            self.imgString[2] = self.temporaryImg
        case 3:
            currentTime = .night
            self.fontInt[3] = self.temporaryFont
            self.imgString[3] = self.temporaryImg
        default:
            currentTime = .dawn
            self.fontInt[0] = self.temporaryFont
            self.imgString[0] = self.temporaryImg
        }
        
        
        // Delegate + DB_Update
            // Font / Image - Change
            // DB_Update -Font & Image
        self.homeMainDelegate?.imgChanged(currentTime: currentTime,
                                          img: self.temporaryImg,
                                          font: self.temporaryFont)
        // right_Button 숨기기
        self.homeHeaderDelegaet?.hideRightBtn()
    }
}
