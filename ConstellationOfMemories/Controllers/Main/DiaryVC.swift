//
//  DiaryVC.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/08.
//

import UIKit
import FirebaseAuth

final class DiaryVC: UIView {
    
    // MARK: - Properties
    // 헤더뷰 싱글톤
    private let headerView = HeaderView.shared
    // service 싱글톤
    private let service: Service = Service.shared
    
    
    
    // fixToggle이 true이면 -> Save Or Update
    private var fixToggle: Bool = false
    
    
    var diaryData: Diary? 
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: - View
        // separator_View
    private lazy var separatorView: UIView = {
        return UIView().viewConfig(backgroundColor: UIColor.white)
    }()
    
    
    
    // MARK: - TextView
    private lazy var diaryTextView: UITextView = {
        let tv = UITextView()
            tv.backgroundColor = UIColor.clear
            tv.font = UIFont.systemFont(ofSize: 16)
//            tv.text = "텍스트를 여기에 입력하세요."
            tv.textColor = .white
            tv.isEditable = false
        return tv
    }()
    
    
    
    // MARK: - Label
    private lazy var diaryLabel: UILabel = {
        let lbl = UILabel().labelConfig(labelText: "오늘의 하루는 어땠나요?",
                                  LabelTextColor: .white,
                                  fontName: .bold,
                                  fontSize: 25,
                                  numberOfLines: 0,
                                  textAlignment: .center)
        return lbl
    }()
    
    
    
    // MARK: - Button
    private lazy var footerButton: UIButton = {
        // 버튼 시스템 이미지 크기 바꾸기
        let btn = UIButton().buttonSustemImage(btnSize: 30, imageString: .share)
            btn.addTarget(self, action: #selector(self.shareButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    
    
    // MARK: - LifeCycle    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // configure
            // background Color
            // Auto-Layout
        self.configureDiaryVC()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - HelperFunctions
    private func configureDiaryVC() {
        // background Color
        self.backgroundColor = .clear
        
        // alpha
        self.alpha = 0
        
        // UI - AutoLayout
        // diaryLabel
        self.addSubview(self.diaryLabel)
        self.diaryLabel.anchor(top: self.safeAreaLayoutGuide.topAnchor, paddingTop: 20,
                               leading: self.leadingAnchor, paddingLeading: 20,
                               trailing: self.trailingAnchor, paddingTrailing: 20,
                               height: 90)
        // separatorView
        self.addSubview(self.separatorView)
        self.separatorView.anchor(top: self.diaryLabel.bottomAnchor, paddingTop: 10,
                                  leading: self.diaryLabel.leadingAnchor,
                                  trailing: self.diaryLabel.trailingAnchor,
                                  height: 3)
        // diaryTextView
        self.addSubview(self.diaryTextView)
        self.diaryTextView.delegate = self
        self.diaryTextView.anchor(top: self.separatorView.bottomAnchor, paddingTop: 10,
                                  leading: self.diaryLabel.leadingAnchor,
                                  trailing: self.diaryLabel.trailingAnchor,
                                  height: 200,
                                  cornerRadius: 20)
        // footerButton
        self.addSubview(self.footerButton)
        self.footerButton.anchor(bottom: self.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 10,
                                   centerX: self)
    }
    
    // 화면터치하면 키보드가 내려가도록
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        diaryTextView.endEditing(true)
        self.diaryTextView.resignFirstResponder()
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: - Selectors
    @objc private func shareButtonTapped() {
        print(#function)
    }
    
    
    
    // MARK: - API
    
    
    
    
    
}














/*
 수정상태 == true
    텍스트뷰를 변경가능하고,
    텍스트뷰 색이 진하게 (보이게)
    공유버튼이 사라지고
 
 
 저장 상태에서는 == false
    텍스트뷰 변경이 불가능하고,
    텍스트뷰 색이 .clear로 변함
    공유버튼이 수정버튼이 되고
 */

// MARK: - DiaryHeaderDelegate
extension DiaryVC: HeaderDiaryVCDelegate {
    
    func diaryFixMode(_ fixMode: Bool) {
        // 수정뷰로 진입
        if fixMode == true {
            UIView.animate(withDuration: 0.3) {
                self.diaryTextView.isEditable = true
                self.diaryTextView.backgroundColor = UIColor(white: 1, alpha: 0.4)
                // share버튼 숨기기
                self.footerButton.alpha = 0
            }
            
            
        // 저장뷰로 진입
        } else {
            self.saveOrUpdate()
            
            UIView.animate(withDuration: 0.3) {
                self.diaryTextView.isEditable = false
                self.diaryTextView.backgroundColor = .clear
                // share버튼 보이게 하기
                self.footerButton.alpha = 1
            }
        }
    }
    
    
    
    
    
    // MARK: - API
    private func saveOrUpdate() {
        if self.fixToggle == false { return }
        self.fixToggle = false
        
        
        // 빈칸 또는 placeholder 상태라면 Create / Update하지 않음
        if self.diaryTextView.text == "텍스트를 여기에 입력하세요." {
            return
        }
        
        guard let diaryText = self.diaryTextView.text,
              let currentUid = Auth.auth().currentUser?.uid
        else { return }
        
        
        // [Create Or Update]
        // Create
        if self.diaryData == nil {
            self.service.createDiaryData(uid: currentUid, diaryText: diaryText)

        // Update
        } else {
            guard let diaryData = diaryData else { return }
            self.service.updateDiaryData(diary: diaryData, diaryText: diaryText)
        }
        
        // delegate?
    }
}



















// MARK: - UITextViewDelegate
// textview의 _____ placeholder
extension DiaryVC: UITextViewDelegate {
    // 클릭시 텍스트뷰에 "텍스트를 여기에 입력하세요." 가 있다면 -> ""로 설정
    // 글자 색상 바꾸기
    func textViewDidBeginEditing(_ textView: UITextView) {
        // fixToggle이 true이면 Save / Update
        self.fixToggle = true
        
        if self.diaryTextView.text == "텍스트를 여기에 입력하세요." {
            self.diaryTextView.text = ""
            self.diaryTextView.textColor = .white
        }
    }
    
    // 입력을 끝낸 후 텍스트뷰에 아무것도 없다면 "텍스트를 여기에 입력하세요."로 바꿈
    
    // 글자 생상 바꾸기
    func textViewDidEndEditing(_ textView: UITextView) {
        if self.diaryTextView.text == "" {
            self.diaryTextView.text = "텍스트를 여기에 입력하세요."
            self.diaryTextView.textColor = .white
        }
    }
}





// MARK: - DiaryTableDiaryDelegate
extension DiaryVC: DiaryTableDiaryDelegate {
    func todayDiaryTrue(diaryData: Diary) {
        self.diaryData = diaryData
        
        self.diaryTextView.text = diaryData.diaryText
    }
    
    func todayDiaryFalse() {
        self.diaryTextView.text = ""
        self.diaryData = nil
    }
}
