//
//  DetailViewController.swift
//  PhotoOpApp
//
//  Created by cmacgregor on 4/11/17.
//  Copyright © 2017 cmacgregor. All rights reserved.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    let realm = try! Realm()
    
    @IBOutlet weak var tagLabel: UILabel!
    
    @IBOutlet weak var cityLabel: UILabel!
    
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
        self.title = detailItem?.name
        if(detailItem?.image == Data())
        {
            changePhotoAlert(message: "No Photo")
        }
        imageView.image = UIImage(data: (detailItem?.image)!)
        if(detailItem?.city == String())
        {
            //alert asking if you wanna add a city
        }
        cityLabel.text = detailItem?.city
        if(detailItem?.tag == String())
        {
            //alert to ask if you wanna add a tag
        }
        tagLabel.text = detailItem?.tag
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

    func changePhotoAlert(message : String)
    {
        let alert = UIAlertController(title: message, message: "", preferredStyle: .alert)
        let cameraAction = UIAlertAction(title: "Take a Photo Now.", style: .default)
        {
            (action) in
            if(UIImagePickerController.isSourceTypeAvailable(.camera))
            {
                self.imagePicker.sourceType = UIImagePickerControllerSourceType.camera
                self.present(self.imagePicker, animated: true, completion: nil)
            }
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
            try! self.realm.write
            {
                self.detailItem?.image = UIImagePNGRepresentation(selectedImage)!
            }
            self.imageView.image = selectedImage
        }
    }
    
    @IBAction func onEditTapped(_ sender: Any)
    {
        let alert = UIAlertController()
        let name = UIAlertAction(title: "Edit Name", style: .default)
        {
            (action) in
            self.editNameAlert()
        }
        let photo = UIAlertAction(title: "Change Photo", style: .default)
        {
            (action) in
            self.changePhotoAlert(message: "Change Photo")
        }
        let tag = UIAlertAction(title: "Edit Tag", style: .default)
        {
            (action) in
            self.changeTagAlert()
            
        }
        let city = UIAlertAction(title: "Change City", style: .default)
        {
            (action) in
            self.editCityAlert()
            
        }
        let location = UIAlertAction(title: "Change Location", style: .default)
        {
            (action) in
            
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(name)
        alert.addAction(photo)
        alert.addAction(city)
        alert.addAction(tag)
        alert.addAction(location)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    func editNameAlert()
    {
        let alert = UIAlertController(title: "Edit Name", message: nil, preferredStyle: .alert)
        alert.addTextField
        {
            (textField) in
            textField.text = self.detailItem?.name
        }
        let apply = UIAlertAction(title: "Apply", style: .default)
        {
            (action) in
            try! self.realm.write
            {
                self.detailItem?.name = (alert.textFields?[0].text!)!
            }
            self.title = self.detailItem?.name

        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(apply)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    func editCityAlert()
    {
        let alert = UIAlertController(title: "Edit City", message: nil, preferredStyle: .alert)
        alert.addTextField
        {
            (textField) in
            textField.text = self.detailItem?.city
        }
        let apply = UIAlertAction(title: "Apply", style: .default)
        {
            (action) in
            try! self.realm.write
            {
                self.detailItem?.city = (alert.textFields?[0].text!)!
            }
            self.cityLabel.text = self.detailItem?.city
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(apply)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    func changeTagAlert()
    {
        let alert = UIAlertController(title: "Edit Tag", message: nil, preferredStyle: .alert)
        alert.addTextField
            {
                (textField) in
                textField.text = self.detailItem?.tag
        }
        let apply = UIAlertAction(title: "Apply", style: .default)
        {
            (action) in
            try! self.realm.write
            {
                self.detailItem?.tag = (alert.textFields?[0].text!)!
            }
            self.tagLabel.text = self.detailItem?.tag
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(apply)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
}

