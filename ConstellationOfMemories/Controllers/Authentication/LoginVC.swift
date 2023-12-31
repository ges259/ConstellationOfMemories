//
//  LoginVC.swift
//  ConstellationOfMemories
//
//  Created by 계은성 on 2023/08/21.
//

import UIKit
import FirebaseAuth

final class LoginVC: UIView {
    
    // MARK: - Properties
    var loginMainDelegate: LoginMainDelegate?
    
    
    
    
    

    
    
    
    
    
    
    
    
    
    
    
    // MARK: - Label
    private let titleLabel: UILabel = {
        return UILabel().labelConfig(labelText: "Login",
                                     fontSize: 36,
                                     textAlignment: .center)
    }()
    
    
    // MARK: - TextField
    private lazy var emailTextField: UITextField = {
        let tf = UITextField().textField(fontSize: 14)
        tf.addTarget(self, action: #selector(self.textFieldChanged),
                     for: .editingChanged)
        
        return tf
    }()
    
    private lazy var passwordTextField: UITextField = {
        let tf = UITextField().textField(fontSize: 14,
                                         isSecureTextEntry: true)
        tf.addTarget(self, action: #selector(self.textFieldChanged),
                     for: .editingChanged)
        return tf
    }()
    
    
    
    
    // MARK: - Button
    private lazy var loginButton: UIButton = {
        let btn = UIButton().authButton(title: "Login")
            btn.addTarget(self, action: #selector(self.loginBtnTapped),
                          for: .touchUpInside)
        return btn
    }()
    
    private lazy var dontHaveAccountButton: UIButton = {
        let btn = UIButton()
 
        btn.addTarget(self, action: #selector(bottomBtnTapped), for: .touchUpInside)
        return btn
    }()
    
    
    // MARK: - StackView
    private lazy var stackView: UIStackView = {
        return UIStackView().stackView(arrangedSubviews:
                                        [self.emailTextField,
                                         self.passwordTextField,
                                         self.loginButton],
                                       axis: .vertical,
                                       spacing: 13,
                                       alignment: .fill,
                                       distribution: .fillEqually)
    }()
    
    
    
    
    
    
    
    
    
    
    // MARK: - SignUp_View
    private lazy var signUpView: SignUp = {
        let frame = CGRect(x: 0,
                           y: 0,
                           width: self.frame.width,
                           height: self.frame.height)
        let view = SignUp(frame: frame)
            view.signUpLoginDelegate = self
        return view
    }()
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    
    
    
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: - Helper Functions
    private func configureUI() {
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
        
        // Dont_Have_Account_Button
        self.addSubview(self.dontHaveAccountButton)
        self.dontHaveAccountButton.anchor(bottom: self.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 10,
                                          leading: self.titleLabel.leadingAnchor,
                                          trailing: self.titleLabel.trailingAnchor)
        
        
        self.addSubview(self.signUpView)
    }
    
    
    
    // MARK: - Login_Color
    func loginColor(_ color: UIColor) {
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
        
        
        
        self.loginButton.setTitleColor(color, for: .normal)
        
        self.dontHaveAccountButton.setAttributedTitle(    NSMutableAttributedString().mutableAttributedText(
            type1TextString: "Dont't have an account?   ",
            type1Foreground: color,
            type2TextString: "Sign Up",
            type2Foreground: color), for: .normal)
        
        
        self.signUpView.signupColor(color)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: - Selectors
    @objc private func textFieldChanged() {
        // email 또는 password 둘 중 하나라도 빈 칸인 경우
        if self.emailTextField.text?.isEmpty == true || self.passwordTextField.text?.isEmpty == true {
            
            // 로그인 버튼 비활성화
            self.loginButton.isEnabled = false
            self.loginButton.setTitleColor(.lightGray, for: .normal)
          
            
        // 모두 채워졌다면 로그인 버튼 활성화
        } else {
            self.loginButton.isEnabled = true
            self.loginButton.setTitleColor(.white, for: .normal)
        }
    }
    
    // 로그인 버튼
        // 버튼을 누르면 -> MainVC로 이동
    @objc private func loginBtnTapped() {
        guard let email = self.emailTextField.text,
              let password = self.passwordTextField.text
        else { return }
        
        // Login
        Service.shared.login(email: email, password: password) {
            self.handleLogin()
        }
    }
    
    
    // MainVC로 이동
        // 따로 빼둔 이유는 SignUp_View에서도 이 함수를 통해 MainVC로 이동
    func handleLogin() {
        self.loginMainDelegate?.handleLoginToMain()
    }
    
    func resetLoginView() {
        // 텍스트 필드 비우기
        self.emailTextField.text = ""
        self.passwordTextField.text = ""
        // 로그인 버튼 비활성화
        self.textFieldChanged()
    }
}




















// MARK: - signUpLoginDelegate
extension LoginVC: SignUpLoginDelegate {
    // Login -> SignUp
    @objc private func bottomBtnTapped() {
        UIView.animate(withDuration: 0.75) {
            // Login_View 숨기기
            self.titleLabel.alpha = 0
            self.stackView.alpha = 0
            self.dontHaveAccountButton.alpha = 0
            
            
        } completion: { _ in
            UIView.animate(withDuration: 0.75) {
                // signUp_View 보이게 하기
                self.signUpView.alpha = 1
                
                
            } completion: { _ in
                self.resetLoginView()
            }
        }
    }
    
    // SignUp -> Login
    func handleSignUpToLogin() {
        UIView.animate(withDuration: 0.75) {
            // signUp_View 숨기기// signUp_View 보이게 하기
            self.signUpView.alpha = 0
            
        } completion: { _ in
            UIView.animate(withDuration: 0.75) {
                // Login_View 보이게 하기
                self.titleLabel.alpha = 1
                self.stackView.alpha = 1
                self.dontHaveAccountButton.alpha = 1
                
                
            } completion: { _ in
                // SignUp_View의 텍스트 필드 지우기 + 로그인 버튼 비활성화
                self.signUpView.resetSignUpVC()
            }
        }
    }
}
