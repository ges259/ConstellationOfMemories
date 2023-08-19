//
//  AchievementView.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/12.
//

import UIKit

final class CollectionSegementView: UIView {
    
    // MARK: - Properties
    var collectionToggle: SegementToggle? {
        didSet {
            // frame도 바구기
            self.resetView()
        }
    }
    
    
    
    
    // MARK: - Layout
    private lazy var firstCollection: FirstCollectionView = {
        
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
    
    
    
    private func resetView() {
        // item값을 first / second에 전달
            // 만약 Toggle과 item 모두 first / second 로 전달이 필욯다면
                // func(메서드도 고려)
        
        
        
        // 토글을 전달
            // 맨 위로 설정
        self.firstCollection.firstCollectionToggle = collectionToggle
        self.secondCollection.secondCollectionToggle = collectionToggle
        
        
        // firstViewHideOrShow를 사용하지 않는 이유:
                // 애니메이션을 사용하면 뷰에 들어왔을 때 first로 가는 애니메이션이 보이기 때문.
        // segementControl을 첫번째 페이지로 바꾸기 ( segement_index )
        self.segmentedControl.selectedSegmentIndex = 0

        // achivementSegment 보이게 하기
        self.firstCollection.alpha = 1
        self.firstCollection.frame.origin.x = 0
        // mystarSegment 숨기기
        self.secondCollection.alpha = 0
        self.secondCollection.frame.origin.x = self.frame.width
    }
    
    
    
    
    
    
    
    // MARK: - Selectors
    @objc private func segmentedValueChanged(segment: UISegmentedControl) {
        segment.selectedSegmentIndex == 0
            ? self.firstViewHideOrShow(show: true) // first
            : self.firstViewHideOrShow(show: false) // second
    }
    
    
    
    private func firstViewHideOrShow(show: Bool) {
        if show == true {
            UIView.animate(withDuration: 0.5) {
                // first 보이게 하기
                self.firstCollection.alpha = 1
                self.firstCollection.frame.origin.x = 0
                // second 숨기기
                self.secondCollection.alpha = 0
                self.secondCollection.frame.origin.x = self.frame.width
            }
            
            
        } else {
            UIView.animate(withDuration: 0.5) {
                // first 숨기기
                self.firstCollection.alpha = 0
                self.firstCollection.frame.origin.x = -self.frame.width * 2
                // second 보이게 하기
                self.secondCollection.alpha = 1
                self.secondCollection.frame.origin.x = 0
            }
        }
    }
    
    
    
    // MARK: - API
    
    
    
    
    
    
    
}














