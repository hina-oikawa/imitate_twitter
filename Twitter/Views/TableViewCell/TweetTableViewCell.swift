//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by 及川ひな on 2019/10/09.
//  Copyright © 2019 oikawa. All rights reserved.
//

import UIKit

protocol TweetTextViewDelegate {
    func textViewDidChange(_ cell: TweetTableViewCell, _ textView: UITextView)
}

class TweetTableViewCell: UITableViewCell, UITextViewDelegate {


    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var dummyLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    var delegate: TweetTextViewDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.textView.delegate = self
        self.iconImageView.circle()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func textViewDidChange(_ textView: UITextView) {
        self.delegate?.textViewDidChange(self, self.textView)
        self.isHidden()
    }

    private func isHidden() {
        if self.textView.text.count >= 0 {
            self.dummyLabel.alpha = 0.0

        } else if self.textView.text.isEmpty {
            self.dummyLabel.alpha = 1.0
        }
    }
}

