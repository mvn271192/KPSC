//
//  Notification.swift
//  PSC
//
//  Created by Manikandan V Nair on 19/02/18.
//  Copyright © 2018 MVN. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class Notification {
    
    var titile: String!
    var content: String!
    var link: String?
    var imageUrl: String?
    var dateStamp: Int!
   

    init(dataDictionary: NSMutableDictionary) {
        
        
        self.titile = dataDictionary.value(forKey: "title") as! String
        self.content = dataDictionary.value(forKey: "content") as! String
        self.dateStamp = dataDictionary.value(forKey: "date") as! Int
        if let url = dataDictionary.value(forKey: "url") as? String
        {
            self.link = url
        }
        
        if let imageUrl = dataDictionary.value(forKey: "imageURL") as? String
        {
            self.imageUrl = imageUrl
        }
    }
    
}

struct OrderBydate
{
    var date: String!
    var notifications: [Notification] = []
    
    init(date: String, notification: [Notification]) {
        self.date = date
        self.notifications = notification
    }
    
    init(snapshot snap:DataSnapshot!)
    {
        if let data = snap
        {
            self.date = data.key
            let notificationData = data.value as! Dictionary<String,AnyObject>
            let notifications = notificationData.values
            if (notifications.count > 0)
            {
                for item in notifications
                {
                    
                    let notification = Notification(dataDictionary: item as! NSMutableDictionary)
                    self.notifications.append(notification)
                    
                }
                self.notifications.sort(by: {$0.dateStamp > $1.dateStamp})
            }
         
        }
    }
}
