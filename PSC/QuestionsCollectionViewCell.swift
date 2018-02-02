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
            i += 1
        }
    }
    
    @IBAction func answerButtonClick(_ sender: Any) {
        
        self.deselectAllbuttons()
        let tapButton = sender as! UIButton
        if tapButton.tag == self.question.answerId
        {
            let center = tapButton.center
            tapButton.setImage(#imageLiteral(resourceName: "RadioSelected"), for: .normal)
            tapButton.center = center
            
        }
        else
        {
            let answerButton = answerView.viewWithTag(self.question.answerId) as! UIButton
            let ansCenter = answerButton.center
            let tapCenter = tapButton.center
            answerButton.setImage(#imageLiteral(resourceName: "RadioSelected"), for: .normal)
            tapButton.setImage(#imageLiteral(resourceName: "RadioWrong"), for: .normal)
            answerButton.center = ansCenter
            tapButton.center = tapCenter
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
