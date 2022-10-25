//
//  TweetTableViewCell.swift
//  TwitterSampleApp
//
//  Created by 岡村幸樹 on 2022/10/25.
//

import Foundation
import UIKit

class TweetTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var textContentLabel: UILabel!
    
    func configure(tweet: TweetModel) {
        let dateFormatter = DateFormatter()
        dateFormatter.setTemplate(.full)
        let currentTime = Date()
        
        nameLabel.text = tweet.userName
        dateLabel.text = dateFormatter.string(from: currentTime)
        textContentLabel.text = tweet.text
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
