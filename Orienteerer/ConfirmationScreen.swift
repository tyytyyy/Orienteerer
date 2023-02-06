//
//  ConfirmationScreen.swift
//  Orienteerer
//
//  Created by Kevin Yuan on 12/25/22.
//

import UIKit
import Vision

class ConfirmationScreen: UIViewController {
    
    var image: UIImage!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "ScanScreen") as! ScanScreen
                self.navigationController?.pushViewController(secondVC, animated: true)
        //Image (hopefully)
        image = secondVC.returnPhoto()
        
    }
    @IBAction func RetakePicture(_ sender: Any) {
        let fifthVC = self.storyboard?.instantiateViewController(withIdentifier: "ScanScreen") as! ScanScreen
                self.navigationController?.pushViewController(fifthVC, animated: true)
    }
    @IBAction func ConfirmPicture(_ sender: Any) {
        let sixthVC = self.storyboard?.instantiateViewController(withIdentifier: "EndScreen") as! EndScreen
                self.navigationController?.pushViewController(sixthVC, animated: true)
    }
    
    
    
}
