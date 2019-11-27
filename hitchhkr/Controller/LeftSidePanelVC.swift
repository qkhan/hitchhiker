//
//  LeftSidePanelVC.swift
//  hitchhkr
//
//  Created by Qaisar Khan on 14/11/19.
//  Copyright © 2019 Qaisar Khan. All rights reserved.
//

import UIKit
import Firebase

class LeftSidePanelVC: UIViewController {

    let appDelegate = AppDelegate.getAppDelegate()
    
    let currentUserId = Auth.auth().currentUser?.uid
    
    @IBOutlet weak var UserAccountTypeLbl: UILabel!
    @IBOutlet weak var UserEmailLbl: UILabel!
    @IBOutlet weak var UserImageView: RoundImageView!
    @IBOutlet weak var loginOutBtn: UIButton!
    @IBOutlet weak var pickupModeSwitch: UISwitch!
    @IBOutlet weak var pickupModelLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pickupModeSwitch.isOn = false
        pickupModeSwitch.isHidden = true
        pickupModelLbl.isHidden = true
        
        observePassengersAndDrivers()
        
        if Auth.auth().currentUser == nil {
            UserEmailLbl.text = ""
            UserAccountTypeLbl.text = ""
            UserImageView.isHidden = true
            loginOutBtn.setTitle("Sign Up / Login", for: .normal)
        } else {
            UserEmailLbl.text = Auth.auth().currentUser?.email
            UserAccountTypeLbl.text = ""
            UserImageView.isHidden = false
            loginOutBtn.setTitle("Logout", for: .normal)
        }
    }
    
    
    @IBAction func switchWasToggled(_ sender: Any) {
        if pickupModeSwitch.isOn {
            pickupModelLbl.text = "PICKUP MODE ENABLED"
            appDelegate.menuContainerVC.toggleLeftPanel()
            DataService.instance.REF_DRIVERS.child(currentUserId!).updateChildValues(["isPickUpModeEnabled": true])
        } else {
            pickupModelLbl.text = "PICKUP MODE DISABLED"
            appDelegate.menuContainerVC.toggleLeftPanel()
            DataService.instance.REF_DRIVERS.child(currentUserId!).updateChildValues(["isPickUpModeEnabled": false])
        }
    
    }
    
    func observePassengersAndDrivers() {
        DataService.instance.REF_USERS.observeSingleEvent(of: .value, with: {(snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    if snap.key == Auth.auth().currentUser?.uid {
                        self.UserAccountTypeLbl.text = "PASSENGER"
                    }
                }
            }
        })
        
        DataService.instance.REF_DRIVERS.observeSingleEvent(of: .value, with: {(snapshot) in
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshot {
                    if snap.key == Auth.auth().currentUser?.uid {
                        self.UserAccountTypeLbl.text = "DRIVER"
                        self.pickupModeSwitch.isHidden = false
                        
                        let switchStatus = snap.childSnapshot(forPath: "isPickupModeEnabled").value as! Bool
                        self.pickupModeSwitch.isOn = switchStatus
                        self.pickupModelLbl.isHidden = false
                    }
                }
            }
        })
    }
    

    @IBAction func signUpLoginBtnWasPressed(_ sender: Any) {
        if Auth.auth().currentUser == nil {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
            present(loginVC!, animated: true, completion: nil)
        }
        else {
            do {
                try Auth.auth().signOut()
                UserEmailLbl.text = ""
                UserAccountTypeLbl.text = ""
                UserImageView.isHidden = true
                pickupModelLbl.text = ""
                pickupModeSwitch.isHidden = true
                loginOutBtn.setTitle("Sign Up / Login", for: .normal)
            } catch (let error) {
                print(error)
            }
        }
    }
    

}
