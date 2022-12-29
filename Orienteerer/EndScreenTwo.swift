//
//  EndScreenTwo.swift
//  Orienteerer
//
//  Created by Kevin Yuan on 12/29/22.
//

import UIKit

class EndScreenTwo: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func ReturnHomeTwo(_ sender: Any) {
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

