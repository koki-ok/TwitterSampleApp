//
//  HomeViewController.swift
//  TwitterSampleApp
//
//  Created by 岡村幸樹 on 2022/10/25.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    // 「TweetModel」に格納されたデータを使用できるようにする。
    var tweetDataList: [TweetModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "ホーム"
        tableView.dataSource = self
        tableView.delegate = self

        let tweet = TweetModel(userName: "ほげ", text: "ふがふがふがふがふがふがふがふがふがふがふがふがふがふがふがふが")
        
        let tweetni = TweetModel(userName: "ふが", text: "ふがごおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおおお")
        
        tweetDataList.append(tweet)
        tweetDataList.append(tweetni)
        
        
//        self.tweetDataList = [tweet]
//        self.tweetDataList = [tweetni]
        tableView.reloadData()
    }    
}


// セルタップなどを検知する機能の他にも、UITableViewの見た目や挙動に関する機能も含まれている。その設定
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("セルがタップされました。")
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // セルの見積もりの高さを指定する。
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    // セルの高さ指定をする。今回は自動的に反映させる。
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// UIViewControllerを編集する際に使用するのがUITableViewDataSource。
extension HomeViewController: UITableViewDataSource {
    // 「numberOfRowInSection」は、表示させるセルの数を設定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetDataList.count // 「tweetDataList」の数だけ表示させる。
    }
    // 「cellForRowAt」は、リストの中身を設定する。
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell()　// インスタンス化
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetTableViewCell") as! TweetTableViewCell
        // 0から始まる番号を表示される順番に渡す。
        cell.configure(tweet: tweetDataList[indexPath.row])
        return cell
    }
}
