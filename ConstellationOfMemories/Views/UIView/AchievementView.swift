//
//  AchievementView.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/12.
//

import UIKit

final class AchievementView: UIView {
    
    // MARK: - Properties
    
    
    var achieveMainDelegate: AchieveMainDelegate?
    
    
    // MARK: - Layout
    // UISegmentedControl
    lazy var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["추억 모음", "통계"])
            // segment 배경색 (비 선택창)
            control.backgroundColor = .clear
            // segement 선택창 배경 색
            control.selectedSegmentTintColor = UIColor(white: 1, alpha: 0.3)
        
//        control.setTitleTextAttributes(<#T##attributes: [NSAttributedString.Key : Any]?##[NSAttributedString.Key : Any]?#>, for: <#T##UIControl.State#>)
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
                                     height: 50)
    }
    
    
    
    
    
    
    
    // MARK: - Selectors
    @objc private func segmentedValueChanged(segment: UISegmentedControl) {
        // 추억 모음
        if segment.selectedSegmentIndex == 0 {
            
            UIView.animate(withDuration: 0.3) {
                // mystarSegment 보이게 하기
//                self.myStarSegment.alpha = 1
//                self.achievementSegment.alpha = 0
                
                self.achieveMainDelegate?.myStarSegement()
                
            }
            // 달성률
        } else {
            
            UIView.animate(withDuration: 0.3) {
                // achivementSegment 보이게 하기
//                self.myStarSegment.alpha = 0
//                self.achievementSegment.alpha = 1
                self.achieveMainDelegate?.habitSegment()
            }
        }
    }
    
    
    
    
    
    // MARK: - API
    
    
    
    
}
