//
//  HomeViewController.swift
//  TwitterSampleApp
//
//  Created by 岡村幸樹 on 2022/10/25.
//

import UIKit
import RealmSwift

class HomeViewController: UIViewController {
    @IBAction func unwindSegue(for unwindSegue: UIStoryboardSegue, towards subsequentVC: UIViewController) {}
    
    @IBOutlet weak var tableView: UITableView!
    
    // 「TweetModel」に格納されたデータを使用できるようにする。
    var tweetDataList: [TweetModel] = []
    
    // viewDidLoadは、メモリが割り当てられた１回だけ呼び出される
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "ホーム"
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // 画面が呼び出されるたびに毎回呼び出される。データ更新による反映はこっちに書く。
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setTweetData()           // 画面が表示されるたびにデータがセットされる。
        tableView.reloadData()   // データを反映させるにはUITableViewにreloadDataをすることで反映させる。
    }
    
    func setTweetData() {
        let config = Realm.Configuration(schemaVersion: 1)
        Realm.Configuration.defaultConfiguration = config
        let realm = try! Realm()
        let result = realm.objects(TweetModel.self)
        tweetDataList = Array(result)
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
