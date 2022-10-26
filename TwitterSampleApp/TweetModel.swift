//
//  TweetModel.swift
//  TwitterSampleApp
//
//  Created by 岡村幸樹 on 2022/10/25.
//

import Foundation
import RealmSwift

class TweetModel: Object {
    // データの一意性を担保するために、それぞれに一意の文字列を付与
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var userName: String = ""
    @objc dynamic var text: String = ""
}
