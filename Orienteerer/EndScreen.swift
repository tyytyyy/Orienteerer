//
//  EndScreen.swift
//  Orienteerer
//
//  Created by Tom Yuan on 11/27/22.
//

import UIKit

class EndScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func ReturnHome(_ sender: Any) {
        let fifthVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeScreen") as! HomeScreen
                self.navigationController?.pushViewController(fifthVC, animated: true)
    }
    
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

