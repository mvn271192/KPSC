//
//  Questions.swift
//  PSC
//
//  Created by Manikandan V Nair on 30/01/18.
//  Copyright © 2018 MVN. All rights reserved.
//

import Foundation

class Questions {
    
    var questions:String!
    var questionId:Int!
    var answerId:Int!
    var options:[Answer] = []
    
    init(questions: String, questionId: Int, answerId: Int, options: [Dictionary<String,Int>]) {
        
    }
}

struct Answer {
    
    var name:String!
    var Id:Int!
}

struct QuestionCategory {
    
    var name:String!
    var Id:Int!
    var firebaseId:String!
}
