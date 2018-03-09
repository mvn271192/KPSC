//
//  FirebaseOperations.swift
//  PSC
//
//  Created by Manikandan V Nair on 21/02/18.
//  Copyright © 2018 MVN. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class FirebaseOperations
{
    private lazy var databaseRef: DatabaseReference = Database.database().reference()
    typealias CompletionHandler = (_ success:Bool, _ data:DataSnapshot) -> Void
    
    init() {
        
    }
    func getValuesFromFireBase(root: String, limit: Int, orderBy: String, completionHandler:  @escaping CompletionHandler)  {
        
        let dbRef = databaseRef.child(root)
//        dbRef.queryOrderedByValue()
        dbRef.queryOrdered(byChild: orderBy).queryLimited(toFirst: UInt(limit)).observeSingleEvent(of: .value, with: { (snapshot) in

            completionHandler(true,snapshot)


        })
        
//        dbRef.queryOrderedByValue().queryLimited(toLast: UInt(30)).observeSingleEvent(of: .value, with: { (snapshot) in
//
//            completionHandler(true,snapshot)
//
//
//        })
    }
}
