//
//  HomeVC
//  hitchhkr
//
//  Created by Qaisar Khan on 21/10/19.
//  Copyright © 2019 Qaisar Khan. All rights reserved.
//

import UIKit
import MapKit

class HomeVC: UIViewController {

    
    @IBOutlet weak var actionBtn: RoundedShadowButton!
    @IBOutlet weak var mapView: MKMapView!
    
    var delegate: CenterVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func actionButtonPressed(_ sender: Any) {
        actionBtn.animateButton(shouldLoad: true, withMessage: nil)
    }


    @IBAction func menuBtnWasPressed(_ sender: Any) {
        delegate?.toggleLeftPanel()
        
    }
    

}

