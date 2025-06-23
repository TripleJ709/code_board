//
//  LoginView.swift
//  code_board
//
//  Created by 장주진 on 6/23/25.
//

import UIKit

final class LoginView: UIView {
    let tfWidth: CGFloat = 250
    
    let emailField: UITextField = {
        var tf = UITextField()
        tf.placeholder = "이메일"
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let passwordField: UITextField = {
        var tf = UITextField()
        tf.placeholder = "비밀번호"
        tf.isSecureTextEntry = true
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let loginButton: UIButton = {
        var btn = UIButton()
        btn.setTitle("로그인", for: .normal)
        btn.backgroundColor = .green
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let registerButton: UIButton = {
        var btn = UIButton()
        btn.setTitle("회원가입", for: .normal)
        btn.backgroundColor = .green
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    lazy var btnStackView: UIStackView = {
        var sv = UIStackView(arrangedSubviews: [loginButton, registerButton])
        sv.axis = .vertical
        sv.spacing = 15
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        addSubview(emailField)
        addSubview(passwordField)
        addSubview(btnStackView)
        
        NSLayoutConstraint.activate([
            emailField.centerXAnchor.constraint(equalTo: centerXAnchor),
            emailField.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -60),
            emailField.widthAnchor.constraint(equalToConstant: tfWidth),
            
            passwordField.centerXAnchor.constraint(equalTo: centerXAnchor),
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 16),
            passwordField.widthAnchor.constraint(equalToConstant: tfWidth),
            
            btnStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            btnStackView.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 24)
        ])
    }
}
