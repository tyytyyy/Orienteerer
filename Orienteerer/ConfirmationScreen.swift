
//
//  ConfirmationScreen.swift
//  Orienteerer
//
//  Created by Kevin Yuan on 12/25/22.
//

import UIKit
import Vision


class ConfirmationScreen: UIViewController {
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "example1")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.frame = CGRect(x:20, y: view.safeAreaInsets.top, width: view.frame.size.width-40, height: view.frame.size.width-40)
        label.frame = CGRect(x: 20, y:view.frame.size.width+view.safeAreaInsets.top, width: view.frame.size.width-40, height: 200)
    }
    
    var image1: UIImage!
    var cgImage: CGImage!
    override func viewDidLoad() {
        print("ehoaiwjhoiejawe")
        super.viewDidLoad()
        view.addSubview(label)
        view.addSubview(imageView)
        if(ScanScreen.image==nil){
            print("AWEOAWIOEJOA      WIJEWOAMIDWAMIDx")
        }
        image1 = ScanScreen.image!
        let ciImage = CIImage(image: image1)!
        let ciContext = CIContext(options: nil)
        let cgImage = ciContext.createCGImage(ciImage, from: ciImage.extent)

        if(image1==nil){
            print("AWEOAWIOEJOA      WIJEWOAMIDWAMIDx")
        }
        if(cgImage==nil){
            print("AWEOAWIOEJOA      WIJEWOAMIDWAMIDx")
        }
        runtxtrec(cgimage: cgImage!)
    }
    
    
    func runtxtrec(cgimage: CGImage){
        guard let navigationController = self.navigationController else { return }
        var navigationArray = navigationController.viewControllers // To get all UIViewController stack as Array
        navigationArray.remove(at: navigationArray.count - 1) // To remove previous UIViewController
        self.navigationController?.viewControllers = navigationArray
        let requestHandler = VNImageRequestHandler(cgImage: cgimage)

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
        }.joined(separator:", ")
        
        DispatchQueue.main.async{
            self.label.text = recognizedStrings
        }
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
