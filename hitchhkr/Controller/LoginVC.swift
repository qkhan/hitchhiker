//
//  LoginVC.swift
//  hitchhkr
//
//  Created by Qaisar Khan on 18/11/19.
//  Copyright © 2019 Qaisar Khan. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailField: RounderCornerTextField!
    @IBOutlet weak var passwordField: RounderCornerTextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var authBtn: RoundedShadowButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bindtoKeyboard()
        emailField.delegate = self
        passwordField.delegate = self
        
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap(sender:)))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func handleScreenTap(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }

    @IBAction func cancelBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func authBtnWasPressed(_ sender: Any) {
        
        if emailField.text != nil && passwordField.text != nil {
            authBtn.animateButton(shouldLoad: true, withMessage: nil)
            self.view.endEditing(true)
            
            if let email = emailField.text, let password = passwordField.text {
                Auth.auth().signIn(withEmail: email,
                  password: password,
                  completion: { (user, error) in
                    if error == nil {
                        if let user = user {
                            if self.segmentedControl.selectedSegmentIndex == 0 {
                                let userData = ["provider": user.user.providerID] as [String: Any]
                                DataService.instance.createFirebaseDBUser(uid: user.user.uid, userData: userData, isDriver: false)
                            }
                            else {
                                let userData = ["provider": user.user.providerID,
                                "userIsDriver": true, "isPickupModeEnabled" : false,
                                "driveIsOnTrip": false] as [String: Any]
                                
                                DataService.instance.createFirebaseDBUser(uid: user.user.uid, userData: userData, isDriver: true)
                            }
                        }
                        print("Email user authenticated successfully with Firebase")
                        self.dismiss(animated: true, completion: nil)
                    }//if error == nil
                    else {
                        Auth.auth().createUser(withEmail: email,
                           password: password,
                           completion: { (user, error) in
                           if error != nil {
                                if let errCode = AuthErrorCode(rawValue: error!._code) {
                                    switch errCode {
                                        case .wrongPassword:
                                            print("That was wrong password")
                                        case .invalidEmail:
                                            print("Invalid Email, please try again")
                                        
                                        case .userNotFound:
                                            print("User is not found")
                                        case .emailAlreadyInUse:
                                            print("Email is already in use.")
                                        case .weakPassword:
                                            print("password is week")
                                        default:
                                             print("UnExpected error happened, please try again.")
                                    }//switch errCode
                                }//let errCode = AuthErrorCode
                           } else {
                                if let user = user {
                                    if self.segmentedControl.selectedSegmentIndex == 0 {
                                        let userData = ["provider": user.user.providerID] as [String: Any]
                                        DataService.instance.createFirebaseDBUser(uid: user.user.uid, userData: userData, isDriver: false)
                                    } else {
                                        let userData = ["provider": user.user.providerID,
                                                        "userIsDriver": true, "isPickupModeEnabled" : false,
                                                        "driveIsOnTrip": false] as [String: Any]
                                        
                                        DataService.instance.createFirebaseDBUser(uid: user.user.uid, userData: userData, isDriver: true)
                                    }
                                }//let user
                                print("Successfully created a new user with Firebase")
                                self.dismiss(animated: true, completion: nil)
                           } //else error != nil
                        }) // completion
                    }// else if error == null
                   
                })//completion Auth.auth().signIn(withEmail
            } //email = emailField.text, let password = passwordField.t
        }//if emailField.text != nil && passwordField.text != nil
    } //func authBtnWasPressed(_

}
