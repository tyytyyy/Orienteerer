//
//  ScanScreen.swift
//  Orienteerer
//
//  Created by Tom Yuan on 12/8/22.
//

import UIKit
import AVFoundation

class ScanScreen: UIViewController {
    
    var session: AVCaptureSession?
    let output = AVCapturePhotoOutput()
    let previewLayer = AVCaptureVideoPreviewLayer()
    @IBOutlet weak var cameraView: UIImageView!
    @IBOutlet weak var scanSign: UILabel!
    @IBOutlet weak var shutterButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .black
        view.layer.addSublayer(previewLayer)
        view.addSubview(shutterButton)
        view.addSubview(scanSign)
        checkCameraPermissions()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer.frame = view.bounds
        
    }
    private func checkCameraPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                guard granted else {
                    return
                }
                DispatchQueue.main.async {
                    self?.setUpCamera()
                }
            }
        case .restricted:
            break
        case .denied:
            break
        case .authorized:
            setUpCamera()
        @unknown default:
            break
        }
    }
    
    private func setUpCamera() {
        let session = AVCaptureSession()
        if let device = AVCaptureDevice.default(for: .video) {
            do {
                let input = try AVCaptureDeviceInput(device: device)
                if session.canAddInput(input){
                    session.addInput(input)
                }
                if session.canAddOutput(output){
                    session.addOutput(output)
                }
                
                previewLayer.videoGravity = .resizeAspectFill
                previewLayer.session = session
                session.startRunning()
                self.session = session
            }
            catch{
                print(error)
            }
        }
    }
    
    @IBAction func takePhoto(_ sender: Any) {
        output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
        let fourthVC = self.storyboard?.instantiateViewController(withIdentifier: "ConfirmationScreen") as! ConfirmationScreen
        self.navigationController?.pushViewController(fourthVC, animated: true)
    }
}

extension ScanScreen: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let data = photo.fileDataRepresentation() else{
            return
        }
        // results are saved in image variable below
        let image = UIImage(data: data)
        session?.stopRunning()
    }
}

