//
//  PostUpdateViewController.swift
//  code_board
//
//  Created by 장주진 on 7/5/25.
//

import UIKit

class PostUpdateViewController: UIViewController {
    
    let postService = PostService()
    let createPostView = CreatePostView()
    
    var postID: Int
    var postReqeust: PostRequest
    
    init(postID: Int, postReqeust: PostRequest) {
        self.postID = postID
        self.postReqeust = postReqeust
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        view = createPostView
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        createPostView.createPostButton.setTitle("수정하기", for: .normal)
        createPostView.titleTextField.text = postReqeust.title
        createPostView.contentTextView.text = postReqeust.content
        createPostView.createPostButton.addTarget(self, action: #selector(updateBtnTapped), for: .touchUpInside)
    }

    @objc func updateBtnTapped() {
        let title = createPostView.titleTextField.text ?? ""
        let content = createPostView.contentTextView.text ?? ""
        
        guard !title.isEmpty, !content.isEmpty else {
            showAlert(title: "수정 실패", message: "제목과 내용을 모두 입력해 주세요.")
            return
        }
        
        guard let data = UserDefaults.standard.data(forKey: "currentUser"),
              let user = try? JSONDecoder().decode(User.self, from: data) else {
            showAlert(title: "오류", message: "로그인 정보를 불러올 수 없습니다.")
            return
        }
        
        let request = PostRequest(title: title, content: content, userID: user.id)
        
        postService.updatePost(postID: postID, request: request) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let msg):
                    print("수정 성공")
                    self.navigationController?.popViewController(animated: true)
                case .failure(let err):
                    print("수정 실패")
                    self.showAlert(title: "오류", message: "글 수정에 실패했습니다.")
                }
            }
        }
    }
}
