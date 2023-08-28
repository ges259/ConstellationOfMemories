//
//  HomeHeader.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/17.
//

import UIKit

final class HomeHeader: UIView {
    
    // MARK: - Properties
    var user : User? {
        didSet {
            guard let user = self.user else { return }
            self.imgString = [user.dawn, user.morning, user.sunset, user.night]
            // 첫 화면을 0으로 설정
            self.segmentValue = 0
        }
    }
    
    
    var imgString: [String]?
    
    private var segmentValue: Int? {
        didSet {
            // 콜렉션뷰 리로드 (필수)
//            self.homeCollection.reloadData()
        }
    }
    
    
    
    
    // enum으로 교체
//    var configureView: String? {
//        didSet {
//            // backgroundImage 바꾸기
//
//            // titleLabel 글자 색 바꾸기
//
//            // leftButton / fotterButton tint 색 바꾸기
//
//        }
//    }
    
    
    
    
    
    // MARK: - Layout
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
    
    
    
    // MARK: - View
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
    
    
    
    
    
    
    
    

    
    
    
    
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureHeader()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    // MARK: - Helper Functions
    private func configureHeader() {
//        self.backgroundColor = .red
        // headerSegment
        self.addSubview(self.headerSegment)
        self.headerSegment.anchor(top: self.topAnchor,
                                  leading: self.leadingAnchor,
                                  trailing: self.trailingAnchor,
                                  height: 40)
        
        self.addSubview(self.homeView)
        self.homeView.anchor(top: self.headerSegment.bottomAnchor,
                             bottom: self.bottomAnchor,
                             leading: self.leadingAnchor,
                             trailing: self.trailingAnchor)
        
        let width = (self.frame.width - 20) / 3
//        let height = width / 9 * 16
        
        
        
        
        
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
        //
        self.addSubview(self.separatorView)
        self.separatorView.anchor(top: self.viewTitleLbl.bottomAnchor, paddingTop: 5,
                                  leading: self.diaryViewImg.leadingAnchor, paddingLeading: 10,
                                  trailing: self.diaryViewImg.trailingAnchor, paddingTrailing: 10,
                                  height: 1.5)
        //
        self.addSubview(self.textView)
        self.textView.anchor(top: self.separatorView.bottomAnchor, paddingTop: 5,
                             leading: self.diaryViewImg.leadingAnchor, paddingLeading: 10,
                             trailing: self.diaryViewImg.trailingAnchor, paddingTrailing: 10,
                             height: 30)
        //
        self.addSubview(self.shareButton)
        self.shareButton.anchor(bottom: self.diaryViewImg.bottomAnchor, paddingBottom: 10,
                                centerX: self.diaryViewImg)
    }
    
    
    
    
    
    
    
    
    // MARK: - Selectors
    @objc private func valueChanged(segment: UISegmentedControl) {
        switch segment.selectedSegmentIndex {
        case 0: self.segmentValue = 0
        case 1: self.segmentValue = 1
        case 2: self.segmentValue = 2
        default: self.segmentValue = 0
        }
    }
}



















//// MARK: - CollectionView
//extension HomeHeader: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 3
//    }
//
//    // cell_For_Row_At
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifier.homeCollectionCell, for: indexPath) as! HomeHeaderCollectionCell
//
//
//        cell.collectionUI = indexPath.row
//
//        cell.imgString = self.imgString?[self.segmentValue ?? 0] ?? "101"
//
//
//
//
//        return cell
//    }
//
//    // did_Select_Row_At
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//        print("Home_Header")
//    }
//
//    // 아이템의 크기 설정
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let width = (self.frame.width - 10 - 10) / 3
//        let height = width / 10 * 16
//        return CGSize(width: width, height: height)
//    }
//
//    // 상하 spacing
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 5
//    }
//
//    // 좌우 spacing
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//}












// MARK: - Fix
// 화면에서 나갔을 때만 불로도록.
extension HomeHeader: FirstHomeHeaderDelegate {
    func fontColor() {
        
//        self.upCollectionView()
    }
}
extension HomeHeader: SecondHomeHeaderDelegate {
    func backgroundColr() {
        
//        self.upCollectionView()
    }
}


