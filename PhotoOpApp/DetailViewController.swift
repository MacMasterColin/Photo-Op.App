//
//  DetailViewController.swift
//  PhotoOpApp
//
//  Created by cmacgregor on 4/11/17.
//  Copyright © 2017 cmacgregor. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    let imagePicker = UIImagePickerController()


    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.name
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        imagePicker.delegate = self
        if(detailItem?.image == nil)
        {
            changePhotoAlert()
        }
        imageView.image = detailItem?.image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: Location? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func changePhotoAlert()
    {
        let alert = UIAlertController(title: "Add Photo", message: "", preferredStyle: .alert)
        let cameraAction = UIAlertAction(title: "Take a Photo Now.", style: .default)
        {
            (action) in
            
        }
        let libraryAction = UIAlertAction(title: "Choose from Photo Library.", style: .default)
        {
            (action) in
            self.imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Not Now.", style: .cancel, handler: nil)
        alert.addAction(cameraAction)
        alert.addAction(libraryAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePicker.dismiss(animated: true)
        {
            let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            self.detailItem!.image = selectedImage
            self.imageView.image = selectedImage
        }
    }
    
}

