//
//  Questions.swift
//  PSC
//
//  Created by Manikandan V Nair on 30/01/18.
//  Copyright © 2018 MVN. All rights reserved.
//

import Foundation
import Firebase

class Questions {
    
    var questions:String!
    var questionId:String!
    var answerId:Int!
    var options:[Answer] = []
    var description:String?
    
    init(questions: String, questionId: String, answerId: Int, options: [Dictionary<String,Int>]) {
        
    }
    
    init(snapshot snap:DataSnapshot!)
    {
        if let data = snap {
            let questionId = data.key
            let questionData = data.value as! Dictionary<String,AnyObject>
            
            if let question = questionData["Question"] as! String!, question.count > 0
            {
                let options = questionData["Answers"] as! Dictionary<String,String>
                self.questions = question
                self.answerId = questionData["AnswerIndex"] as! Int!
                self.questionId = questionId
                if let des = questionData["Description"] as! String!
                {
                    self.description = des
                }
                else
                {
                    self.description = ""
                }
                if let arrayMembers = Array(options.values) as [String]!
                {
                    var i = 1
                    for item in arrayMembers
                    {
                        let ans = Answer(name: item, Id: i)
                        self.options.append(ans)
                        i += 1
                    }
                }
                else
                {
                    self.options = []
                }
                
                
            }
        }
        
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
