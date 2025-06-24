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
    
    var isEmailChecked = false
    
    override func loadView() {
        self.view = registerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerView.emailDuplicationBtn.addTarget(self, action: #selector(duplicationBtnTapped), for: .touchUpInside)
        registerView.registerBtn.addTarget(self, action: #selector(registerBtnTapped), for: .touchUpInside)
        registerView.dismissBtn.addTarget(self, action: #selector(dismissBtnTapped), for: .touchUpInside)
        
        registerView.passwordConfirmTextField.delegate = self
    }
    
    @objc func duplicationBtnTapped() {
        let email = registerView.emailTextField.text ?? ""
        
        guard !email.isEmpty else {
            showAlert(message: "이메일을 입력해주세요")
            return
        }
        
        if !isValidEmail(email) {
            showAlert(message: "이메일 형식이 올바르지 않습니다.")
            return
        }
        
        registerModel.checkEmailDuplicaion(email: email) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let available):
                    self.isEmailChecked = available
                    let message = available ? "사용 가능한 이메일입니다." : "이미 존재하는 이메일입니다."
                    let alert = UIAlertController(title: "중복 확인", message: message, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인", style: .default))
                    self.present(alert, animated: true)
                case .failure(let error):
                    self.isEmailChecked = false
                    print("중복 확인 실패:", error)
                    self.showAlert(message: "중복 확인 중 오류 발생")
                }
            }
        }
    }
    
    @objc func registerBtnTapped() {
        let name = registerView.nameTextField.text ?? ""
        let email = registerView.emailTextField.text ?? ""
        let password = registerView.passwordTextField.text ?? ""
        let passwordConfirm = registerView.passwordConfirmTextField.text ?? ""
        
        if !isEmailChecked {
            showAlert(message: "이메일 중복확인이 필요합니다.")
            return
        }
        
        if !isValidPassword(password) {
            showAlert(message: "비밀번호는 영문과 숫자를 포함한 8자리 이상이어야 합니다.")
            return
        }
        
        if password != passwordConfirm {
            showAlert(message: "비밀번호가 일치하지 않습니다.")
            return
        }
        
        let request = RegisterRequest(name: name, email: email, password: password)
        registerModel.register(request: request) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let message):
                    print("성공", message)
                    self.dismiss(animated: true)
                case .failure(let error):
                    print("실패", error)
                }
            }
        }
    }
    
    @objc func dismissBtnTapped() {
        self.dismiss(animated: true)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: email)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        let regex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: password)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "회원가입 실패", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        self.present(alert, animated: true)
    }
}

extension RegisterViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let currentText = textField.text,
           let textRange = Range(range, in: currentText) {
            let updatedText = currentText.replacingCharacters(in: textRange, with: string)
            
            let password = (textField == registerView.passwordTextField) ? updatedText : registerView.passwordTextField.text ?? ""
            let confirm = (textField == registerView.passwordConfirmTextField) ? updatedText : registerView.passwordConfirmTextField.text ?? ""
            
            if password == confirm {
                registerView.passwordConfirmMessage.text = "비밀번호가 일치합니다."
                registerView.passwordConfirmMessage.textColor = .green
            } else {
                registerView.passwordConfirmMessage.text = "비밀번호가 일치하지 않습니다."
                registerView.passwordConfirmMessage.textColor = .red
            }
        }
        
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == registerView.emailTextField {
            isEmailChecked = false
        }
    }
}
