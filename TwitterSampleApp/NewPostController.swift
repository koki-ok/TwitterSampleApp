//
//  NewPostController.swift
//  TwitterSampleApp
//
//  Created by 岡村幸樹 on 2022/10/25.
//

import UIKit
import SwiftUI

class NewPostController: UIViewController {
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
        override func viewDidLoad() {
            super.viewDidLoad()
            self.navigationItem.title = "投稿"
            
            textView.layer.borderColor = UIColor.black.cgColor
            userNameTextField.layer.borderColor = UIColor.black.cgColor
            textView.layer.borderWidth = 1.0
            userNameTextField.layer.borderWidth = 1.0

        }
    
}
