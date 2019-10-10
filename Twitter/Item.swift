//
//  Item.swift
//  Twitter
//
//  Created by 及川ひな on 2019/10/08.
//  Copyright © 2019 oikawa. All rights reserved.
//

import Foundation

class Item {
    var userName = ""
    var userId = ""
    var tweet = ""
    var image = ""

    init(userName: String, userId: String, tweet: String, image: String) {
        self.userName = userName
        self.userId = userId
        self.tweet = tweet
        self.image = image
    }
}
