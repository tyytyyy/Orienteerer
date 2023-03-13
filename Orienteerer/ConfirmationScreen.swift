
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
    var timelist: [UITextField] = []
    var inttimelist: [Int] = []
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
        var y = 170
        var x = 70
        var count = 0
        let height:Int = Int(UIScreen.main.bounds.height)
        for i in recognizedStrings{
            if(i.contains("(")&&i.contains(")")){
                let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 24))
                label.center = CGPoint(x: x, y: y)
                label.textAlignment = .center
                label.text = i
                label.font = UIFont(name:"Futura-Medium", size:24)
                self.view.addSubview(label)
                y = y+50
                
                if(y>height-100){
                    y = 170
                    x+=200
                }
                count+=1
            }
        }
        x = 160
        y = 170
        var count2 = -1
        for i in recognizedStrings{
            if(i.contains(":")){
                if(count2>0&&count2%2==1){
                    let label = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 24))
                    timelist.append(label)
                    inttimelist.append(converttoseconds(hours: i))
                    label.center = CGPoint(x: x, y: y)
                    label.textAlignment = .center
                    label.text = i
                    label.returnKeyType = .done
                    label.font = UIFont(name:"Futura-Medium", size:24)
                    label.addTarget(self, action: #selector(ConfirmationScreen.textFieldDidChange(_:)), for: .editingChanged)
                    self.view.addSubview(label)
                    
                    y = y+50
                    if(y>height-100){
                        y = 170
                        x+=200
                    }
                    print(count2)
                }
                count2+=1
                
            }
        }
    }
    
    func converttoseconds(hours: String?) -> Int!{
        if (hours==nil){
            return 0;
        }
        let timesplit = hours!.split(separator: ":")
        var timeseconds = 0
        var multiplyer = 1
        for n in timesplit.reversed(){
            timeseconds+=Int.parse(from: String(n))*multiplyer
            multiplyer*=60
        }
        return timeseconds
    }
    
    @objc func textFieldDidChange(_ label: UITextField) {
        let index = timelist.firstIndex(of: label)!
        print("UWU")
        inttimelist[index] = converttoseconds(hours: label.text!)
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
extension Int {
    static func parse(from string: String) -> Int {
        var k = Int(string.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
        if(k==nil){
            return 0;
        }
        return k!
    }
}
