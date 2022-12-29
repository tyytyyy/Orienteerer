//
//  ScanScreen.swift
//  Orienteerer
//
//  Created by Tom Yuan on 12/8/22.
//

import UIKit

class ScanScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    let image = UIImage(named: "IMG_0166")

    @IBAction func TakePicture(_ sender: Any) {
        let fourthVC = self.storyboard?.instantiateViewController(withIdentifier: "ConfirmationScreen") as! ConfirmationScreen
                self.navigationController?.pushViewController(fourthVC, animated: true)
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

