//
//  QuestionsViewController.swift
//  PSC
//
//  Created by Manikandan V Nair on 30/01/18.
//  Copyright © 2018 MVN. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class QuestionsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching, UICollectionViewDelegateFlowLayout {
   

    @IBOutlet weak var mCollectionView: UICollectionView!
    var mQuestions:[Questions] = []
    fileprivate let reuseIdentifier = "collectionViewCell"
    fileprivate let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    fileprivate let itemsPerRow: CGFloat = 1
    private lazy var databaseRef: DatabaseReference = Database.database().reference()
    
    let common = Common.common

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
       let questionRef = Database.database().reference(withPath: QUESTIONS)
        questionRef.keepSynced(true)
        observeQuestions()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Collection View Data Source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return mQuestions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! QuestionsCollectionViewCell
        
       // DispatchQueue.global(qos: .background).async {
            
            cell.setQuestion(question: self.mQuestions[indexPath.row])
            
          
     //   }
        

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: 250)
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
    
    func observeQuestions()
    {
        
        let nvactivity = common.setActitvityIndicator(inView: self.view)
        nvactivity.startAnimating()
        
        let questionRef = databaseRef.child(QUESTIONS)
        //questionRef.queryOrdered(byChild: "date")
        questionRef.queryOrdered(byChild: "date").queryLimited(toFirst: 10).observeSingleEvent(of: .value, with: { (snapshot) in
            
        
            
            self.mQuestions.removeAll()
            if snapshot.childrenCount == 0
            {
                nvactivity.stopAnimating()
                self.view.makeToast("No Categories found")
                return
            }
            
            for item in snapshot.children
            {
                
                let snap = item as! DataSnapshot
                let question = Questions(snapshot: snap)
                self.mQuestions.append(question)
                
                
            }
            DispatchQueue.main.async {
                nvactivity.stopAnimating()
                self.mQuestions = self.mQuestions.reversed()
                self.mCollectionView.reloadData()
            }
        })
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
