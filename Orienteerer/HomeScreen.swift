//
//  HomeScreen.swift
//  Orienteerer
//
//  Created by Tom Yuan on 11/6/22.
//

import UIKit
import HealthKit


class HomeScreen: UIViewController {
    var healthStore : HKHealthStore?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextScreen(_ sender: Any) {
        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "InProcessScreen") as! InProcessScreen
                self.navigationController?.pushViewController(secondVC, animated: true)
    }
    
}

