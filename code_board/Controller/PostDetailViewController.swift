//
//  PostDetailViewController.swift
//  code_board
//
//  Created by 장주진 on 6/30/25.
//

import UIKit

class PostDetailViewController: UIViewController {
    
    let detailView = PostDetailView()
    var post: Post?
    
    override func loadView() {
        super.loadView()
        view = detailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let post {
            detailView.titleLabel.text = post.title
            detailView.authorDateLabel.text = "작성자: \(post.author)  \(formatterDate(post.createdAt))"
            detailView.contentLabel.text = post.content
        }
    }
    
    func formatterDate(_ createdAt: String) -> String {
        return DateFormatter.convert(createdAt, from: "EEE, dd MMM yyyy HH:mm:ss zzz", to: "yyyy년 M월 d일 HH:mm")
    }
}
