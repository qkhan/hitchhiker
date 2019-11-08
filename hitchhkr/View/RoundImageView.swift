//
//  RoundImageView.swift
//  hitchhkr
//
//  Created by Qaisar Khan on 3/11/19.
//  Copyright © 2019 Qaisar Khan. All rights reserved.
//

import UIKit

class RoundImageView: UIImageView {

    override func awakeFromNib() {
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
}
