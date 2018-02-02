//
//  QuestionsCollectionViewCell.swift
//  PSC
//
//  Created by Manikandan V Nair on 01/02/18.
//  Copyright © 2018 MVN. All rights reserved.
//

import UIKit

class QuestionsCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerView: UIView!
    
    @IBOutlet var answerButtons: [UIButton]!
    private var question:Questions!
    
    func setQuestion(question:Questions)
    {
        self.question = question
        questionLabel?.text = question.questions
        self.setAnswerButtons(answerList: question.options)
        self.answerView.isUserInteractionEnabled = true
        
        if (self.question.answeredId != 0)
        {
            self.answerView.isUserInteractionEnabled = false
            let btn = self.answerView.viewWithTag(self.question.answeredId) as! UIButton
            if (self.question.answeredId == self.question.answerId){
                
                btn.setImage(#imageLiteral(resourceName: "RadioSelected"), for: .normal)
            }
            else
            {
                let correctbtn = self.answerView.viewWithTag(self.question.answerId) as! UIButton
                correctbtn.setImage(#imageLiteral(resourceName: "RadioSelected"), for: .normal)
                btn.setImage(#imageLiteral(resourceName: "RadioWrong"), for: .normal)
            }
            
        }
        
        
    }
    
    func setAnswerButtons(answerList:[Answer])
    {
        self.deselectAllbuttons()
        if answerList.count > 4
        {
            return
        }
        var i = 0
        for item in answerList
        {
            let btn = answerButtons[i]
            btn.setTitle(item.name, for: .normal)
            btn.tag = item.Id
            i += 1
        }
    }
    
    @IBAction func answerButtonClick(_ sender: Any) {
        
        self.deselectAllbuttons()
        
        let tapButton = sender as! UIButton
        self.question.answeredId = tapButton.tag
        self.answerView.isUserInteractionEnabled = false
        
        if tapButton.tag == self.question.answerId
        {
            let frame = tapButton.frame
            tapButton.setImage(#imageLiteral(resourceName: "RadioSelected"), for: .normal)
            tapButton.frame = frame
            
            self.makeToast("Right answer!")
            
        }
        else
        {
            let answerButton = answerView.viewWithTag(self.question.answerId) as! UIButton
            let ansframe = answerButton.frame
            let tapframe = tapButton.frame
            answerButton.setImage(#imageLiteral(resourceName: "RadioSelected"), for: .normal)
            tapButton.setImage(#imageLiteral(resourceName: "RadioWrong"), for: .normal)
            answerButton.frame = ansframe
            tapButton.frame = tapframe
            
            self.makeToast("Wrong answer!")
        }
    }
    
    func deselectAllbuttons()
    {
        for item in answerButtons
        {
            item.setImage(#imageLiteral(resourceName: "RadioUnSelectd"), for: .normal)
            item.isSelected = false
            item.imageView?.contentMode = .scaleAspectFit
        }
    }
    
}
