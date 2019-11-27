//
//  HomeVC
//  hitchhkr
//
//  Created by Qaisar Khan on 21/10/19.
//  Copyright © 2019 Qaisar Khan. All rights reserved.
//

import UIKit
import MapKit
import RevealingSplashView

class HomeVC: UIViewController {

    
    @IBOutlet weak var actionBtn: RoundedShadowButton!
    @IBOutlet weak var mapView: MKMapView!
    
    var delegate: CenterVCDelegate?
    
    let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "launchScreenIcon")!, iconInitialSize: CGSize(width:80, height:80), backgroundColor: UIColor.white)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //mapView.delegate = self as! MKMapViewDelegate
        
        self.view.addSubview(revealingSplashView)
        revealingSplashView.animationType = SplashAnimationType.heartBeat
        revealingSplashView.startAnimation()
        
        revealingSplashView.heartAttack = true
    }


    @IBAction func actionButtonPressed(_ sender: Any) {
        actionBtn.animateButton(shouldLoad: true, withMessage: nil)
    }


    @IBAction func menuBtnWasPressed(_ sender: Any) {
        delegate?.toggleLeftPanel()
        
    }
    

}

