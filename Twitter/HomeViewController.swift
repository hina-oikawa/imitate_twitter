//
//  ViewController.swift
//  Twitter
//
//  Created by 及川ひな on 2019/10/08.
//  Copyright © 2019 oikawa. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {

    var items: [Item] = []
    let disposeBag = DisposeBag()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var floatingButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        self.setLayout()
        self.setAction()
        self.createData()
    }

    private func setLayout() {
        // navigationBarの背景色を変更
        self.navigationController?.navigationBar.barTintColor = UIColor(hex: "17202A")
        // navigationBarの背景を半透明にしない
        self.navigationController?.navigationBar.isTranslucent = false
        // navigationBarのタイトルの文字色を変更
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]

        // tabBarの背景色を変更
        self.tabBarController?.tabBar.barTintColor = UIColor(hex: "17202A")
        // tabBarの背景を半透明にしない
        self.tabBarController?.tabBar.isTranslucent = false

        // navigationBarのボタンを画像にする
        let iconButton = UIButton(type: .custom)
        iconButton.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
        iconButton.setImage(UIImage(named:"hina.jpeg")!.withRenderingMode(.alwaysOriginal), for: .normal)
        iconButton.addTarget(self, action: #selector(hoge), for: .touchUpInside)

        let iconLeftBarButton = UIBarButtonItem(customView: iconButton)
        let currWidth = iconLeftBarButton.customView?.widthAnchor.constraint(equalToConstant: 30)
        currWidth?.isActive = true
        let currHeight = iconLeftBarButton.customView?.heightAnchor.constraint(equalToConstant: 30)
        currHeight?.isActive = true
        iconLeftBarButton.customView?.smailCircle()
        self.navigationItem.leftBarButtonItem = iconLeftBarButton

        self.floatingButton.circle()

        // カスタムセルの登録
        self.tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeCell")
        // セルの高さを指定(値はなんでもよい)
        self.tableView.estimatedRowHeight = 100
        // セルの高さ計算をAutoLayoutに任せる(高さを可変にできる)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.showsVerticalScrollIndicator = true
        self.tableView.indicatorStyle = .white
    }

    private func setAction() {
        // フローティングボタンタップ時のアクションを定義
        self.floatingButton.rx.tap.subscribe { [unowned self] _ in
            let storyboard = UIStoryboard(name: "TweetViewController", bundle: nil)
            let tweetViewController = storyboard.instantiateViewController(withIdentifier: "TweetViewController") as! TweetViewController
            self.present(tweetViewController, animated: true, completion: nil)
        }.disposed(by: self.disposeBag)
    }

    // TODO: サイドメニューを表示させる
    @objc func hoge() {
        print("hoge")
    }

    private func createData() {
        self.items = [
            Item(userName: "Kon_pippiana", userId: "@Kon_741113", tweet: "疲れたあああああああああああああああああああああああああああああああああああああああああああああああ", image: "hina.jpeg"),
            Item(userName: "NON STYLE 石田彰", userId: "@gakuishida", tweet: "井上マジ無理", image: "ishida.jpeg"),
            Item(userName: "マクドナルド", userId: "McDonaldsJapan", tweet: "チキンクリスプ", image: "mc.jpeg"),
            Item(userName: "Kon_pippiana", userId: "@Kon_741113", tweet: "疲れた", image: "hina.jpeg"),
            Item(userName: "NON STYLE 石田彰", userId: "@gakuishida", tweet: "井上マジ無理", image: "ishida.jpeg"),
            Item(userName: "マクドナルド", userId: "McDonaldsJapan", tweet: "チキンクリスプ", image: "mc.jpeg"),
            Item(userName: "Kon_pippiana", userId: "@Kon_741113", tweet: "疲れた", image: "hina.jpeg"),
            Item(userName: "NON STYLE 石田彰", userId: "@gakuishida", tweet: "井上マジ無理", image: "ishida.jpeg"),
            Item(userName: "マクドナルド", userId: "McDonaldsJapan", tweet: "チキンクリスプ", image: "mc.jpeg")]
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // どのセルを再利用させるか指定する
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell") as? HomeTableViewCell {
            // セルタップ時のハイライトを消す
            cell.selectionStyle = .none
            // セルに表示させるデータを渡しす
            cell.setLayout(item: self.items[indexPath.row])

            return cell
        }
        // asによる方キャストが失敗してnilになった時にデフォルトのセルを返す
        return UITableViewCell()
    }

}
