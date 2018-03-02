//
//  DetailsViewController.swift
//  PSC
//
//  Created by Manikandan V Nair on 27/02/18.
//  Copyright © 2018 MVN. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    @IBOutlet weak var conetentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    var selectedNotification:Notification!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        titleLabel.text = selectedNotification.titile
        contentLabel.text = selectedNotification.content
        
        if let url = selectedNotification.link
        {
            urlLabel.text = url
        }
        if let imageUrl = selectedNotification.imageUrl
        {
            imageView.image = UIImage.init(data: Data.init(contentsOf: URL.init(string: imageUrl)!))
        }
    }

    @IBOutlet weak var shareButtonClick: UIButton!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
