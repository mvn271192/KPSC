//
//  MyProfileViewController.swift
//  PSC
//
//  Created by Manikandan V Nair on 21/03/18.
//  Copyright © 2018 MVN. All rights reserved.
//

import UIKit

class MyProfileViewController: UIViewController {

    @IBOutlet weak var mEmailLabel: UILabel!
    @IBOutlet weak var mNameLabel: UILabel!
    @IBOutlet weak var mProfilePicImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mProfilePicImageView.layer.borderWidth = 1.0
        mProfilePicImageView.layer.masksToBounds = false
        mProfilePicImageView.layer.borderColor = UIColor.white.cgColor
        mProfilePicImageView.layer.cornerRadius = mProfilePicImageView.frame.size.width / 2
        mProfilePicImageView.clipsToBounds = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editButtonClick(_ sender: Any) {
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
