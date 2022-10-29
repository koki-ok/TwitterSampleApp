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
    @IBOutlet weak var countLabel: UILabel!
    
    private let maxCount: Int = 140 // 文字数制限
    
    var tweetData = TweetModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "投稿" // ヘッダータイトルの変更
        
        setDoneButton()
        
        // 文字入力欄の枠線の色と太さを指定。ないとほぼ透明
        textView.layer.borderColor = UIColor.black.cgColor
        userNameTextField.layer.borderColor = UIColor.black.cgColor
        textView.layer.borderWidth = 1.0
        userNameTextField.layer.borderWidth = 1.0
        
        tapButton()
        
        textView.delegate = self
    }
    
    
    // 閉じるボタンを追加する。
    func setDoneButton() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        let commitButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tapDoneButton))
        toolBar.items = [commitButton]
        textView.inputAccessoryView = toolBar
        userNameTextField.inputAccessoryView = toolBar
    }
    
    // 閉じるボタンがタップされたら閉じる。
    @objc func tapDoneButton() {
        view.endEditing(true)
    }
    
    // 投稿ボタンがタップされた際の挙動。tapPostButtonメソッドが実行される。
    func tapButton() {
        postButton.addTarget(self, action: #selector(self.tapPostButton(_:)), for: UIControl.Event.touchUpInside)
    }
    
    // タップされた場合「モデル」に入力内容を「追加」する。
    @objc func tapPostButton(_ sender: UIButton) {
        print("tapされました")
        tweetData.userName = userNameTextField.text ?? ""
        tweetData.text = textView.text
//        tweetDataList.append(tweetData)
        saveData(with: tweetData.userName, text: tweetData.text)
    }
    
    // 上記でモデルに保存された内容を「Realm」に「保存」する。
    func saveData(with name: String, text: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.setTemplate(.full)
        let currentTime = Date()
                
        let realm = try! Realm()
        try! realm.write {
            tweetData.userName = name
            tweetData.text = text
            tweetData.recordDate = dateFormatter.string(from: currentTime)
            realm.add(tweetData) // tweetDataList
        }
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

// TableViewの変更内容を通知する。
extension NewPostController: UITextViewDelegate {
    
    // 文字数制限をする、UITextViewのdelegateメソッドであるshouldChangeTextin
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // 「入力された文字数」＋（「挿入しようとする文字数」ー「日本語時の選択範囲」）
        return textView.text.count + (text.count - range.length) <= maxCount
    }
    
    // 残り文字をカウントする
    func textViewDidChange(_ textView: UITextView) {
        self.countLabel.text = "\(maxCount - textView.text.count)"
    }
}
