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
import SideMenu
import JJFloatingActionButton

class HomeViewController: UIViewController {

    var items: [Item] = []
    let disposeBag = DisposeBag()

    @IBOutlet weak var splashView: UIView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    var iconLeftBarButton = UIBarButtonItem()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        self.setLayout()
        self.createData()
        self.setFloatingActionButtons()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // TODO:
        if self.logoImageView != nil {

            UIView.animate(withDuration: 0.5,
                           delay: 1.0,
                           options: .curveEaseOut,
                           animations: {
                            self.logoImageView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)

            }, completion: nil)

            UIView.animate(withDuration: 2.0,
                           delay: 1.5,
                           options: .curveEaseOut,
                           animations: {
                            self.logoImageView.transform = CGAffineTransform(scaleX: 100, y: 100)
                            self.logoImageView.alpha = 0
                            self.splashView.alpha = 0
                            self.navigationController?.setNavigationBarHidden(false, animated: false)

            },
                           completion: { _ in
                            self.logoImageView.removeFromSuperview()
                            self.splashView.removeFromSuperview()
            })
        }

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

        self.iconLeftBarButton = UIBarButtonItem(customView: iconButton)
        let currWidth = iconLeftBarButton.customView?.widthAnchor.constraint(equalToConstant: 30)
        currWidth?.isActive = true
        let currHeight = iconLeftBarButton.customView?.heightAnchor.constraint(equalToConstant: 30)
        currHeight?.isActive = true
        iconLeftBarButton.customView?.smailCircle()
        self.navigationItem.leftBarButtonItem = iconLeftBarButton

        // Splashアニメーションのため、navigationBarとtabBarを非表示にする
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.navigationBar.alpha = 0
        // カスタムセルの登録
        self.tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeCell")
        // セルの高さを指定(値はなんでもよい)
        self.tableView.estimatedRowHeight = 100
        // セルの高さ計算をAutoLayoutに任せる(高さを可変にできる)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.showsVerticalScrollIndicator = true
        self.tableView.indicatorStyle = .white
    }

    private func setFloatingActionButtons() {
        let actionButton = JJFloatingActionButton()

        actionButton.addItem(title: "Tweet", image: UIImage(named: "camera")?.withRenderingMode(.alwaysTemplate)) { item in
            self.presentTweetViewController()
        }

        actionButton.addItem(title: "item 2", image: UIImage(named: "camera")?.withRenderingMode(.alwaysTemplate)) { item in
            self.presentImagePickerController(type: "image")
        }

        actionButton.addItem(title: "item 3", image: nil) { item in
            self.presentImagePickerController(type: "movie")
        }

        view.addSubview(actionButton)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true

    }

    private func presentTweetViewController() {
        let storyboard = UIStoryboard(name: "TweetViewController", bundle: nil)
        let tweetViewController = storyboard.instantiateViewController(withIdentifier: "TweetViewController") as! TweetViewController
        self.present(tweetViewController, animated: true, completion: nil)
    }

    private func presentImagePickerController(type: String) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.mediaTypes = ["public." + type]
        self.present(imagePickerController, animated: true)
    }

    // TODO: サイドメニューを表示させる(いずれはRxにしたい)
    @objc func hoge() {
        let storyboard = UIStoryboard(name: "SideMenuViewController", bundle: nil)
        let navigationController = storyboard.instantiateViewController(withIdentifier: "navigation") as! UISideMenuNavigationController
        self.present(navigationController, animated: true, completion: nil)
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

// TODO: 邪魔なので一番下に移動(いずれは削除する)
extension HomeViewController {
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
