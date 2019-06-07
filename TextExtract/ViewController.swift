//
//  ViewController.swift
//  TextExtract
//
//  Created by Jack on 6/4/19.
//  Copyright © 2019 Jack. All rights reserved.
//

import UIKit
import FirebaseMLVision

class ViewController: UIViewController, UIImagePickerControllerDelegate {
    var titles: String?
    var text: String?
    
    let cameraImage = UIImagePickerController()
    let imagePicked = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("")
        }
        
        
    }
    
    @IBAction func cameraButtonPressed(_ sender: UIBarButtonItem) {
        present(cameraImage, animated: true, completion: nil)
    }
    
    @IBAction func fileButtonPressed(_ sender: UIBarButtonItem) {
        present(imagePicked, animated: true, completion: nil)
    }
}

