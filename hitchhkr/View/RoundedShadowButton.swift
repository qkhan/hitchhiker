//
//  RoundedShadowButton.swift
//  hitchhkr
//
//  Created by Qaisar Khan on 3/11/19.
//  Copyright © 2019 Qaisar Khan. All rights reserved.
//

import UIKit

class RoundedShadowButton: UIButton {

    var orignalSize: CGRect?
    
    func setupView() {
        orignalSize = self.frame
        self.layer.cornerRadius = 5.0
        self.layer.shadowRadius = 10.0
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize.zero
    }
    
    override func awakeFromNib() {
        setupView()
    }
    
    func animateButton(shouldLoad: Bool, withMessage message: String?) {
        let spinner = UIActivityIndicatorView()
        spinner.style = .whiteLarge
        spinner.alpha = 0.0
        spinner.hidesWhenStopped = true
        spinner.tag = 21
        
        if shouldLoad {
            self.addSubview(spinner)
            //spinner.startAnimating()
            self.setTitle("", for: .normal)
            UIView.animate(withDuration: 0.2, animations: {
                    self.layer.cornerRadius = self.frame.height / 2
                    self.frame = CGRect(x: self.frame.midX - (self.frame.height / 2), y: self.frame.origin.y, width: self.frame.height, height: self.frame.height)
            }, completion: { (finished) in
                if finished == true {
                    //self.addSubview(spinner)
                    spinner.startAnimating()
                    spinner.center = CGPoint(x: self.frame.width / 2 + 1, y: self.frame.width / 2 + 1)
                    UIView.animate(withDuration: 0.2, animations: {spinner.alpha = 1.0 })
                }
            })
            self.isUserInteractionEnabled = false
        }
        else {
            self.isUserInteractionEnabled = true
            for subview in self.subviews {
                if subview.tag == 21 {
                    subview.removeFromSuperview()
                }
            }
            
            UIView.animate(withDuration: 0.2, animations: {
                self.layer.cornerRadius = 5.0
                self.frame = self.orignalSize!
                self.setTitle(message, for: .normal)
            })
        }
    }
}
