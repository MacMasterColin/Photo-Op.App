//
//  DetailViewController.swift
//  PhotoOpApp
//
//  Created by cmacgregor on 4/11/17.
//  Copyright © 2017 cmacgregor. All rights reserved.
//

import UIKit
import RealmSwift
import CoreLocation

class DetailViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    let realm = try! Realm()
    
    @IBOutlet weak var tagLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var cityLabel: UILabel!
    
    let locationManager = CLLocationManager()
    
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
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        imagePicker.delegate = self
        self.title = detailItem?.name
        if(detailItem?.image == Data())
        {
            changePhotoAlert(message: "No Photo")
        }
        imageView.image = UIImage(data: (detailItem?.image)!)
        if(detailItem?.city == "")
        {
            let alert = UIAlertController(title: "No City Entered. Would you like to add one?", message: nil, preferredStyle: .alert)
            let yes = UIAlertAction(title: "Yes", style: .default)
            {
                (action) in
                self.editCityAlert()
            }
            let cancel = UIAlertAction(title: "No", style: .cancel, handler: nil)
            alert.addAction(yes)
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
        }
        cityLabel.text = detailItem?.city
        if(detailItem?.tag == String())
        {
            let alert = UIAlertController(title: "No Tag Entered. Would you like to add one?", message: nil, preferredStyle: .alert)
            let yes = UIAlertAction(title: "Yes", style: .default)
            {
                (action) in
                self.changeTagAlert()
            }
            let cancel = UIAlertAction(title: "No", style: .cancel, handler: nil)
            alert.addAction(yes)
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
        }
        tagLabel.text = detailItem?.tag
        if(detailItem?.longitude == Double())
        {
            let alert = UIAlertController(title: "No Location Set. Would you like to add one?", message: nil, preferredStyle: .alert)
            let yes = UIAlertAction(title: "Yes", style: .default)
            {
                (action) in
                self.changeLocationAlert()
            }
            let cancel = UIAlertAction(title: "No", style: .cancel, handler: nil)
            alert.addAction(yes)
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
        }
        else
        {
            let lat = Double(round(100 * (self.detailItem?.latitude)!) / 100)
            let lon = Double(round(100 * (self.detailItem?.longitude)!) / 100)
            self.locationLabel.text = "Longitude : \(lon) \n Latitude : \(lat)"
        }
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
                self.detailItem?.image = UIImageJPEGRepresentation(selectedImage, 1)!
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
            self.changeLocationAlert()
            
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
    
    func changeLocationAlert()
    {
        let alert = UIAlertController(title: "Would you Like to Set Your Current Location?", message: nil, preferredStyle: .alert)
        let apply = UIAlertAction(title: "Yes Please", style: .default)
        {
            (action) in
            try! self.realm.write
            {
                self.detailItem?.longitude = (self.locationManager.location!.coordinate.longitude)
                self.detailItem?.latitude = (self.locationManager.location!.coordinate.latitude)
            }
            let lat = Double(round(100 * (self.detailItem?.latitude)!) / 100)
            let lon = Double(round(100 * (self.detailItem?.longitude)!) / 100)
            self.locationLabel.text = "Longitude : \(lon) \n Latitude : \(lat)"
        }
        let cancel = UIAlertAction(title: "No Thanks", style: .cancel, handler: nil)
        alert.addAction(apply)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let dvc = segue.destination as! CoreLocationViewController
        dvc.location = self.detailItem
    }
}


