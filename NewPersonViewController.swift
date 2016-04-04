//
//  NewPersonViewController.swift
//  Wilks_v01
//
//  Created by Mehdi Salemi on 2016-04-04.
//  Copyright © 2016 MxMd. All rights reserved.
//

import Foundation
import UIKit

class NewPersonViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let sharedInstance = CoreDataStackManager.sharedInstance().managedObjectContext
    
    var defaultImage = true
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var genderControl: UISegmentedControl!
    @IBOutlet weak var pesonImage: UIImageView!
    
    @IBAction func cameraButton(sender: UIButton) {
        createImagePicker(false)
    }
    
    @IBAction func albumPressed(sender: UIButton) {
        createImagePicker(false)
    }
    
    
    @IBAction func cancelPressed(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func save(sender: UIButton) {
        
        var newPersonDictionary = [String:AnyObject]()
        
        if (defaultImage){
            print("Default Photo")
        } else {
            print("Photo Set!")
        }
        newPersonDictionary["imagePath"] = "XXXX"
        
        switch(genderControl.selectedSegmentIndex){
        case 0:
            print("Male")
            newPersonDictionary["gender"] = "male"
        case 1:
            print("Female")
            newPersonDictionary["gender"] = "female"
        default:
            print("Error")
        }
        
        print(nameTextField.text!)
        newPersonDictionary["name"] = nameTextField.text!
        
        //Save Person
        let newPerson = Person(dictionary: newPersonDictionary, context: sharedInstance)
        CoreDataStackManager.sharedInstance().saveContext()
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func createImagePicker(fromCamera : Bool){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        if fromCamera {
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        } else {
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        }
        imagePicker.allowsEditing = false
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        let selectedImage : UIImage = image
        self.pesonImage.image = selectedImage
        self.defaultImage = false
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
