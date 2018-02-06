//
//  DailyFeedsCollectionViewCell.swift
//  PSC
//
//  Created by Manikandan V Nair on 05/02/18.
//  Copyright © 2018 MVN. All rights reserved.
//

import UIKit

class DailyFeedsCollectionViewCell: UICollectionViewCell {
    
    private var dailyFeeds:DailyFeeds!
    let xValue:CGFloat = 5
    let yValue:CGFloat = 5
    
  func  setDailyFeeds(dailyFeeds: DailyFeeds)
  {
    self.dailyFeeds = dailyFeeds
    
    switch self.dailyFeeds.type {
    case .TextData:
        
        break;
    case .Question:
        
        break;
    case .ImageOnly:
        
        break;
    default:
        break
    }
    }
    
    // MARK: - Create Fields
    
    func createTextData(data:String)
    {
        let textDataLabel = UILabel()
        textDataLabel.frame = CGRect(x: xValue, y: yValue, width: self.frame.size.width - 2 * xValue , height: self.frame.size.height - 35)
        
    }
    
}
