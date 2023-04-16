
//
//  ConfirmationScreen.swift
//  Orienteerer
//
//  Created by Kevin Yuan on 12/25/22.
//

import UIKit
import Vision
import Foundation

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
    
    func increaseContrast(_ image: UIImage) -> UIImage {
        let inputImage = CIImage(image: image)!
        let parameters = [
            "inputContrast": NSNumber(value: 2)
        ]
        let outputImage = inputImage.applyingFilter("CIColorControls", parameters: parameters)

        let context = CIContext(options: nil)
        let img = context.createCGImage(outputImage, from: outputImage.extent)!
        return UIImage(cgImage: img)
    }
    
    var image1: UIImage!
    var cgImage: CGImage!
    var timelist: [UITextField] = []
    var inttimelist: [Int] = []
    //timelist contains labels, inttimelist contains time in seconds
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        view.addSubview(imageView)
        image1 = increaseContrast(ScanScreen.image!)
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
        
        var strlist = [String]()
        var intlist = [Int]()
        let height:Int = Int(UIScreen.main.bounds.height)
        var numvariables = 0
        for i in recognizedStrings{
            if(i.contains("(")&&i.contains(")")){
                let t = i[...i.firstIndex(of: ")")!]
                var time = String(i[i.firstIndex(of: ")")!...])
                if(time.count>2){
                    let index1 = time.index(time.startIndex, offsetBy: 2)
                    time = String(time[index1...])
                    print("aaa")
                }
                print(time)
                if time.isNumeric && time.contains(":"){
                    intlist.append(converttoseconds(hours: time))
                    strlist.append(time)
                }
                let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 24))
                label.center = CGPoint(x: x, y: y)
                label.textAlignment = .center
                label.text = String(t)
                label.font = UIFont(name:"Futura-Medium", size:UIScreen.main.bounds.width/17.91666667)
                self.view.addSubview(label)
                numvariables += 1
                y = y+Int(UIScreen.main.bounds.height/18.64)
                
                if(y>height-100){
                    y = 170
                    x+=Int(UIScreen.main.bounds.width/2.15)
                }
                count+=1
            }
        }
        
        
        x = 160
        y = 170
        count = 0
        
        
        for i in recognizedStrings{
            if(i.contains(":")&&count>0&&i.isNumeric){
                strlist.append(i)
                intlist.append(converttoseconds(hours: i))
            }
            else if (i.contains(":")){
                count+=1;
            }
        }
        
        var newlist = convertlist(list1: strlist, list2: intlist)
        for i in newlist{
            let label = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 24))
            timelist.append(label)
            label.center = CGPoint(x: x, y: y)
            label.textAlignment = .center
            label.text = i
            label.returnKeyType = .done
            label.font = UIFont(name:"Futura-Medium", size:UIScreen.main.bounds.width/17.91666667)
            label.addTarget(self, action: #selector(ConfirmationScreen.textFieldDidChange(_:)), for: .editingChanged)
            self.view.addSubview(label)
            inttimelist.append(converttoseconds(hours: i))
            y = y+Int(UIScreen.main.bounds.height/18.64)
            if(y>height-100){
                y = 170
                x+=Int(UIScreen.main.bounds.width/2.15)
                
            }
        }
        if(newlist.count<count){
            for _ in newlist.count...count{
                let label = UITextField(frame: CGRect(x: 0, y: 0, width: 200, height: 24))
                timelist.append(label)
                label.center = CGPoint(x: x, y: y)
                label.textAlignment = .center
                label.text = ""
                label.returnKeyType = .done
                label.font = UIFont(name:"Futura-Medium", size:UIScreen.main.bounds.width/17.91666667)
                label.addTarget(self, action: #selector(ConfirmationScreen.textFieldDidChange(_:)), for: .editingChanged)
                self.view.addSubview(label)
                y = y+Int(UIScreen.main.bounds.height/18.64)
                if(y>height-100){
                    y = 170
                    x+=Int(UIScreen.main.bounds.width/2.15)
                    
                }
            }
        }
    }
    
    func convertlist(list1: [String], list2: [Int]) -> [String]{
        if(list1.isEmpty){
            return []
        }
        var t = [String]()
        var lastelement = list1.first
        t.append(lastelement!)
        
        for i in list1{
            if list2.contains(converttoseconds(hours: i)-converttoseconds(hours: lastelement)){
                t.append(i)
                lastelement = i
            }
            
        }
        return t
    }
    
    func converttoseconds(hours: String?) -> Int!{
        if (hours==nil){
            return 10800;
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
        //maybe check if entered is valid time
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
        let k = Int(string.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
        if(k==nil){
            return 0;
        }
        return k!
    }
}
extension String {
    var isNumeric: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", ":"]
        return Set(self).isSubset(of: nums)
    }
}
