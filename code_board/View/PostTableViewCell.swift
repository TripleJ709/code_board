//
//  PostTableViewCell.swift
//  code_board
//
//  Created by 장주진 on 6/27/25.
//

import UIKit

// identifier -> PostCell(MainView.swift)
final class PostTableViewCell: UITableViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var authorTimeStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [authorLabel, timeLabel])
        sv.axis = .horizontal
        sv.spacing = 10
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.alignment = .leading
        return sv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(authorTimeStackView)
        
        authorLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        timeLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            authorTimeStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            authorTimeStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            authorTimeStackView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            authorTimeStackView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
    }
}
