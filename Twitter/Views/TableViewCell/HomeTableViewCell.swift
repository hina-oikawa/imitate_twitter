//
//  HomeTableViewCell.swift
//  Twitter
//
//  Created by 及川ひな on 2019/10/08.
//  Copyright © 2019 oikawa. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    var isLike: Bool = false
    var disposeBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setAction()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // disposeBagオブジェクトはセルの再利用のたびに新しく生成する必要がある
    override func prepareForReuse() {
        super.prepareForReuse()
        self.disposeBag = DisposeBag() // ここで毎回生成
    }

    func setLayout(item: Item) {
        self.userNameLabel.text = item.userName
        self.userIdLabel.text = item.userId
        self.tweetLabel.text = item.tweet

        let image: UIImage = UIImage(named: item.image)!
        self.iconImageView.image = image
        self.iconImageView.circle()
    }

    private func setAction() {
        // いいねボタンのタップアクションを定義
        self.likeButton.rx.tap.subscribe { [unowned self] _ in
            self.isLikeAction()
        }.disposed(by: disposeBag)
    }
    
    private func isLikeAction() {
        if isLike {
            // trueだったらいいねを外す
            self.likeButton.setTitle("♡", for: .normal)
            // isLikeをfalseにする
            self.isLike = !isLike
        } else {
            // falseだったらいいねをつける
            self.likeButton.setTitle("❤️", for: .normal)
            // isLikeをtrueにする
            self.isLike = !isLike

        }
    }
}
