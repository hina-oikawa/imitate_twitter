//
//  SideMenuViewController.swift
//  Twitter
//
//  Created by 及川ひな on 2019/10/11.
//  Copyright © 2019 oikawa. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SideMenuViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var iconImageView: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    
    var imageNames: [String] = ["profile.png", "list.png", "bookmark.png", "moment.png", "request.png"]
    var detailNames: [String] = ["プロフィール", "リスト", "ブックマーク", "モーメント", "フォローリクエスト"]
    var otherNames: [String] = ["設定とプライバシー", "ヘルプセンター"]
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setLayout()
        self.setAction()
    }

    private func setLayout() {
        // ナビゲーションバーを非表示にする
        self.navigationController?.navigationBar.isHidden = true

        // imageを丸くする
        self.iconImageView.circle()

        // カスタムセルの登録
        self.tableView.register(UINib(nibName: "SideMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "SideMenuCell")
        // セルの高さを指定(値はなんでもよい)
        self.tableView.estimatedRowHeight = 10000
        // セルの高さ計算をAutoLayoutに任せる(高さを可変にできる)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.showsVerticalScrollIndicator = true
        self.tableView.indicatorStyle = .white

    }

    private func setAction() {
        // フローティングボタンタップ時のアクションを定義
        self.cameraButton.rx.tap.subscribe { [weak self] _ in
            let storyboard = UIStoryboard(name: "CameraViewController", bundle: nil)
            let cameraViewController = storyboard.instantiateViewController(withIdentifier: "CameraViewController") as! CameraViewController
            self?.present(cameraViewController, animated: true, completion: nil)
            }.disposed(by: self.disposeBag)
    }

}

extension SideMenuViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.detailNames.count
        case 1:
            return 2
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            // どのセルを再利用させるか指定する
            if let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuCell") as? SideMenuTableViewCell {
                // セルタップ時のハイライトを消す
                cell.selectionStyle = .none
                cell.setLayout(imageName: self.imageNames[indexPath.row], detail: self.detailNames[indexPath.row])
                cell.iconImageView.tintColor = .white

                // セルに表示させるデータを渡しす
                return cell
            }
            // asによる方キャストが失敗してnilになった時にデフォルトのセルを返す
            return UITableViewCell()

        case 1:
            let cell = UITableViewCell()
            cell.textLabel?.textColor = .lightGray
            cell.textLabel?.text = self.otherNames[indexPath.row]
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor(hex: "17202A")
            return cell

        default:
            let cell = UITableViewCell()
            cell.backgroundColor = UIColor(hex: "17202A")
            return cell
        }

    }


}
