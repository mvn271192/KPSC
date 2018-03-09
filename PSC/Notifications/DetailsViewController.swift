//
//  DetailsViewController.swift
//  PSC
//
//  Created by Manikandan V Nair on 27/02/18.
//  Copyright © 2018 MVN. All rights reserved.
//

import UIKit
import SDWebImage


class DetailsViewController: UIViewController {
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    @IBOutlet weak var dataContenntView: UIView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var titileLabel: UILabel!
    var selectedNotification:Notification!
    var totalFrameHeight:CGFloat = 0.0
    
    let common = Common.common
    
    // MARK: - View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.setValues()
        urlLabel.isUserInteractionEnabled = true
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        mainScrollView.contentSize = CGSize(width: contentView.frame.width, height: totalFrameHeight)
        
    }
    
    @IBOutlet weak var shareButtonClick: UIButton!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    @IBAction func urlTap(_ sender: Any) {
        
        if let url = urlLabel.text, let ur = URL(string: url) ,UIApplication.shared.canOpenURL(ur) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(ur)
            } else {
                // Fallback on earlier versions
            }
        }
        
    }
    
    @IBAction func shareButtoncCick(_ sender: Any) {
        
        // text to share
        
        let content = titileLabel.text! + "\r\n" + contentLabel.text!
        let image = imageView.image
        let url = urlLabel.text
        
        common.showShareActivity(msg: content, image: image, url: url, sourceRect: nil)
        // set up activity view controller
        //        let textToShare = [ titile, content ]
        //        if (textToShare.count > 0)
        //        {
        //            let activityViewController = UIActivityViewController(activityItems: [textToShare as Any], applicationActivities: nil)
        //        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        //
        //        // exclude some activity types from the list (optional)
        //        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook, UIActivityType.postToTwitter ]
        //
        //        // present the view controller
        //        self.present(activityViewController, animated: true, completion: nil)
        //        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func setValues()
    {
        titileLabel.text = selectedNotification.titile
        contentLabel.text = selectedNotification.content
        
        if let url = selectedNotification.link
        {
            urlLabel.text = url
        }
        if let imageUrl = selectedNotification.imageUrl, imageUrl.count > 1
        {
            
            let activityIndicator = common.setActitvityIndicator(inView: self.imageView)
            activityIndicator.startAnimating()
            let url = URL(string: imageUrl)
            //imageView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "Preview"))
            imageView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "Preview"), options: .progressiveDownload, progress: nil, completed: { (image, error, cache, url) in
                activityIndicator.stopAnimating()
            })
            
//            if let imageDownloadUrl = URL(string: imageUrl)
//            {
//                do {
//                    let imageData = try Data.init(contentsOf: imageDownloadUrl)
//
//                    imageView.image = UIImage(data: imageData)
//
//                }
//                catch
//                {
//                    print(error)
//                }
//            }
            
            //            imageView.image = UIImage.init(data: Data.init(contentsOf: URL.init(string: imageUrl)!))
        }
        titileLabel.sizeToFit()
        contentLabel.sizeToFit()
        urlLabel.sizeToFit()
        
        let pading:CGFloat = 80.0
        let dataViewFrame = dataContenntView.frame;
        let dataViewheight = titileLabel.frame.height + contentLabel.frame.height + urlLabel.frame.height + shareButton.frame.height + pading
        dataContenntView.frame = CGRect(x: dataViewFrame.origin.x, y: dataViewFrame.origin.y, width: dataViewFrame.width, height: dataViewheight)
        totalFrameHeight = dataViewheight +  imageView.frame.height + 20
        let contentViewFrame = contentView.frame
        contentView.frame = CGRect (x: contentViewFrame.origin.x, y: contentViewFrame.origin.y, width: contentViewFrame.width, height: totalFrameHeight)
    }
    
}
