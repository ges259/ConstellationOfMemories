//
//  AchievementView.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/12.
//

import UIKit

final class collectionSegementView: UIView {
    
    // MARK: - Properties
    // CollectionView
    private var reuseCollectionView: UICollectionView!
    // item
    private var item = [Int]()
    
    
    var segementMainDelegate: SegementMainDelegate?
    
    // 콜렉션뷰 토글
    var collectionViewToggle: CollectionViewEnum = .shop {
        didSet {
            self.reuseCollectionView.reloadData()
        }
    }
    
    
    
    
    
    // MARK: - Layout
    // UISegmentedControl
    lazy var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["별자리 컬렉션", "일기 컬렉션"])
            // segment 배경색 (비 선택창)
            control.backgroundColor = .clear
            // segement 선택창 배경 색
            
        
            control.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor : UIColor.white], for: .normal)
        
            control.selectedSegmentTintColor = UIColor(white: 1, alpha: 0.3)
        
            control.selectedSegmentIndex = 0
            control.addTarget(self, action: #selector(segmentedValueChanged(segment:)), for: .valueChanged)
            
        return control
    }()
    
    
    private let redView: UIView = {
        return UIView().viewConfig(backgroundColor: .white)
    }()
    
    
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    // MARK: - Helper Functions
    
    private func configureView() {
        // background Color
        self.backgroundColor = .clear
        
        
        
        
        // segmentedControl
        self.addSubview(self.segmentedControl)
        self.segmentedControl.anchor(top: self.topAnchor,
                                     leading: self.leadingAnchor,
                                     trailing: self.trailingAnchor,
                                     height: 40)
        
        
        
        
        // Menu - Shop
        // collectionView
        let collectionViewFrame = CGRect(x: 0,
                                         y: 50,
                                         width: self.frame.width,
                                         height: self.frame.height - 200)
        let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
        
        let interval:CGFloat = 30
            layout.sectionInset = UIEdgeInsets.init(top: interval,
                                                    left: interval,
                                                    bottom: 0,
                                                    right: interval)
        self.reuseCollectionView = UICollectionView(frame: collectionViewFrame,
                                               collectionViewLayout: layout)
        self.reuseCollectionView.delegate = self
        self.reuseCollectionView.dataSource = self

        self.reuseCollectionView.register(ShopCollectionViewCell.self,
                                     forCellWithReuseIdentifier: ReuseIdentifier.shopCell)

        self.reuseCollectionView.alwaysBounceVertical = true
        self.reuseCollectionView.backgroundColor = .clear

        
        self.addSubview(self.reuseCollectionView)
        self.reuseCollectionView.anchor(top: self.segmentedControl.bottomAnchor,
                                        bottom: self.bottomAnchor,
                                        leading: self.leadingAnchor,
                                        trailing: self.trailingAnchor)
        
        
        
        
        
        
        
        // redView
        self.addSubview(self.redView)
        self.redView.anchor(top: self.segmentedControl.bottomAnchor, paddingTop: 30,
                            bottom: self.bottomAnchor, paddingBottom: 30,
                            leading: self.leadingAnchor, paddingLeading: 30,
                            trailing: self.trailingAnchor, paddingTrailing: 30)
                            self.redView.alpha = 0
        
    }
    
    
    
    
    
    
    
    // MARK: - Selectors
    @objc private func segmentedValueChanged(segment: UISegmentedControl) {
        // 추억 모음
        if segment.selectedSegmentIndex == 0 {
            switch self.collectionViewToggle {
            case .myStar:
                self.achieveSegementHideOrShow(show: true)
                break
                
                
            case .shop:
                self.shopSegementHideOrShow(show: true)
                break
            }
            
            // 달성률
        } else {
            switch self.collectionViewToggle {
            case .myStar:
                self.achieveSegementHideOrShow(show: false)
                break
                
                
            case .shop:
                self.shopSegementHideOrShow(show: false)
                break
            }
        }
    }
    
    
    
    func achieveSegementHideOrShow(show: Bool) {
        if show == true {
            self.reuseCollectionView.reloadData()
            
            UIView.animate(withDuration: 0.5) {
                // mystarSegment 보이게 하기
                self.reuseCollectionView.alpha = 1
                self.reuseCollectionView.frame.origin.x = 0
                
                // achivementSegment 숨기기
                self.redView.alpha = 0
                self.redView.frame.origin.x = self.frame.width
            }
            
        } else {
            UIView.animate(withDuration: 0.5) {
                // mystarSegment 숨기기
                self.reuseCollectionView.alpha = 0
                self.reuseCollectionView.frame.origin.x = -self.frame.width
                
                // achivementSegment 보이게 하기
                self.redView.alpha = 1
                self.redView.frame.origin.x = 30
            }
        }
    }
    
    func shopSegementHideOrShow(show: Bool) {
        if show == true {
            self.reuseCollectionView.reloadData()
            
            UIView.animate(withDuration: 0.5) {
                // mystarSegment 보이게 하기
                self.reuseCollectionView.alpha = 1
                self.reuseCollectionView.frame.origin.x = 0
                
                // achivementSegment 숨기기
                self.redView.alpha = 0
                self.redView.frame.origin.x = self.frame.width
            }
            
        } else {
            UIView.animate(withDuration: 0.5) {
                // mystarSegment 숨기기
                self.reuseCollectionView.alpha = 0
                self.reuseCollectionView.frame.origin.x = -self.frame.width
                
                // achivementSegment 보이게 하기
                self.redView.alpha = 1
                self.redView.frame.origin.x = 30
            }
        }
    }
    
    
    
    func upCollectionView() {
        // item이 항상 맨위로 가도록 설정
        let indexPath = IndexPath(item: self.item.count - 1, section: 0)
        self.reuseCollectionView.scrollToItem(at: indexPath, at: .top, animated: true)
    }
    
    
    
    
    
    
    
    
    
    
    
    // MARK: - API
    
    
    
    
    
    
    
}














// MARK: - CollectionView_Delegate
extension collectionSegementView: UICollectionViewDelegate, UICollectionViewDataSource,
                  UICollectionViewDelegateFlowLayout {
    // dataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.collectionViewToggle == .shop ? 5 : 10
        
//        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifier.shopCell, for: indexPath)
        
        
        return cell
    }
    
    // delegate
    // didSelect_Item_At
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.segementMainDelegate?.imageTapped()
    }
    // 아이템의 크기 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 좌우 패딩 30 = 60
        // spacing = 30
        let width = (self.frame.width - 60 - 30) / 2
        let height = width / 10 * 16
        
        return CGSize(width: width, height: height)
    }
    
    // 상하 spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 50
    }
    
    // 좌우 spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
}
