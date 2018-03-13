//
//  DailyFeedsCollectionViewCell.swift
//  PSC
//
//  Created by Manikandan V Nair on 05/02/18.
//  Copyright © 2018 MVN. All rights reserved.
//

import UIKit
import SDWebImage

class DailyFeedsCollectionViewCell: UICollectionViewCell {
    
    private var dailyFeeds:DailyFeeds!
    let xValue:CGFloat = 10
    let yValue:CGFloat = 5
    let common = Common.common
    let pading:CGFloat = 10
    
    func  setDailyFeeds(dailyFeeds: DailyFeeds)
    {
        self.dailyFeeds = dailyFeeds
        var height = 0
        switch self.dailyFeeds.type {
        case .TextData:
            height =  self.createTextdata(data: self.dailyFeeds.textData!, title: self.dailyFeeds.title!)
            break;
        case .Question:
            height = self.createQuestion(question: self.dailyFeeds.title!, answer: self.dailyFeeds.answer!)
            break;
        case .ImageOnly:
             height = self.createImage(imageURL: self.dailyFeeds.imageURL)
            break;
            
        }
    }
    
    // MARK: - Create Fields
    
    func createTextdata(data: String, title: String)->(Int)
    {
        let height = self.createTitle(data: title);
        let textTitle = UILabel()
        textTitle.frame = CGRect(x: xValue, y:yValue + CGFloat(height) + pading, width: self.frame.size.width - 2 * xValue , height: self.frame.size.height - 35)
        textTitle.font = UIFont(name: Font, size: 14)
        textTitle.numberOfLines = 0
        textTitle.textAlignment = .left
        textTitle.text = data
        textTitle.textColor = UIColor.gray
        textTitle.sizeToFit()
        self.addSubview(textTitle)
        
        return (Int)(textTitle.frame.size.height)
    }
    
    func createTitle(data:String)->(Int)
    {
        let textDataLabel = UILabel()
        textDataLabel.frame = CGRect(x: xValue, y: yValue, width: self.frame.size.width - 2 * xValue , height: self.frame.size.height - 35)
        textDataLabel.font = UIFont(name: Font, size: 17)
        textDataLabel.numberOfLines = 0
        textDataLabel.textAlignment = .left
        textDataLabel.text = data
        textDataLabel.sizeToFit()
        self.addSubview(textDataLabel)
        
        return (Int)(textDataLabel.frame.size.height)
        
    }
    
    func createQuestion(question:String, answer:String)->(Int)
    {
        let height = createTitle(data: question)
        let ansLabel = UILabel()
        ansLabel.frame = CGRect(x: xValue, y: yValue + CGFloat(height) + pading, width: self.frame.size.width - 2 * xValue , height: self.frame.size.height - 35)
        ansLabel.font = UIFont(name: Font, size: 14)
        ansLabel.numberOfLines = 0
        ansLabel.textAlignment = .left
        ansLabel.text = answer
        ansLabel.sizeToFit()
        ansLabel.textColor = UIColor.gray
        self.addSubview(ansLabel)
        return (Int)(ansLabel.frame.origin.y)
        
    }
    
    func createImage(imageURL: String!)->(Int)
    {
        let imageView:UIImageView = UIImageView()
        let activityIndicator = common.setActitvityIndicator(inView: imageView)
        activityIndicator.startAnimating()
        let url = URL(string: imageURL)
        //imageView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "Preview"))
        imageView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "Preview"), options: .progressiveDownload, progress: nil, completed: { (image, error, cache, url) in
            activityIndicator.stopAnimating()
            
            let containerView = UIView(frame: CGRect(x:0,y:0,width:self.frame.size.width,height:self.frame.size.height))
            
            
            if let img = imageView.image {
                let ratio = img.size.width / img.size.height
                if containerView.frame.width > containerView.frame.height {
                    let newHeight = containerView.frame.width / ratio
                    imageView.frame.size = CGSize(width: containerView.frame.width, height: containerView.frame.height)
                }
                else{
                    let newWidth = containerView.frame.height * ratio
                    imageView.frame.size = CGSize(width: newWidth, height: containerView.frame.height)
                }
            }
        })
        
//        let containerView = UIView(frame: CGRect(x:0,y:0,width:self.frame.size.width,height:self.frame.size.height))
//        
//        
//        if let img = imageView.image {
//            let ratio = img.size.width / img.size.height
//            if containerView.frame.width > containerView.frame.height {
//                let newHeight = containerView.frame.width / ratio
//                imageView.frame.size = CGSize(width: containerView.frame.width, height: newHeight)
//            }
//            else{
//                let newWidth = containerView.frame.height * ratio
//                imageView.frame.size = CGSize(width: newWidth, height: containerView.frame.height)
//            }
//        }
        
        self.addSubview(imageView)
        return (Int)(imageView.frame.size.height)
    }
    
    
    
}
