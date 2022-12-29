//
//  InitializationScreen.swift
//  Orienteerer
//
//  Created by Kevin Yuan on 12/29/22.
//

import UIKit

class InitializationScreen: UIViewController {
    @IBAction func AcceptTerms(_ sender: Any) {
        let eigthVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeScreen") as! HomeScreen
                self.navigationController?.pushViewController(eigthVC, animated: true)
    }
}
