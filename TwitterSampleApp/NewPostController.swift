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
            setDoneButton()
            
           
            textView.layer.borderColor = UIColor.black.cgColor
            userNameTextField.layer.borderColor = UIColor.black.cgColor
            textView.layer.borderWidth = 1.0
            userNameTextField.layer.borderWidth = 1.0
           
            tapButton()
           
       }
    
    func setDoneButton() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        let commitButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tapDoneButton))
        toolBar.items = [commitButton]
        textView.inputAccessoryView = toolBar
        userNameTextField.inputAccessoryView = toolBar
    }
    
    @objc func tapDoneButton() {
        view.endEditing(true)
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
        let dateFormatter = DateFormatter()
        dateFormatter.setTemplate(.full)
        let currentTime = Date()
        
        let realm = try! Realm()
        try! realm.write {
            tweetData.userName = name
            tweetData.text = text
            tweetData.recordDate = dateFormatter.string(from: currentTime)
            realm.add(tweetData)
        }
        print("userName: \(tweetData.userName), text:\(tweetData.text), recordDate:\(tweetData.recordDate)")
    }
    
    
}


extension DateFormatter {
    enum Template: String {
        case date = "yyMMdd"
        case time = "Hms"
        case full = "yMdkHms"
    }

    func setTemplate(_ template: Template) {
        dateFormat = DateFormatter.dateFormat(
            fromTemplate: template.rawValue,
            options: 0,
            locale: Locale(identifier: "ja_JP")
        )
    }
}
