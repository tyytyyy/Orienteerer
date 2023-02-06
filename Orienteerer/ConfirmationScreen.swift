//
//  ConfirmationScreen.swift
//  Orienteerer
//
//  Created by Kevin Yuan on 12/25/22.
//

import UIKit
import Vision

class ConfirmationScreen: UIViewController {
    
    var image: UIImage!
    var CIIMAGE: CIImage!
    var cgImage: CGImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "ScanScreen") as! ScanScreen
                self.navigationController?.pushViewController(secondVC, animated: true)
        //Image (hopefully)
        image = secondVC.returnPhoto()
        cgImage = UIImage(named: "image")?.cgImage
        let requestHandler = VNImageRequestHandler(cgImage: cgImage)

        // Create a new request to recognize text.
        let request = VNRecognizeTextRequest(completionHandler: recognizeTextHandler)

        do {
            // Perform the text-recognition request.
            try requestHandler.perform([request])
        } catch {
            print("Unable to perform the requests: \(error).")
        }
        
    }
    
    func recognizeTextHandler(request: VNRequest, error: Error?) {
        guard let observations =
                request.results as? [VNRecognizedTextObservation] else {
            return
        }
        let recognizedStrings = observations.compactMap { observation in
            // Return the string of the top VNRecognizedText instance.
            return observation.topCandidates(1).first?.string
        }
        
        // Process the recognized strings.
    }
    
    @IBAction func RetakePicture(_ sender: Any) {
        let fifthVC = self.storyboard?.instantiateViewController(withIdentifier: "ScanScreen") as! ScanScreen
                self.navigationController?.pushViewController(fifthVC, animated: true)
    }
    @IBAction func ConfirmPicture(_ sender: Any) {
        let sixthVC = self.storyboard?.instantiateViewController(withIdentifier: "EndScreen") as! EndScreen
                self.navigationController?.pushViewController(sixthVC, animated: true)
    }
    
    
    
}
