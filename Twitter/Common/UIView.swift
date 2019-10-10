//
//  UIImageView.swift
//  Twitter
//
//  Created by 及川ひな on 2019/10/08.
//  Copyright © 2019 oikawa. All rights reserved.
//

import UIKit

extension UIView {
    func circle() {
        layer.masksToBounds = false
        layer.cornerRadius = frame.width / 2
        clipsToBounds = true
    }

    func smailCircle() {
        layer.masksToBounds = false
        layer.cornerRadius = frame.width / 1.3
        clipsToBounds = true
    }
}
