////
////  FooterView.swift
////  ConstellationOfMemories
////
////  Created by 계은성 on 2023/08/08.
////
//
//import UIKit
//
//final class FooterView: UIView {
//
//    // MARK: - Properties
//
//
//
//    // MARK: - Button
//    private lazy var calendarButton: UIButton = {
//        let btn = UIButton()
//        // 버튼 시스템 이미지 크기 바꾸기
//        let largeConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular, scale: .default)
//        let largeBoldDoc = UIImage(systemName: "calendar", withConfiguration: largeConfig)
//            btn.setImage(largeBoldDoc, for: .normal)
//
//            btn.tintColor = .black
//
////            btn.addTarget(self, action: #selector(self.calendarButtonTapped), for: .touchUpInside)
//        return btn
//    }()
//
//
//
//
//    // MARK: - LifeCycle
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        // configure
//            // background Color
//            // AutoLayout
//        self.configureFooterView()
//    }
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//
//
//    // MARK: - HelperFunctions
//    private func configureFooterView() {
//
//        self.addSubview(self.calendarButton)
//        self.calendarButton.anchor(bottom: self.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 5,
//                                   centerX: self)
//    }
//
//
//
//    // MARK: - Selectors
//
//
//
//
//    // MARK: - API
//
//
//
//
//
//
//
//
//}
