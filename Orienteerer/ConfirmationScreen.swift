
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
        super.viewDidLoad()
        view.addSubview(label)
        view.addSubview(imageView)
        image1 = ScanScreen.image!
        let ciImage = CIImage(image: image1)!
        let ciContext = CIContext(options: nil)
        let cgImage = ciContext.createCGImage(ciImage, from: ciImage.extent)

        runtxtrec(cgimage: cgImage!)
    }
    
    
    func runtxtrec(cgimage: CGImage){
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
        }
        var y = 100
        var x = 50
        var count = 0
        for i in recognizedStrings{
            if(i.contains("(")&&i.contains(")")){
                let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 24))
                label.center = CGPoint(x: x, y: y)
                label.textAlignment = .center
                label.text = i
                label.font = UIFont(name:"Futura-Medium", size:24)
                self.view.addSubview(label)
                y = y+50
                if(y>800){
                    y = 100
                    x+=200
                }
                count+=1
            }
        }
        x = 150
        y = 100
        var count2 = -1
        for i in recognizedStrings{
            if(i.contains(":")){
                if(count2>0&&count2%2==1){
                    let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 24))
                    label.center = CGPoint(x: x, y: y)
                    label.textAlignment = .center
                    label.text = i
                    label.font = UIFont(name:"Futura-Medium", size:24)
                    self.view.addSubview(label)
                    y = y+50
                    if(y>800){
                        y = 100
                        x+=200
                    }
                    print(count2)
                }
                count2+=1
                
            }
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
