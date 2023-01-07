//
//  HomeScreen.swift
//  Orienteerer
//
//  Created by Tom Yuan on 11/6/22.
//
 
import UIKit
import HealthKit
 
 
class HomeScreen: UIViewController{
    private var healthStore:HealthStore? = HealthStore()
    
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let healthStore = healthStore{
            healthStore.requestAuthorization{success in
                
            }
        }
        // Do any additional setup after loading the view.
        
 
    }
    
    @IBAction func nextScreen(_ sender: Any) {
        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "InProcessScreen") as! InProcessScreen
                self.navigationController?.pushViewController(secondVC, animated: true)
    }
    
}
 
