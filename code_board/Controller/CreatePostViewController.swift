//
//  CreatePostViewController.swift
//  code_board
//
//  Created by 장주진 on 6/28/25.
//

import UIKit

class CreatePostViewController: UIViewController {
    
    let postService = PostService()
    let createPostView = CreatePostView()
    
    override func loadView() {
        super.loadView()
        
        self.view = createPostView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "글쓰기"
        createPostView.createPostButton.addTarget(self, action: #selector(createPostBtnTapped), for: .touchUpInside)
    }

    @objc func createPostBtnTapped() {
        let title = createPostView.titleTextField.text ?? ""
        let content = createPostView.contentTextView.text ?? ""
        
        guard !title.isEmpty, !content.isEmpty else {
            showAlert(title: "글 쓰기 실패", message: "제목과 내용을 모두 입력해 주세요.")
            return
        }
        
        if let data = UserDefaults.standard.data(forKey: "currentUser"),
           let user = try? JSONDecoder().decode(User.self, from: data) {
            print("생성 if let 실행됨")
            let userId = user.id
            
            let reqeust = PostRequest(title: title, content: content, userID: userId)
            
            postService.createPost(request: reqeust) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let message):
                        print("글 쓰기 성공: ", message)
                        //self.dismiss(animated: true)
                        self.navigationController?.popViewController(animated: true)
                    case .failure(let error):
                        print("글 쓰기 실패: ", error)
                    }
                }
            }
        }
    }
}
