//
//  TweetViewController.swift
//  Twitter
//
//  Created by 及川ひな on 2019/10/09.
//  Copyright © 2019 oikawa. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var tweetButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setLayout()
    }

    private func setLayout() {
        // navigationBarの背景色を変更
        self.navigationBar.barTintColor = UIColor(hex: "17202A")
        // navigationBarの背景を半透明にしない
        self.navigationBar.isTranslucent = false
        // navigationBarのタイトルの文字色を変更
        self.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]

        // カスタムセルの登録
        self.tableView.register(UINib(nibName: "TweetTableViewCell", bundle: nil), forCellReuseIdentifier: "TweetCell")
        // セルの高さを指定(値はなんでもよい)
        self.tableView.estimatedRowHeight = 10000
        // セルの高さ計算をAutoLayoutに任せる(高さを可変にできる)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.showsVerticalScrollIndicator = true
        self.tableView.indicatorStyle = .white

    }
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func tweet(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}

extension TweetViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // どのセルを再利用させるか指定する
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell") as? TweetTableViewCell {
            // セルタップ時のハイライトを消す
            cell.selectionStyle = .none
            // TweetTextViewのDelegateをセット
            cell.delegate = self

            // セルに表示させるデータを渡しす
            return cell
        }
        // asによる方キャストが失敗してnilになった時にデフォルトのセルを返す
        return UITableViewCell()
    }

}


extension TweetViewController: TweetTextViewDelegate {
    func textViewDidChange(_ cell: TweetTableViewCell, _ textView: UITextView) {

        let size = textView.bounds.size
        let newSize = tableView.sizeThatFits(CGSize(width: size.width,
                                                    height: CGFloat.greatestFiniteMagnitude))
        if size.height != newSize.height {
            UIView.setAnimationsEnabled(false)
            tableView?.beginUpdates()
            tableView?.endUpdates()
            UIView.setAnimationsEnabled(true)
            if let thisIndexPath = tableView.indexPath(for: cell) {
                tableView.scrollToRow(at: thisIndexPath, at: .bottom, animated: false)
            }
        }
    }
}
