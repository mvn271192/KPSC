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
    
    @IBOutlet weak var mTitleLabel: UILabel!
    @IBOutlet weak var mContentLabel: UILabel!
    
    let textData = UILabel()
    let textTitle = UILabel()
    let imageView:UIImageView = UIImageView()
    let ansLabel = UILabel()
    
    private var dailyFeeds:DailyFeeds!
    let xValue:CGFloat = 10
    let yValue:CGFloat = 5
    let common = Common.common
    let pading:CGFloat = 10
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    func  setDailyFeeds(dailyFeeds: DailyFeeds)
    {
        
        self.dailyFeeds = dailyFeeds
        
//        self.ansLabel.isHidden = true
//        self.textData.isHidden = true
//        self.imageView.isHidden = true
//        self.textTitle.isHidden = true
        mContentLabel.isHidden = false
        mTitleLabel.isHidden = false
        
        
        switch self.dailyFeeds.type {
        case .TextData:
             self.createTextdata(data: self.dailyFeeds.textData!, title: self.dailyFeeds.title!)
            break;
        case .Question:
             self.createQuestion(question: self.dailyFeeds.title!, answer: self.dailyFeeds.answer!)
            break;
        case .ImageOnly:
             self.createImage(imageURL: self.dailyFeeds.imageURL)
            break;
            
        }
    }
    
    // MARK: - Create Fields
    
    func createTextdata(data: String, title: String)
    {
        self.mTitleLabel.text = title
        self.mContentLabel.text = data
//        self.textData.isHidden = false
//
//
//        let height = self.createTitle(data: title);
//        textData.frame = CGRect(x: xValue, y:yValue + CGFloat(height) + pading, width: self.frame.size.width - 2 * xValue , height: self.frame.size.height - 35)
//        textData.font = UIFont(name: Font, size: 14)
//        textData.numberOfLines = 0
//        textData.textAlignment = .left
//        textData.text = data
//        textData.textColor = UIColor.gray
//        textData.sizeToFit()
//        self.addSubview(textData)
        
       
    }
    
//    func createTitle(data:String)->(Int)
//    {
//        self.textTitle.isHidden = false
//
//        textTitle.frame = CGRect(x: xValue, y: yValue, width: self.frame.size.width - 2 * xValue , height: self.frame.size.height - 35)
//        textTitle.font = UIFont(name: Font, size: 17)
//        textTitle.numberOfLines = 0
//        textTitle.textAlignment = .left
//        textTitle.text = data
//        textTitle.sizeToFit()
//        self.addSubview(textTitle)
//        return (Int(textTitle.frame.height))
       
        
 //  }
    
    func createQuestion(question:String, answer:String)
    {
        self.mTitleLabel.text = question
        self.mContentLabel.text = answer
//        self.ansLabel.isHidden = false
//        let height = createTitle(data: question)
//
//        ansLabel.frame = CGRect(x: xValue, y: yValue + CGFloat(height) + pading, width: self.frame.size.width - 2 * xValue , height: self.frame.size.height - 35)
//        ansLabel.font = UIFont(name: Font, size: 14)
//        ansLabel.numberOfLines = 0
//        ansLabel.textAlignment = .left
//        ansLabel.text = answer
//        ansLabel.sizeToFit()
//        ansLabel.textColor = UIColor.gray
//        self.addSubview(ansLabel)
       
        
    }
    
    func createImage(imageURL: String!)
    {
        mContentLabel.isHidden = true
        mTitleLabel.isHidden = true
//        self.imageView.isHidden = false
//       // imageView.frame = self.frame
//        let activityIndicator = common.setActitvityIndicator(inView: imageView)
//        activityIndicator.startAnimating()
//        let url = URL(string: imageURL)
//        //imageView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "Preview"))
//        imageView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "Preview"), options: .progressiveDownload, progress: nil, completed: { [unowned self] (image, error, cache, url) in
//            activityIndicator.stopAnimating()
//
//            let containerView = UIView(frame: CGRect(x:0,y:0,width:self.frame.size.width,height:self.frame.size.height))
//
//
//            if let img = self.imageView.image {
//                let ratio = img.size.width / img.size.height
//                if containerView.frame.width > containerView.frame.height {
//                    let newHeight = containerView.frame.width / ratio
//                    self.imageView.frame.size = CGSize(width: containerView.frame.width, height: containerView.frame.height)
//                }
//                else{
//                    let newWidth = containerView.frame.height * ratio
//                    self.imageView.frame.size = CGSize(width: newWidth, height: containerView.frame.height)
//                }
//            }
//        })
//
//
//
//        self.addSubview(imageView)
       
    }
    
    @IBAction func saveButtonclick(_ sender: Any) {
    }
    @IBAction func shareButtonClick(_ sender: Any)
    {
            switch self.dailyFeeds.type
            {
                
            case .TextData:
                common.showShareActivity(msg: self.textTitle.text! + "\r\n" + self.textData.text!, image: nil, url: nil, sourceRect: nil)
                break
            case .ImageOnly:
                common.showShareActivity(msg: nil, image: self.imageView.image, url: nil, sourceRect: nil)
                break
            case .Question:
                common.showShareActivity(msg: self.textTitle.text! + "\r\n" + self.ansLabel.text!, image: nil, url: nil, sourceRect: nil)
                break
            }
        
    }
    
    
}
