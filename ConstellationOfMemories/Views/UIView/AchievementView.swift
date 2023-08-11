//
//  AchievementView.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/12.
//

import UIKit

final class AchievementView: UIView {
    
    // MARK: - Properties
    
    
    
    
    
    // MARK: - Layout
    // UISegmentedControl
    lazy var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["myStarSegment", "achievementSegment"])
            // segment 배경색 (비 선택창)
            control.backgroundColor = .clear
            // segement 선택창 배경 색
            control.selectedSegmentTintColor = UIColor(white: 1, alpha: 0.3)
            
            control.selectedSegmentIndex = 0
        
            control.addTarget(self, action: #selector(segmentedValueChanged(segment:)), for: .valueChanged)
            
        return control
    }()
    private lazy var myStarSegment: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.alpha = 1
        return view
    }()
    private lazy var achievementSegment: UIView = {
        let view = UIView()
        
        view.backgroundColor = .yellow
        view.alpha = 0
        return view
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
        
        
        // myStarSegment
        self.addSubview(self.myStarSegment)
        self.myStarSegment.anchor(top: self.segmentedControl.bottomAnchor,
                                  bottom: self.bottomAnchor,
                                  leading: self.leadingAnchor,
                                  trailing: self.trailingAnchor)
        
        
        
        // achievementSegment
        self.addSubview(self.achievementSegment)
        self.achievementSegment.anchor(top: self.segmentedControl.bottomAnchor,
                                       bottom: self.bottomAnchor,
                                       leading: self.leadingAnchor,
                                       trailing: self.trailingAnchor)
        
    }
    
    
    
    
    
    
    
    // MARK: - Selectors
    @objc private func segmentedValueChanged(segment: UISegmentedControl) {
        // 추억 모음
        if segment.selectedSegmentIndex == 0 {
            
            UIView.animate(withDuration: 0.3) {
                // mystarSegment 보이게 하기
                self.myStarSegment.alpha = 1
                self.achievementSegment.alpha = 0
            }
            // 달성률
        } else {
            
            UIView.animate(withDuration: 0.3) {
                // achivementSegment 보이게 하기
                self.myStarSegment.alpha = 0
                self.achievementSegment.alpha = 1
            }
        }
    }
    
    
    
    
    
    // MARK: - API
    
    
    
    
}
