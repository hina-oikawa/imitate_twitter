//
//  HomeTableViewCell.swift
//  Twitter
//
//  Created by 及川ひな on 2019/10/08.
//  Copyright © 2019 oikawa. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    var isLike: Bool = false

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setLayout(item: Item) {
        self.userNameLabel.text = item.userName
        self.userIdLabel.text = item.userId
        self.tweetLabel.text = item.tweet

        let image: UIImage = UIImage(named: item.image)!
        self.iconImageView.image = image
        self.iconImageView.circle()
    }
    
    @IBAction func isLike(_ sender: Any) {
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
