//
//  ViewController.swift
//  TextExtract
//
//  Created by Jack on 6/4/19.
//  Copyright © 2019 Jack. All rights reserved.
//

import UIKit
import CoreData
import FirebaseMLVision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var titles: String?
    var text: String?
    
    @IBOutlet weak var textView: UITextView!
    let imagePicked = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicked.delegate = self
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("")
        }
        
        let vision = Vision.vision()
        let textRecognizer = vision.onDeviceTextRecognizer()

        let image = VisionImage(image: userPickedImage)

        textRecognizer.process(image) { (result, error) in
            guard error == nil, let result = result else {
                return
            }
            self.textView.text = result.text

        }
    }
    
    @IBAction func cameraButtonPressed(_ sender: UIBarButtonItem) {
        imagePicked.sourceType = .camera
        present(imagePicked, animated: true, completion: nil)
    }
    
    @IBAction func fileButtonPressed(_ sender: UIBarButtonItem) {
        imagePicked.sourceType = .photoLibrary
        present(imagePicked, animated: true, completion: nil)
    }
}

