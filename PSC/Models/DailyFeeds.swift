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
    var size:ContentLength = .Default
    
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
                    guard let txtCount = self.textData?.count else {return}
                    guard let titleCount = self.title?.count else {return}
                    if ((txtCount + titleCount) > 700)
                    {
                        self.size = .Extra_large
                    }
                    else if ((txtCount + titleCount) > 500)
                    {
                        self.size = .Large
                    }
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
                    guard let ansCount = self.answer?.count else {return}
                    guard let titleCount = self.title?.count else {return}
                    if ((ansCount + titleCount) > 500)
                    {
                        self.size = .Extra_large
                    }
                    else if ((ansCount + titleCount) > 300)
                    {
                        self.size = .Large
                    }
                }
                break
            
            }

            
        }
    }
    
    
}
