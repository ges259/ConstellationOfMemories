//
//  AchievementView.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/12.
//

import UIKit

final class CollectionSegementView: UIView {
    
    // MARK: - Properties

    
    // item
    private var item = [Int]()
    
    var collectionToggle: SegementToggle = .home
    
    

    
    
    lazy var firstCollection: FirstCollectionView = {
        
        let frame = CGRect(x: 0,
                           y: 50,
                           width: self.frame.width,
                           height: self.frame.height - 50)
        return FirstCollectionView(frame: frame)
    }()
    
    lazy var secondCollection: SecondCollectionView = {
        let frame = CGRect(x: self.frame.width,
                           y: 50,
                           width: self.frame.width,
                           height: self.frame.height - 50)
        return SecondCollectionView(frame: frame)
    }()

    
    
    
    
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
        
        
        self.addSubview(self.firstCollection)
        self.addSubview(self.secondCollection)
        self.secondCollection.alpha = 0
    }
    
    
    
    
    
    
    
    // MARK: - Selectors
    @objc private func segmentedValueChanged(segment: UISegmentedControl) {
        // 추억 모음
        if segment.selectedSegmentIndex == 0 {

            if self.collectionToggle == .home {
                self.homeViewHideOrShow(show: true)
                
            } else {
                self.shopViewHideOrShow(show: true)
            }
        // 달성률
        } else {
            if self.collectionToggle == .home {
                self.homeViewHideOrShow(show: false)
                
            } else {
                self.shopViewHideOrShow(show: false)
            }
        }
    }
    
    
    
    func homeViewHideOrShow(show: Bool) {
        if show == true {
            UIView.animate(withDuration: 0.5) {
                // achivementSegment 보이게 하기
                self.firstCollection.alpha = 1
                self.firstCollection.frame.origin.x = 0
                
                // mystarSegment 숨기기
                self.secondCollection.alpha = 0
                self.secondCollection.frame.origin.x = self.frame.width
            }
            
            
        } else {
            UIView.animate(withDuration: 0.5) {
                // achivementSegment 숨기기
                self.firstCollection.alpha = 0
                self.firstCollection.frame.origin.x = -self.frame.width * 2
                
                
                // mystarSegment 보이게 하기
                self.secondCollection.alpha = 1
                self.secondCollection.frame.origin.x = 0
            }
        }
    }
    
    
    
    func shopViewHideOrShow(show: Bool) {
        if show == true {
            UIView.animate(withDuration: 0.5) {
                // achivementSegment 보이게 하기
                self.firstCollection.alpha = 1
                self.firstCollection.frame.origin.x = 0
                
                // mystarSegment 숨기기
                self.secondCollection.alpha = 0
                self.secondCollection.frame.origin.x = self.frame.width
            }
            
            
        } else {
            UIView.animate(withDuration: 0.5) {
                // achivementSegment 숨기기
                self.firstCollection.alpha = 0
                self.firstCollection.frame.origin.x = -self.frame.width * 2
                
                
                // mystarSegment 보이게 하기
                self.secondCollection.alpha = 1
                self.secondCollection.frame.origin.x = 0
            }
        }
    }
    
    
    
    func upCollectionView() {
        // item이 항상 맨위로 가도록 설정
//        let indexPath = IndexPath(item: self.item.count - 1, section: 0)
//        self.secondCollection.scrollToItem(at: indexPath, at: .top, animated: true)
    }

    
    
    
    
    
    
    
    
    
    
    // MARK: - API
    
    
    
    
    
    
    
}














