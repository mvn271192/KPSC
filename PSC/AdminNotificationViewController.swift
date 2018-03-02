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

class AdminNotificationViewController: UIViewController {

    private lazy var databaseRef: DatabaseReference = Database.database().reference()
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveButtonClick(_ sender: Any) {
        
        let contentTitile = self.view.viewWithTag(1) as! UITextView
        let contentText = self.view.viewWithTag(2) as! UITextView
        let url = self.view.viewWithTag(3) as! UITextView
        let imageUrl = self.view.viewWithTag(4) as! UITextView
        
        if contentTitile.text != "" && contentText.text != ""
        {
            self.insertIntoFireBase(content: contentText.text, titile: contentTitile.text, url: url.text, imageUrl: imageUrl.text)
        }
        else
        {
            self.view.makeToast("enter details")
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
        handle.setValue(notificationItem) { (error, dbref) in
            
            self.saveButton.isEnabled = true
            if error == nil
            {
                self.view.makeToast("Notification inserted")
            }
            else
            {
                self.view.makeToast("insertion failed")
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
