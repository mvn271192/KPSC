//
//  NotificationViewController.swift
//  PSC
//
//  Created by Manikandan V Nair on 19/02/18.
//  Copyright © 2018 MVN. All rights reserved.
//

import UIKit
import FirebaseDatabase

class NotificationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITableViewDataSourcePrefetching {
  
    @IBOutlet weak var cellTitileLabel: UILabel!
    var mNotificationList:[OrderBydate] = []
    
    let cellIdentifier = "notificationCell"
    let common = Common.common
    
    @IBOutlet weak var mNotificationTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let notifiRef = Database.database().reference(withPath: NOTIFICATION)
        notifiRef.keepSynced(true)
        
        self.getNotifications()
        
    

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table View Datasource 
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return mNotificationList.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return mNotificationList[section].date
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        headerView.backgroundColor = UIColor.lightGray
        
        let headerLabel = UILabel(frame: CGRect(x: 30, y: 5, width:
            tableView.bounds.size.width, height: tableView.bounds.size.height))
        headerLabel.font = FontForTextField
        headerLabel.textColor = UIColor.black
        headerLabel.text = self.tableView(self.mNotificationTableView, titleForHeaderInSection: section)
        headerLabel.sizeToFit()
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return mNotificationList[section].notifications.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as UITableViewCell
        cell.textLabel?.text = mNotificationList[indexPath.section].notifications[indexPath.row].titile
        //cell.accessoryView?.tintColor = .blue
        return cell
        
    }

     // MARK: - Table View Delegates
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "notificationDetail", sender: mNotificationList[indexPath.section].notifications[indexPath.row])
    }
    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "notificationDetail"
         {
            let dVC = segue.destination as! DetailsViewController
            dVC.selectedNotification = sender as! Notification
        }
    }

   
    
    func getNotifications()
    {
        common.fireBaseMethods.getValuesFromFireBase(root: NOTIFICATION, limit: 100, orderBy: "date") { (success, snapshot) in
            
            if snapshot.childrenCount > 0
            {
                for item in snapshot.children
                {
                    let snap = item as! DataSnapshot
                    print(snap)
                    let order = OrderBydate(snapshot: snap)
                    self.mNotificationList.insert(order, at: 0)
                    
                    
                }
                
                self.mNotificationTableView.reloadData()
            }
        }
    }

}
