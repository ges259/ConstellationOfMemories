//
//  SignUpVC.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/21.
//

import UIKit
import FirebaseAuth

final class SignUp: UIView {
    
    // MARK: - Properties
    
    var signUpLoginDelegate: SignUpLoginDelegate?
    
    private let service: Service = Service.shared
    
    
    
    
    
    
    
    

    
    
    
    
    
    
    
    
    // MARK: - Label
    private let titleLabel: UILabel = {
        return UILabel().labelConfig(labelText: "Sign Up",
                                     fontSize: 36,
                                     textAlignment: .center)
    }()
    
    
    
    // MARK: - TextField
    private lazy var emailTextField: UITextField = {
        let view = UITextField().textField(keyboardType: .emailAddress)
            view.addTarget(self, action: #selector(self.textFieldChanged),
                           for: .editingChanged)
        return view
    }()
    
    private lazy var fullNameTextField: UITextField = {
        let view = UITextField().textField(fontSize: 14)
            view.addTarget(self, action: #selector(self.textFieldChanged),
                           for: .editingChanged)
        return view
    }()
    
    private lazy var passwordTextField: UITextField = {
        let view = UITextField().textField(fontSize: 14,
                                           isSecureTextEntry: true)
            view.addTarget(self, action: #selector(self.textFieldChanged),
                           for: .editingChanged)
        return view
    }()

    
    
    // MARK: - Button
    private lazy var signUpButton: UIButton = {
        let btn = UIButton().authButton(title: "Login")
            btn.addTarget(self, action: #selector(self.signUpBtnTapped),
                          for: .touchUpInside)
        return btn
    }()
    
    private lazy var alreadyHaveButton: UIButton = {
        let btn = UIButton().mutableAttributedString(
            type1TextString: "Already have an account?   ",
            type2TextString: "Sign In")
 
            btn.addTarget(self, action: #selector(self.bottomBtnTapped),
                          for: .touchUpInside)
        return btn
    }()
    
    
    
    // MARK: - Stack_View
    private lazy var stackView: UIStackView = {
        return UIStackView().stackView(arrangedSubviews:
                                        [self.fullNameTextField,
                                         self.emailTextField,
                                         self.passwordTextField,
                                         self.signUpButton],
                                       axis: .vertical,
                                       spacing: 13,
                                       alignment: .fill,
                                       distribution: .fillEqually)
    }()
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: - LIfeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helper Functions
    private func configureUI() {
        // alpha = 0
        self.alpha = 0
        
        // Title_Label
        self.addSubview(self.titleLabel)
        self.titleLabel.anchor(top: self.topAnchor, paddingTop: 150,
                               leading: self.leadingAnchor, paddingLeading: 20,
                               trailing: self.trailingAnchor, paddingTrailing: 20)
        
        // Stack_View
        self.addSubview(self.stackView)
        self.stackView.anchor(top: self.titleLabel.bottomAnchor, paddingTop: 30,
                              leading: self.titleLabel.leadingAnchor,
                              trailing: self.titleLabel.trailingAnchor)
        
        // Already_Have_Button
        self.addSubview(self.alreadyHaveButton)
        self.alreadyHaveButton.anchor(bottom: self.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 10,
                                      leading: self.titleLabel.leadingAnchor,
                                      trailing: self.titleLabel.trailingAnchor)
    }
    
    
    
    // login_View로 갈 때 텍스트 필드 비우기 + 버튼 비활성화
        // loginVC에서 호출 됨
    func resetSignUpVC() {
        // 텍스트 필드 비우기
        self.fullNameTextField.text = ""
        self.emailTextField.text = ""
        self.passwordTextField.text = ""
        // 회원가입 버튼 비활성화
        self.textFieldChanged()
    }
    
    
    // MARK: - Signup_Color
    func signupColor(_ color: UIColor) {
        self.titleLabel.textColor = color
        
        self.emailTextField.textColor = color
        self.emailTextField.attributedPlaceholder =
        NSAttributedString(
            string: "email",
            attributes: [NSAttributedString.Key.foregroundColor: color]
        )
        self.passwordTextField.textColor = color
        self.passwordTextField.attributedPlaceholder =
        NSAttributedString(
            string: "password",
            attributes: [NSAttributedString.Key.foregroundColor: color]
        )
        self.fullNameTextField.textColor = color
        self.fullNameTextField.attributedPlaceholder =
        NSAttributedString(
            string: "fullName",
            attributes: [NSAttributedString.Key.foregroundColor: color]
        )
        
        
        
        self.signUpButton.setTitleColor(color, for: .normal)
        
        self.alreadyHaveButton.setAttributedTitle(    NSMutableAttributedString().mutableAttributedText(
            type1TextString: "Already have an account?   ",
            type1Foreground: color,
            type2TextString: "Sign In",
            type2Foreground: color), for: .normal)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: - Selectors
    @objc private func textFieldChanged() {
        // email 또는 password 둘 중 하나라도 빈 칸인 경우
        if self.fullNameTextField.text?.isEmpty == true
            || self.passwordTextField.text?.isEmpty == true
            || self.emailTextField.text?.isEmpty == true {
            
            // 회원가입 버튼 비활성화
            self.signUpButton.isEnabled = false
            self.signUpButton.setTitleColor(.lightGray, for: .normal)
          
            
        // 모두 채워졌다면 회원가입 버튼 활성화
        } else {
            self.signUpButton.isEnabled = true
            self.signUpButton.setTitleColor(.white, for: .normal)
        }
    }
    
    
    
    @objc private func signUpBtnTapped() {
        // 텍스트 필드 옵셔널 바인딩
        guard let fullName = self.fullNameTextField.text,
              let email = self.emailTextField.text,
              let password = self.passwordTextField.text
        else { return }
        
        // 회원 가입하기
        self.service.signUp(fullName: fullName,
                            email: email,
                            password: password) {
            // MainVC로 이동
            self.signUpLoginDelegate?.handleLogin()
        }
    }
    
    
    
    // MARK: - SignUp
    // 하단 버튼을 누르면 -> login_View로 이동
    @objc private func bottomBtnTapped() {
        self.signUpLoginDelegate?.handleSignUpToLogin()       
    }
}
