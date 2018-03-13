//
//  DailyFeeds.swift
//  PSC
//
//  Created by Manikandan V Nair on 05/02/18.
//  Copyright © 2018 MVN. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class DailyFeeds {

    var type:DailyFeedsTypes = .TextData
    var textData:String?
    var title:String?
    var imageURL:String?
    var answer:String?
    var date:Int!
    
    init(snapshot snap:DataSnapshot!) {
        
        if let data = snap
        {
            
            let dailyFeedsData = data.value as! Dictionary<String,AnyObject>
            guard let date = dailyFeedsData["date"] else { return }
            self.date = date as! Int
            if let type = dailyFeedsData["type"]
            {
                self.type = DailyFeedsTypes(rawValue: type as! Int)!
            }
            switch(self.type)
            {
            case .TextData:
                if let title = dailyFeedsData["title"], let textdata = dailyFeedsData["textData"]
                {
                    self.title = (title as! String)
                    self.textData = (textdata as! String)
                }
               
                break
           
            case .ImageOnly:
                if let imageUrl = dailyFeedsData["imageURL"], imageUrl.length > 1
                {
                    self.imageURL = (imageUrl as! String)
                }
                break
            case .Question:
                
                if let title = dailyFeedsData["title"], let ans = dailyFeedsData["answer"]
                {
                    self.title = (title as! String)
                    self.answer = (ans as! String)
                }
                break
            
            }
//            let notifications = notificationData.values
//            if (notifications.count > 0)
//            {
//                for item in notifications
//                {
//
//                    let notification = Notification(dataDictionary: item as! NSMutableDictionary)
//                    self.notifications.append(notification)
//
//                }
//                self.notifications.sort(by: {$0.dateStamp > $1.dateStamp})
//            }
            
        }
    }
    
    
}
