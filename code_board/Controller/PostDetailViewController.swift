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
        
        let postAuthorID = post?.userID
        
        if let data = UserDefaults.standard.data(forKey: "currentUser"),
           let currentUser = try? JSONDecoder().decode(User.self, from: data),
           let postAuthorID {
            if currentUser.id == postAuthorID {
                navigationItem.rightBarButtonItems = [
                    UIBarButtonItem(title: "수정", style: .plain, target: self, action: #selector(editPost)),
                    UIBarButtonItem(title: "삭제", style: .plain, target: self, action: #selector(deletePost))
                ]
            }
        }
        
        if let post {
            detailView.titleLabel.text = post.title
            detailView.authorDateLabel.text = "작성자: \(post.author)  \(formatterDate(post.createdAt))"
            detailView.contentLabel.text = post.content
        }
    }
    
    func formatterDate(_ createdAt: String) -> String {
        return DateFormatter.convert(createdAt, from: "EEE, dd MMM yyyy HH:mm:ss zzz", to: "yyyy년 M월 d일 HH:mm")
    }
    
    @objc func editPost() {
        guard let post else { return }
        let request = PostRequest(title: post.title, content: post.content, userID: post.userID)
        
        let updateVC = PostUpdateViewController(postID: post.id, postReqeust: request)
        navigationController?.pushViewController(updateVC, animated: true)
    }
    
    @objc func deletePost() {
        
    }
}
