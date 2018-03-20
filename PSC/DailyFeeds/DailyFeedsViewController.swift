//
//  DailyFeedsViewController.swift
//  PSC
//
//  Created by Manikandan V Nair on 05/02/18.
//  Copyright © 2018 MVN. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class DailyFeedsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching, UICollectionViewDelegateFlowLayout  {
    
    @IBOutlet weak var mCollectionView: UICollectionView!
    var mDailyFeeds:[DailyFeeds] = []
    fileprivate let reuseIdentifier = "collectionViewCell"
    fileprivate let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    fileprivate let itemsPerRow: CGFloat = 1
    private lazy var databaseRef: DatabaseReference = Database.database().reference()
    
    var refreshControl:UIRefreshControl!
    
    let common = Common.common
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let dailyFeeds = Database.database().reference(withPath: DAILY_FEEDS)
        dailyFeeds.keepSynced(true)
        self.getData();
        self.setRefreshControll()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Refresh controlls
    
    func setRefreshControll()
    {
        
        refreshControl = UIRefreshControl()
        //refreshControl.backgroundColor = UIColor.white
        //refreshControl.tintColor = UIColor.green
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing data...")
        refreshControl.addTarget(self, action: #selector(self.refresh(sender:)), for: UIControlEvents.valueChanged)
        mCollectionView.addSubview(refreshControl)
    }
    
    @objc func refresh(sender:AnyObject)
    {
       
        self.getLatestData()
        
    }
    
    // MARK: - Collection View Data Source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return mDailyFeeds.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DailyFeedsCollectionViewCell
        
        cell.setDailyFeeds(dailyFeeds: mDailyFeeds[indexPath.row])
        cell.tag = indexPath.row
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        var height:CGFloat = 250
        switch mDailyFeeds[indexPath.row].size {
        case .Default:
            height = 250
            break;
        case .Large:
            height = 300
            break;
        case .Extra_large:
            height = 350
            break
            
        }
        
        return CGSize(width: widthPerItem, height: height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        
    }
    
    
    
    // MARK: - FireBase Methods
    
    func getData()
    {
        let nsActivity = common.setActitvityIndicator(inView: self.view)
        DispatchQueue.main.async {
            nsActivity.startAnimating()
        }
        common.fireBaseMethods.getValuesFromFireBase(root:DAILY_FEEDS , limit: 50, orderBy: "date") { [unowned self] (success, snapshot) in
            
            if snapshot.childrenCount > 0
            {
                for item in snapshot.children
                {
                    let snap = item as! DataSnapshot
                    let order = DailyFeeds(snapshot: snap)
                    self.mDailyFeeds.insert(order, at: 0)
                }
                self.mDailyFeeds.sort(by: {$0.date > $1.date})
                DispatchQueue.main.async {
                    nsActivity.stopAnimating()
                    self.mCollectionView.reloadData()
                }
                
            }
        }
    }
    
    func getLatestData()
    {
        
        let latestTimeStamp = mDailyFeeds.first?.date
        common.fireBaseMethods.getLatestValuesFromFireBase(root:DAILY_FEEDS , startValue: latestTimeStamp! + 1, orderBy: "date") { [unowned self] (success, snapshot) in
            
           
            if snapshot.childrenCount > 0
            {
                for item in snapshot.children
                {
                    let snap = item as! DataSnapshot
                    let order = DailyFeeds(snapshot: snap)
                    if !(self.mDailyFeeds.contains(where: { $0.date == order.date}))
                    {
                        
                        DispatchQueue.main.async
                            {
                                self.mDailyFeeds.insert(order, at: 0)
                                self.mCollectionView.performBatchUpdates({ [weak self] () -> Void in
                                    (self?.mCollectionView.insertItems(at: [NSIndexPath(row: 0, section: 0) as IndexPath]))
                                    
                                    }, completion:nil)
                        }
                        
                    }
                    
                    
                }
                
                
                
            }
            self.refreshControl.endRefreshing()
        }
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
