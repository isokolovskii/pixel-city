//
//  MapVC.swift
//  pixel-city
//
//  Created by Иван on 27.01.2018.
//  Copyright © 2018 iSOKOL DEV. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController {
    // Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
    }

    @IBAction func centerMapTapped(_ sender: Any) {
        
    }
    
}

extension MapVC: MKMapViewDelegate {
    
}
