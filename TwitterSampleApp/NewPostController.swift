//
//  NewPostController.swift
//  TwitterSampleApp
//
//  Created by 岡村幸樹 on 2022/10/25.
//

import UIKit
import SwiftUI
import RealmSwift

class NewPostController: UIViewController {
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var postButton: UIButton!
    
    var tweetData = TweetModel()
    var tweetDataList: [TweetModel] = []
    
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
        let tweet = TweetModel()
        tweet.userName = userNameTextField.text ?? ""
        tweet.text = textView.text
        tweetDataList.append(tweet)
        saveData(with: tweet.userName, text: tweet.text)
    }
    
    func saveData(with name: String, text: String) {
        let realm = try! Realm()
        try! realm.write {
            tweetData.userName = name
            tweetData.text = text
            realm.add(tweetData)
        }
        print("userName: \(tweetData.userName), text\(tweetData.text)")
    }
    
    
}
