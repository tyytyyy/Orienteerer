//
//  HomeScreen.swift
//  Orienteerer
//
//  Created by Tom Yuan on 11/6/22.
//

import UIKit

class HomeScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextScreen(_ sender: Any) {
        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "CongratulationsScreen") as! Congratulationsscreen
                self.navigationController?.pushViewController(secondVC, animated: true)
    }
}

