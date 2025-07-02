//
//  PostDetailView.swift
//  code_board
//
//  Created by 장주진 on 6/30/25.
//

import UIKit

class PostDetailView: UIView {
    
    let detailScrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let containerView: UIView = {
        let cv = UIView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "제목"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let authorDateLabel: UILabel = {
        let label = UILabel()
        label.text = "작성자: 작성자 - 시간"
        label.font = .systemFont(ofSize: 10)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.text = "내용"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let hr: UIView = {
        let v = UIView()
        v.backgroundColor = .systemGray4
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
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
        addSubview(detailScrollView)
        detailScrollView.addSubview(containerView)
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(authorDateLabel)
        containerView.addSubview(contentLabel)
        
        containerView.addSubview(hr)
        
        NSLayoutConstraint.activate([
            detailScrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            detailScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            detailScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            detailScrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            containerView.topAnchor.constraint(equalTo: detailScrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: detailScrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: detailScrollView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: detailScrollView.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: detailScrollView.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            
            authorDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            authorDateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            contentLabel.topAnchor.constraint(equalTo: authorDateLabel.bottomAnchor, constant:  20),
            contentLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            contentLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            hr.heightAnchor.constraint(equalToConstant: 1),
            hr.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            hr.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            hr.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            hr.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 20),
            hr.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
            
        ])
    }
}
