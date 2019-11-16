//
//  CenterVCDelegate.swift
//  hitchhkr
//
//  Created by Qaisar Khan on 16/11/19.
//  Copyright © 2019 Qaisar Khan. All rights reserved.
//

import UIKit

protocol CenterVCDelegate {
    func toggleLeftPanel()
    func addLeftPanelViewController()
    func animateLeftPanel(shouldExpand: Bool)
}
