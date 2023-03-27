//
//  MapScreen.swift
//  Orienteerer
//
//  Created by Kevin Yuan on 3/26/23.
//


import MapKit
import UIKit

class MapScreen: UIViewController
{
    @IBOutlet var doneButton: UIButton!
    lazy var mapView:MKMapView = {
        let map = MKMapView()
        map.showsUserLocation = true
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    override func viewDidLoad(){
        super.viewDidLoad()
        setupUI()
        view.bringSubviewToFront(doneButton)

    }
    private func setupUI(){
        view.addSubview(mapView)
        mapView.widthAnchor.constraint(equalTo:view.widthAnchor).isActive = true
        mapView.heightAnchor.constraint(equalTo:view.heightAnchor).isActive = true
        mapView.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        mapView.centerYAnchor.constraint(equalTo:view.centerYAnchor).isActive = true
    }
    @IBAction func FinishButton(_ sender: Any) {
        let thirdVC = self.storyboard?.instantiateViewController(withIdentifier: "ScanScreen") as! ScanScreen
                self.navigationController?.pushViewController(thirdVC, animated: true)
    }
}
