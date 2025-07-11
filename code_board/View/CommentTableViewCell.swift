//
//  CommentTableViewCell.swift
//  code_board
//
//  Created by 장주진 on 7/6/25.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.text = "작성자"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "작성 시간"
        label.font = .systemFont(ofSize: 10)
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
    
    lazy var authorDateStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [authorLabel, dateLabel])
        sv.axis = .horizontal
        sv.spacing = 5
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    lazy var commentStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [authorDateStackView, contentLabel])
        sv.axis = .vertical
        sv.spacing = 10
        sv.translatesAutoresizingMaskIntoConstraints = false
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
        contentView.addSubview(commentStackView)
        NSLayoutConstraint.activate([
            commentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            commentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            commentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            commentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
