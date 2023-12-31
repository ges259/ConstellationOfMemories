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
// [Singleton]
    // service 싱글톤
    private let service: Service = Service.shared
    
    
// [DB_Data]
    // diary_Data
    var diaryData: Diary?
    // Coin_Data
    var coin: Int?
    
// [Delegate]
    // Delegate
    var diaryVCMainDelegate: DiaryVCMainDelegate?
    
    
    
    
   
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: - View
        // separator_View
    private lazy var separatorView: UIView = {
        return UIView().viewConfig(backgroundColor: UIColor.white)
    }()
    
    private lazy var diarywhiteView: UIView = {
        return UIView()
    }()
    
    
    // MARK: - TextView
    private lazy var diaryTextView: UITextView = {
        let tv = UITextView()
            tv.backgroundColor = UIColor.clear
            tv.font = UIFont.systemFont(ofSize: 16)
            tv.text = "텍스트를 여기에 입력하세요."
            tv.isEditable = false
        return tv
    }()
    
    
    
    // MARK: - Label
    private lazy var diaryLabel: UILabel = {
        return UILabel().labelConfig(labelText: "오늘의 하루는 어땠나요?",
                                     fontName: .bold,
                                     fontSize: 25,
                                     numberOfLines: 0,
                                     textAlignment: .center)
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
        // alpha
        self.alpha = 0
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
        // diarywhiteView
        self.addSubview(self.diarywhiteView)
        self.diarywhiteView.anchor(top: self.separatorView.bottomAnchor, paddingTop: 10,
                                   leading: self.diaryLabel.leadingAnchor,
                                   trailing: self.diaryLabel.trailingAnchor,
                                   height: 200,
                                   cornerRadius: 20)
        // diaryTextView
        self.addSubview(self.diaryTextView)
        self.diaryTextView.delegate = self
        self.diaryTextView.anchor(top: self.diarywhiteView.topAnchor, paddingTop: 5,
                                  bottom: self.diarywhiteView.bottomAnchor, paddingBottom: 5,
                                  leading: self.diarywhiteView.leadingAnchor, paddingLeading: 5,
                                  trailing: self.diarywhiteView.trailingAnchor, paddingTrailing: 5,
                                  cornerRadius: 20)
    }
    // 화면터치하면 키보드가 내려가도록
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.diaryTextView.resignFirstResponder()
    }
    
    
    
    
    
    // MARK: - Font_Color
    func diaryColor(_ color: UIColor) {
        self.diaryTextView.textColor = color
        self.diaryLabel.textColor = color
        self.separatorView.backgroundColor = color
    }
    
    
    
    
    
    // MARK: - API
    private func saveOrUpdate() {
        // text_View 옵셔널 바인딩
        guard let diaryText = self.diaryTextView.text else { return }
        
        
        // [Create Or Update]
        // Create
        if self.diaryData == nil && MainVC.todayDiaryToggle == false {
            self.service.createDiaryData(diaryText: diaryText)
            // delegate - create
            self.diaryVCMainDelegate?.createDiaryData()
            
            
            
        // Update
        } else {
            guard let diaryData = diaryData else { return }
            self.service.updateDiaryData(diary: diaryData, diaryText: diaryText)
            // delegate - update
            self.diaryVCMainDelegate?.updateDiaryData()
        }
    }
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
        // Fix_Mode
        if fixMode == true {
            if self.diaryTextView.text == "" {
                self.diaryTextView.text = "텍스트를 여기에 입력하세요."
            }
            
            
            UIView.animate(withDuration: 0.5) {
                self.diarywhiteView.alpha = 1
                
                self.diaryTextView.isEditable = true
                self.diarywhiteView.backgroundColor = UIColor(white: 1, alpha: 0.4)
            }
            
            
        // 저장뷰로 진입
            // Save_Mode
        } else {
            if self.diaryTextView.text != "텍스트를 여기에 입력하세요."
                && self.diaryTextView.text != ""
                && self.diaryData?.diaryText != self.diaryTextView.text {
                // Update_OR_Create
                self.saveOrUpdate()
                
            } else if self.diaryTextView.text == "텍스트를 여기에 입력하세요." {
                self.diaryTextView.text = ""
            }
            
            UIView.animate(withDuration: 0.5) {
                self.diarywhiteView.alpha = 0
                self.diaryTextView.isEditable = false
                self.diarywhiteView.backgroundColor = .clear
            }
        }
    }
    // Observation_Mode
    func observationMode() {
        self.diarywhiteView.alpha = 0
        self.diaryTextView.isEditable = false
        self.diarywhiteView.backgroundColor = .clear
    }
}



















// MARK: - UITextViewDelegate
// textview의 _____ placeholder
extension DiaryVC: UITextViewDelegate {
    // 클릭시 텍스트뷰에 "텍스트를 여기에 입력하세요." 가 있다면 -> ""로 설정
    // 글자 색상 바꾸기
    func textViewDidBeginEditing(_ textView: UITextView) {
        if self.diaryTextView.text == "텍스트를 여기에 입력하세요." {
            self.diaryTextView.text = ""
        }
    }
    
    
    // 입력을 끝낸 후 텍스트뷰에 아무것도 없다면 "텍스트를 여기에 입력하세요."로 바꿈
    // 글자 생상 바꾸기
    func textViewDidEndEditing(_ textView: UITextView) {
        if self.diaryTextView.text == "" {
            self.diaryTextView.text = "텍스트를 여기에 입력하세요."
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
        self.diaryTextView.text = "텍스트를 여기에 입력하세요."
        self.diaryData = nil
    }
    
    func achieveDiary(diaryString: String) {
        self.diaryTextView.text = diaryString
    }
}
