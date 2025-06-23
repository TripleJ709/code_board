//
//  RegisterViewController.swift
//  code_board
//
//  Created by 장주진 on 6/23/25.
//

import UIKit

 class RegisterViewController: UIViewController {
    let registerView = RegisterView()
    let registerModel = Register()
    
    override func loadView() {
        self.view = registerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerView.emailDuplicationBtn.addTarget(self, action: #selector(duplicationBtnTapped), for: .touchUpInside)
        registerView.registerBtn.addTarget(self, action: #selector(registerBtnTapped), for: .touchUpInside)
        registerView.dismissBtn.addTarget(self, action: #selector(dismissBtnTapped), for: .touchUpInside)
        
        registerView.passwordTextField.delegate = self
        registerView.passwordConfirmTextField.delegate = self
    }
    
    @objc func duplicationBtnTapped() {
        let email = registerView.emailTextField.text ?? ""
        
        registerModel.checkEmailDuplicaion(email: email) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let available):
                    let message = available ? "사용 가능한 이메일입니다." : "이미 존재하는 이메일입니다."
                    let alert = UIAlertController(title: "중복 확인", message: message, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인", style: .default))
                    self.present(alert, animated: true)
                case .failure(let error):
                    print("중복 확인 실패:", error)
                }
            }
        }
    }
    
    @objc func registerBtnTapped() {
        let name = registerView.nameTextField.text ?? ""
        let email = registerView.emailTextField.text ?? ""
        let password = registerView.passwordTextField.text ?? ""
        
        let request = RegisterRequest(name: name, email: email, password: password)
        registerModel.register(request: request) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let message):
                    print("성공", message)
                case .failure(let error):
                    print("실패", error)
                }
            }
        }
    }
    
    @objc func dismissBtnTapped() {
        self.dismiss(animated: true)
    }
}

extension RegisterViewController: UITextFieldDelegate {
    
}
