//
//  SplashViewController.swift
//  Twitter
//
//  Created by 及川ひな on 2019/10/25.
//  Copyright © 2019 oikawa. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.logoImageView.tintColor = .white
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

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
                        self.view.backgroundColor = UIColor(hex: "17202A")
                        self.logoImageView.alpha = 0

        },
                       completion: { _ in
                        let sb = UIStoryboard(name: "Main", bundle: nil)
                        guard let vc = sb.instantiateInitialViewController() else { return }
                        vc.modalTransitionStyle = .crossDissolve
                        self.present(vc, animated: true, completion: nil)
        })

    }
}
