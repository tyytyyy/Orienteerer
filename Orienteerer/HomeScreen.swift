//
//  HomeScreen.swift
//  Orienteerer
//
//  Created by Tom Yuan on 11/6/22.
//
 
import UIKit
import HealthKit
 
 
class HomeScreen: UIViewController{
    private var newHealthStore:HealthStore = HealthStore()
    
    public func getAccess() -> HealthStore{
        return newHealthStore
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newHealthStore.requestAuthorization{success in
                
        }        
        // Do any additional setup after loading the view.
        
 
    }
    
    @IBAction func nextScreen(_ sender: Any) {
        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "InProcessScreen") as! InProcessScreen
                self.navigationController?.pushViewController(secondVC, animated: true)
    }
    @IBAction func scanScreen(_ sender: Any) {
        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "ScanScreen") as! ScanScreen
                self.navigationController?.pushViewController(secondVC, animated: true)
    }
    
}
 
