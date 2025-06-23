//
//  mainView.swift
//  code_board
//
//  Created by 장주진 on 6/24/25.
//

import UIKit

class MainView: UIView {
    let tempLabel: UILabel = {
        var label = UILabel()
        label.text = "메인화면"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray4
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        addSubview(tempLabel)
        NSLayoutConstraint.activate([
            tempLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            tempLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
