//
//  UIViewExt.swift
//  hitchhkr
//
//  Created by Qaisar Khan on 16/11/19.
//  Copyright © 2019 Qaisar Khan. All rights reserved.
//

import UIKit

extension UIView {
    func fadeTo(alphaValue: CGFloat, withDuration duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.alpha = alphaValue
        }
    }
}
