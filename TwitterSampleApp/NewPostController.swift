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
    @IBOutlet weak var postButton: UIButton!
    
       override func viewDidLoad() {
            super.viewDidLoad()
            self.navigationItem.title = "投稿"
            
            textView.layer.borderColor = UIColor.black.cgColor
            userNameTextField.layer.borderColor = UIColor.black.cgColor
            textView.layer.borderWidth = 1.0
            userNameTextField.layer.borderWidth = 1.0
           
           tapButton()
           
       }
    
    func tapButton() {
        postButton.addTarget(self, action: #selector(self.tapPostButton(_:)), for: UIControl.Event.touchUpInside)
    }
    
    @objc func tapPostButton(_ sender: UIButton) {
        print("tapされました")
    }
    
}
