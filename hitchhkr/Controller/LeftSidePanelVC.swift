//
//  LeftSidePanelVC.swift
//  hitchhkr
//
//  Created by Qaisar Khan on 14/11/19.
//  Copyright © 2019 Qaisar Khan. All rights reserved.
//

import UIKit

class LeftSidePanelVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func signUpLoginBtnWasPressed(_ sender: Any) {
        let storeyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
        present(loginVC!, animated: true, completion: nil)
    
    }
    

}
