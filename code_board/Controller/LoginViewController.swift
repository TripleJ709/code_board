//
//  LoginViewController.swift
//  code_board
//
//  Created by 장주진 on 6/23/25.
//

import UIKit

final class LoginViewController: UIViewController {
    private let loginView = LoginView()
    private let loginModel = Login()
    
    override func loadView() {
        self.view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.loginButton.addTarget(self, action: #selector(loginBtnTapped), for: .touchUpInside)
        loginView.registerButton.addTarget(self, action: #selector(registerBtnTapped), for: .touchUpInside)
    }
    
    @objc func loginBtnTapped() {
        let email = loginView.emailField.text ?? ""
        let password = loginView.passwordField.text ?? ""
        
        let request = LoginRequest(email: email, password: password)
        loginModel.login(request: request) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    print("로그인 성공", user)
                    let mainVC = MainViewController()
                    mainVC.modalPresentationStyle = .fullScreen
                    self.present(mainVC, animated: true)
                case .failure(let error):
                    print("로그인 실패", error)
                    let alert = UIAlertController(title: "로그인 실패", message: "아이디 또는 비밀번호가 올바르지 않습니다.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인", style: .default))
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    @objc func registerBtnTapped() {
        let registerVC = RegisterViewController()
        registerVC.modalPresentationStyle = .fullScreen
        self.present(registerVC, animated: true)
    }
}
