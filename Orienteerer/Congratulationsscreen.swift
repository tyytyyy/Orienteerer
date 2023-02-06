//
//  Congratulationsscreen.swift
//  Orienteerer
//
//  Created by Tom Yuan on 11/27/22.
//

import UIKit
import ConfettiSwiftUI
class Congratulationsscreen: UIViewController {

    override func viewDidLoad() {
        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "ConfirmationScreen") as! ConfirmationScreen
        let seconds = 3.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.navigationController?.pushViewController(secondVC, animated: true)
            
        }
        super.viewDidLoad()
        
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
