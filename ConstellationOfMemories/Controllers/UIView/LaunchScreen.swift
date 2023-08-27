//
//  LaunchScreen.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/27.
//

import UIKit

final class LaounchSccreen: UIView {
    
    // MARK: - Properties
    lazy var imageView: UIImageView = {
        return UIImageView(image: UIImage(named: "blueSky"))
    }()
    
    
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
        self.addSubview(self.imageView)
        self.imageView.anchor(top: self.topAnchor,
                              bottom: self.bottomAnchor,
                              leading: self.leadingAnchor,
                              trailing: self.trailingAnchor)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - Helper Functions
    
    
    
}
