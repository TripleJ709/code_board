//
//  mainViewController.swift
//  code_board
//
//  Created by 장주진 on 6/24/25.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource {
    let mainView = MainView()
    let postService = PostService()
    var posts: [Post] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchData()
    }
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "게시판"
        mainView.mainTableView.delegate = self
        mainView.mainTableView.dataSource = self
        mainView.mainTableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostCell")
        fetchData()
        setupFloatingButton()
    }
    
    func fetchData() {
        postService.fetchPosts { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let posts):
                    self?.posts = posts
                    self?.mainView.mainTableView.reloadData()
                case .failure(let error):
                    print("데이터 불러오기 실패: ", error)
                }
            }
        }
    }
    
    func setupFloatingButton() {
        let button: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("+", for: .normal)
            button.titleLabel?.font = .boldSystemFont(ofSize: 30)
            button.tintColor = .white
            button.backgroundColor = .blue
            button.layer.cornerRadius = 30
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            button.widthAnchor.constraint(equalToConstant: 60),
            button.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        button.addTarget(self, action: #selector(floatingBtnTapped), for: .touchUpInside)
    }

    @objc func floatingBtnTapped() {
        let createPostVC = CreatePostViewController()
        navigationController?.pushViewController(createPostVC, animated: true)
//        createPostVC.modalPresentationStyle = .fullScreen
//        self.present(createPostVC, animated: true)
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostTableViewCell else { return UITableViewCell()}
        let post = posts[indexPath.row]
        cell.titleLabel.text = post.title
        cell.authorLabel.text = post.author
        cell.timeLabel.text = post.formattedDate
        return cell
    }
}
