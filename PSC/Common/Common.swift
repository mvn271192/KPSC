//
//  Common.swift
//  PSC
//
//  Created by Manikandan V Nair on 30/01/18.
//  Copyright © 2018 MVN. All rights reserved.
//

import Foundation
import NVActivityIndicatorView
import Toast_Swift
import UIKit
//import DynamicBlurView
import Firebase
import FirebaseDatabase

let GROUP = "Groups"
let USERS = "Users"
let CATEGORY = "Category"
let QUESTIONS = "Questions"
let NOTIFICATION = "Notifications"
let DAILY_FEEDS = "DailyFeeds"

let NOTIFICATION_PHOTOS = "NotificationPhotos"

let NameTag = 1, EmailTag = 2, PhotoTag = 3

let Font = "Kefa"
let FontSize = 16
let FontForTextField = UIFont (name: Font, size: CGFloat(FontSize))
let GreenColorTheme = UIColor(red: 0.01, green: 0.41, blue: 0.22, alpha: 1.0)
let AppTitile = "PSC"

enum DailyFeedsTypes {
    case TextData, ImageOnly, Question
}

final class Common {
    
    private init() { }
    
    //MARK: Shared Instance
    
    static let common: Common = Common()
    
    var user:mUser!
    var fireBaseMethods: FirebaseOperations = FirebaseOperations()
    
    
    
    func setActitvityIndicator(inView view:UIView)->NVActivityIndicatorView
    {
        let nvactivity = NVActivityIndicatorView(frame: CGRect(x: 0
            , y: 0, width: 50, height: 50), type: NVActivityIndicatorType.ballScaleMultiple, color: GreenColorTheme, padding: 0)
        view.addSubview(nvactivity)
        view.bringSubview(toFront: nvactivity)
        nvactivity.center = view.center
        
        return nvactivity
    }
    
    func dropShadow(color: UIColor, view: UIView, radius: CGFloat = 1, scale: Bool = true) {
        
        view.layer.masksToBounds = false
        view.layer.shadowColor = color.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: -1, height: 1)
        view.layer.shadowRadius = radius
        
        view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
        view.layer.shouldRasterize = true
        view.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
//    func getBlurEffectView(view: UIView)->DynamicBlurView
//    {
//
//
//        let blurView = DynamicBlurView(frame: view.bounds)
//        blurView.blurRadius = 10
//
//        return blurView
//}
    func topViewController()-> UIViewController{
        var topViewController:UIViewController = UIApplication.shared.keyWindow!.rootViewController!
        
        while ((topViewController.presentedViewController) != nil) {
            topViewController = topViewController.presentedViewController!;
        }
        
        return topViewController
    }
    
    func showShareActivity(msg:String?, image:UIImage?, url:String?, sourceRect:CGRect?){
        var objectsToShare = [AnyObject]()
        
        if let url = url {
            objectsToShare = [url as AnyObject]
        }
        
        if let image = image {
            objectsToShare = [image as AnyObject]
        }
        
        if let msg = msg {
            objectsToShare = [msg as AnyObject]
        }
        
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.modalPresentationStyle = .popover
        activityVC.popoverPresentationController?.sourceView = topViewController().view
        if let sourceRect = sourceRect {
            activityVC.popoverPresentationController?.sourceRect = sourceRect
        }
        
        topViewController().present(activityVC, animated: true, completion: nil)
    }
}

extension Date {
    func timeStamp() -> Int64! {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
