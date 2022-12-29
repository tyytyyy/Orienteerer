//
//  InProcessScreen.swift
//  Orienteerer
//
//  Created by Tom Yuan on 12/7/22.
//

import UIKit

class InProcessScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func StopButton(_ sender: Any) {
        let ninthVC = self.storyboard?.instantiateViewController(withIdentifier: "EndScreenTwo") as! EndScreenTwo
                self.navigationController?.pushViewController(ninthVC, animated: true)
    }
    
    @IBAction func FinishButton(_ sender: Any) {
        let thirdVC = self.storyboard?.instantiateViewController(withIdentifier: "CongratulationsScreen") as! Congratulationsscreen
                self.navigationController?.pushViewController(thirdVC, animated: true)
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
