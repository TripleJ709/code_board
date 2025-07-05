//
//  PostDetailViewController.swift
//  code_board
//
//  Created by 장주진 on 6/30/25.
//

import UIKit

class PostDetailViewController: UIViewController {
    
    let postService = PostService()
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
        updateVC.delegate = self
        navigationController?.pushViewController(updateVC, animated: true)
    }
    
    @objc func deletePost() {
        guard let post else { return }
        guard let data = UserDefaults.standard.data(forKey: "currentUser"),
              let currentUser = try? JSONDecoder().decode(User.self, from: data) else {
            showAlert(title: "오류", message: "로그인 정보를 불러올 수 없습니다.")
            return
        }
        let alert = UIAlertController(title: "삭제 확인", message: "정말 삭제하시겠습니까?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "삭제", style: .destructive, handler: { _ in
            self.postService.deletePost(postID: post.id, userID: currentUser.id) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let msg):
                        print("삭제 성공: ", msg)
                        self.navigationController?.popViewController(animated: true)
                    case .failure(let err):
                        print("삭제 실패: ", err)
                        self.showAlert(title: "삭제 실패", message: "글 삭제에 실패했습니다.")
                    }
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        present(alert, animated: true)
    }
}

extension PostDetailViewController: PostUpdateDelegate {
    func didUpdatePost() {
        guard let post else { return }
        
        postService.PostDetail(id: post.id) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let updatedPost):
                    self.post = updatedPost
                    self.detailView.titleLabel.text = updatedPost.title
                    self.detailView.authorDateLabel.text = "작성자: \(updatedPost.author)  \(self.formatterDate(updatedPost.createdAt))"
                    self.detailView.contentLabel.text = updatedPost.content
                case .failure(let error):
                    print("게시글 다시 불러오기 실패:", error)
                }
            }
        }
    }
}
