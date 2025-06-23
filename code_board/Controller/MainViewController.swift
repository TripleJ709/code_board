//
//  mainViewController.swift
//  code_board
//
//  Created by 장주진 on 6/24/25.
//

import UIKit

class MainViewController: UIViewController {
    
    let mainView = MainView()
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
