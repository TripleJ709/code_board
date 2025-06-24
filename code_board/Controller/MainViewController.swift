//
//  mainViewController.swift
//  code_board
//
//  Created by 장주진 on 6/24/25.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource {
    let mainView = MainView()
    
    var posts: [Post] = [
            Post(id: 1, title: "첫 글입니다", author: "Auser", date: "2025-06-23"),
            Post(id: 2, title: "두 번째 글", author: "관리자", date: "2025-06-24"),
        ]
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.mainTableView.delegate = self
        mainView.mainTableView.dataSource = self
        mainView.mainTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let post = posts[indexPath.row]
        cell.textLabel?.text = "\(post.title) - \(post.author)"
        return cell
    }
}
