//
//  CreatePostView.swift
//  code_board
//
//  Created by 장주진 on 6/27/25.
//

import UIKit

class CreatePostView: UIView {
    
//    let mainLabel: UILabel = {
//        let label = UILabel ()
//        label.text = "글쓰기"
//        label.font = .systemFont(ofSize: 30)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
    
    let titleTextField:UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.placeholder = "제목"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let contentTextView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.layer.borderColor = UIColor.lightGray.cgColor
        tv.layer.borderWidth = 1
        tv.layer.cornerRadius = 8
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    let createPostButton: UIButton = {
        let button = UIButton()
        button.setTitle("글 올리기", for: .normal)
        button.backgroundColor = .green
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
//        addSubview(mainLabel)
        addSubview(titleTextField)
        addSubview(contentTextView)
        addSubview(createPostButton)
        
        NSLayoutConstraint.activate([
//            mainLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
//            mainLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
//            
            titleTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
            titleTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            titleTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            contentTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 30),
            contentTextView.leadingAnchor.constraint(equalTo: titleTextField.leadingAnchor),
            contentTextView.trailingAnchor.constraint(equalTo: titleTextField.trailingAnchor),
            contentTextView.bottomAnchor.constraint(equalTo: createPostButton.topAnchor, constant: -30),
            
            createPostButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -15),
            createPostButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
