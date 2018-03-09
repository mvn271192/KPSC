//
//  AdminNotificationViewController.swift
//  PSC
//
//  Created by Manikandan V Nair on 21/02/18.
//  Copyright © 2018 MVN. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import Toast_Swift
import FirebaseStorage
import MobileCoreServices

class AdminNotificationViewController: UIViewController , UINavigationControllerDelegate, UIImagePickerControllerDelegate  {

    @IBOutlet weak var progressView: UIProgressView!
    private lazy var databaseRef: DatabaseReference = Database.database().reference()
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    var imageUrl:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func selectImageButtonClick(_ sender: Any) {
        self.saveButton.isEnabled = false
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.mediaTypes = [kUTTypeImage as String ]
        self.present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func saveButtonClick(_ sender: Any) {
        
        let contentTitile = self.view.viewWithTag(1) as! UITextView
        let contentText = self.view.viewWithTag(2) as! UITextView
        let url = self.view.viewWithTag(3) as! UITextView
        //let imageUrl = self.view.viewWithTag(4) as! UITextView
        
        if contentTitile.text != "" && contentText.text != ""
        {
            self.insertIntoFireBase(content: contentText.text, titile: contentTitile.text, url: url.text, imageUrl: self.imageUrl)
        }
        else
        {
            self.view.makeToast("enter details")
            
        }
    }
    
    // MARK: - Picker Delegates
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    
        dismiss(animated: true, completion: nil)
        guard info[UIImagePickerControllerMediaType] != nil  else {
            
            dismiss(animated: true, completion: nil)
            return
        }
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        if  let imageData = UIImageJPEGRepresentation(image, 0.5)
        {
            uploadFileWithData(data: imageData)
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Firebase Methods
    
    func uploadFileWithData(data: Data)
    {
        // Create a root reference
        let storageRef = Storage.storage().reference(withPath: NOTIFICATION_PHOTOS)
        
        // Create a reference to "mountains.jpg"
        let imageName = String(Date().timeStamp())
        let mountainsRef = storageRef.child(imageName)
        
        //meta data
        
        let imageMeataData = StorageMetadata()
        imageMeataData.contentType = "image/jpeg"
        
        let uploadTask = mountainsRef.putData(data, metadata: imageMeataData) { [weak self] (storageMetadata, error) in
            guard let strongSelf = self else
            {
                return
            }
            if error != nil
            {
                print(error?.localizedDescription ?? "error")
            }
            else
            {
                print(storageMetadata?.downloadURL() as Any)
                strongSelf.imageUrl = (storageMetadata?.downloadURL()?.absoluteString)!
                strongSelf.view.makeToast("Image upload successfull")
            }
            strongSelf.saveButton.isEnabled = true
        }
        
        uploadTask.observe(.progress) {[weak self]  (snapshot) in
            
            guard let strongSelf = self else
            {
                return
            }
            guard let progress = snapshot.progress else {return }
            strongSelf.progressView.progress = Float(progress.fractionCompleted)
        }
        
        
    }
    
    func insertIntoFireBase(content: String, titile: String, url: String, imageUrl: String)
    {
        
        saveButton.isEnabled = false
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd"
        let formattedDate = dateFormatter.string(from: date )
        
        let questionRef = databaseRef.child(NOTIFICATION).child(formattedDate)
        
        let notificationItem = [
            "title":titile,
            "content":content,
            "url":url,
            "imageUrl":imageUrl,
            "date": [".sv": "timestamp"],
            ] as [String : Any]
        
        let handle = questionRef.childByAutoId()
        handle.setValue(notificationItem) {[weak self] (error, dbref) in
            guard let strongSlef = self else { return }
            strongSlef.saveButton.isEnabled = true
            if error == nil
            {
                strongSlef.view.makeToast("Notification inserted")
                strongSlef.imageUrl = ""
            }
            else
            {
                strongSlef.view.makeToast("insertion failed")
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
