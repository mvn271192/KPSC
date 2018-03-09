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
        var height = 0
        switch self.dailyFeeds.type {
        case .TextData:
            height =  self.createTextData(data: self.dailyFeeds.textData!)
            break;
        case .Question:
            height = self.createQuestion(question: self.dailyFeeds.textData!, answer: self.dailyFeeds.answer!)
            break;
        case .ImageOnly:
           // height = self.createImage(image: self.dailyFeeds.imageURL)
            break;
            
        }
    }
    
    // MARK: - Create Fields
    
    func createTextData(data:String)->(Int)
    {
        let textDataLabel = UILabel()
        textDataLabel.frame = CGRect(x: xValue, y: yValue, width: self.frame.size.width - 2 * xValue , height: self.frame.size.height - 35)
        textDataLabel.font = FontForTextField
        textDataLabel.numberOfLines = 0
        textDataLabel.textAlignment = .left
        textDataLabel.sizeToFit()
        self.addSubview(textDataLabel)
        
        return (Int)(textDataLabel.frame.size.height)
        
    }
    
    func createQuestion(question:String, answer:String)->(Int)
    {
        let height = createTextData(data: question)
        let ansLabel = UILabel()
        ansLabel.frame = CGRect(x: xValue, y: yValue + CGFloat(height), width: self.frame.size.width - 2 * xValue , height: self.frame.size.height - 35)
        ansLabel.font = FontForTextField
        ansLabel.numberOfLines = 0
        ansLabel.textAlignment = .left
        ansLabel.sizeToFit()
        self.addSubview(ansLabel)
        return (Int)(ansLabel.frame.origin.y)
        
    }
    
    func createImage(image: UIImage!)->(Int)
    {
        
        let containerView = UIView(frame: CGRect(x:0,y:0,width:self.frame.size.width,height:self.frame.size.height))
        let imageView = UIImageView()
        
        if let img = image {
            let ratio = img.size.width / img.size.height
            if containerView.frame.width > containerView.frame.height {
                let newHeight = containerView.frame.width / ratio
                imageView.frame.size = CGSize(width: containerView.frame.width, height: newHeight)
            }
            else{
                let newWidth = containerView.frame.height * ratio
                imageView.frame.size = CGSize(width: newWidth, height: containerView.frame.height)
            }
        }
        
        self.addSubview(imageView)
        return (Int)(imageView.frame.size.height)
    }
    
    
    
}
