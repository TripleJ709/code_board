//
//  RegisterView.swift
//  code_board
//
//  Created by 장주진 on 6/23/25.
//

import UIKit

final class RegisterView: UIView {
    let nameLabel: UILabel = {
        var tv = UILabel()
        tv.text = "이름"
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let nameTextField: UITextField = {
        var tf = UITextField()
        tf.placeholder = "이름"
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let emailLabel: UILabel = {
        var tv = UILabel()
        tv.text = "이메일"
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let emailTextField: UITextField = {
        var tf = UITextField()
        tf.placeholder = "이메일"
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let emailDuplicationBtn: UIButton = {
        var btn = UIButton()
        btn.setTitle("중복확인", for: .normal)
        btn.backgroundColor = .green
        return btn
    }()
    
    let passwordLabel: UILabel = {
        var tv = UILabel()
        tv.text = "비밀번호"
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let passwordTextField: UITextField = {
        var tf = UITextField()
        tf.placeholder = "비밀번호"
        tf.borderStyle = .roundedRect
        tf.isSecureTextEntry = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    let passwordConfirmLabel: UILabel = {
        var tv = UILabel()
        tv.text = "비밀번호 확인"
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let passwordConfirmTextField: UITextField = {
        var tf = UITextField()
        tf.placeholder = "비밀번호 확인"
        tf.borderStyle = .roundedRect
        tf.isSecureTextEntry = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let passwordConfirmMessage: UILabel = {
        var tv = UILabel()
        tv.text = ""
        tv.font = UIFont.systemFont(ofSize: 15)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    lazy var nameStackView: UIStackView = {
        var sv = UIStackView(arrangedSubviews: [nameLabel, nameTextField])
        sv.axis = .horizontal
        sv.spacing = 80
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    lazy var emailStackView: UIStackView = {
        var sv = UIStackView(arrangedSubviews: [emailLabel, emailTextField, emailDuplicationBtn])
        sv.axis = .horizontal
        sv.spacing = 65
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    lazy var passwordStackView: UIStackView = {
        var sv = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField])
        sv.axis = .horizontal
        sv.spacing = 50
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    lazy var passwordConfirmStackView: UIStackView = {
        var sv = UIStackView(arrangedSubviews: [passwordConfirmLabel, passwordConfirmTextField])
        sv.axis = .horizontal
        sv.spacing = 15
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let registerBtn: UIButton = {
        var btn = UIButton()
        btn.setTitle("회원가입", for: .normal)
        btn.backgroundColor = .green
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let dismissBtn: UIButton = {
        var btn = UIButton()
        btn.setTitle("이전", for: .normal)
        btn.backgroundColor = .green
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
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
        addSubview(nameStackView)
        addSubview(emailStackView)
        addSubview(passwordStackView)
        addSubview(passwordConfirmStackView)
        addSubview(passwordConfirmMessage)
        addSubview(registerBtn)
        addSubview(dismissBtn)
        
        NSLayoutConstraint.activate([
            nameStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            nameStackView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -100),
            
            emailStackView.leadingAnchor.constraint(equalTo: nameStackView.leadingAnchor),
            emailStackView.topAnchor.constraint(equalTo: nameStackView.bottomAnchor, constant: 20),
            
            passwordStackView.leadingAnchor.constraint(equalTo: nameStackView.leadingAnchor),
            passwordStackView.topAnchor.constraint(equalTo: emailStackView.bottomAnchor, constant: 20),
            
            passwordConfirmStackView.leadingAnchor.constraint(equalTo: nameStackView.leadingAnchor),
            passwordConfirmStackView.topAnchor.constraint(equalTo: passwordStackView.bottomAnchor, constant: 20),
            
            passwordConfirmMessage.leadingAnchor.constraint(equalTo: passwordConfirmTextField.leadingAnchor),
            passwordConfirmMessage.topAnchor.constraint(equalTo: passwordConfirmTextField.bottomAnchor, constant: 5),
            passwordConfirmMessage.widthAnchor.constraint(equalToConstant: 200),
            
            registerBtn.centerXAnchor.constraint(equalTo: centerXAnchor),
            registerBtn.topAnchor.constraint(equalTo: passwordConfirmMessage.bottomAnchor, constant: 10),
            
            dismissBtn.centerXAnchor.constraint(equalTo: centerXAnchor),
            dismissBtn.topAnchor.constraint(equalTo: registerBtn.bottomAnchor, constant: 20)
        ])
    }
}

