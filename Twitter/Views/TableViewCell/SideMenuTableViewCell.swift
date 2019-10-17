//
//  SideMenuTableViewCell.swift
//  Twitter
//
//  Created by 及川ひな on 2019/10/17.
//  Copyright © 2019 oikawa. All rights reserved.
//

import UIKit

class SideMenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setLayout(imageName: String, detail: String) {
        self.detailLabel.text = detail

        let image: UIImage = UIImage(named: imageName)!
        self.iconImageView.image = image
    }
    
}
