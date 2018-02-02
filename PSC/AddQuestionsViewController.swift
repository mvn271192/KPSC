//
//  AddQuestionsViewController.swift
//  PSC
//
//  Created by Manikandan V Nair on 31/01/18.
//  Copyright © 2018 MVN. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import Toast_Swift
import DropDown

class AddQuestionsViewController: UIViewController {
    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var mMainView: UIView!
    @IBOutlet weak var mScrollView: UIScrollView!
    @IBOutlet weak var ansTextField4: UITextField!
    
    @IBOutlet weak var ansTextField3: UITextField!
    @IBOutlet weak var ansTextField2: UITextField!
    @IBOutlet weak var ansTextField1: UITextField!
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var categoryPicker: UIButton!
    @IBOutlet var answerButtons: [UIButton]!
    
    private var selectedButtonTag:Int = 0
    private var selectedCategoryId:Int = 0
    var categoryList:[QuestionCategory] = []
    
    let common = Common.common
    
    private lazy var databaseRef: DatabaseReference = Database.database().reference()
    
     // MARK: - View LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.observeCategory()
        
       
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
     // MARK: - Actions
    
    @IBAction func saveButtonClick(_ sender: Any) {
        
        if (selectedCategoryId == 0 || selectedButtonTag == 0)
        {
            self.view.makeToast("Select a Category")
            return
        }
        guard let question = questionTextView.text ,question.count > 0 else
        {
            self.view.makeToast("Enter question")
            return
        }
        
        if let text1 = ansTextField1?.text, let text2 = ansTextField2?.text, let text3 = ansTextField3?.text, let text4 = ansTextField4?.text
        {
            let fireBaseCategoryId = categoryList[selectedCategoryId - 1].firebaseId as String
            
            let answers = [
                "Option1":text1,
                "Option2":text2,
                "Option3":text3,
                "Option4":text4,
                
                ] as [String:Any]
            let questionData = [
                "Question":question,
                "Answers":answers,
                "AnswerIndex":selectedButtonTag,
                "CategoryId":fireBaseCategoryId ,
                "Description":descriptionTextView.text
                ] as [String:Any]
            
            self.insertQuestion(questionData: questionData, categoryId: fireBaseCategoryId)
        }
        else
        {
            self.view.makeToast("Enter answers")
            return
        }
        
    }
    
    @IBAction func rightButtonClick(_ sender: Any) {
        
        self.deselectAllbuttons()
        let selectedButton = sender as! UIButton
        selectedButtonTag = selectedButton.tag
        selectedButton.isSelected = true
        
    }
    
    @IBAction func addCategoryButtonClick(_ sender: Any) {
        let alert = UIAlertController(title: AppTitile, message: "Enter Category Name", preferredStyle: .alert)
        alert.addTextField { (textField) in
            
        }
        
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            
            guard let text = textField?.text, text.count > 0  else {
                return
            }
            
            if (text.count > 15)
            {
                self.view.makeToast("Category name too large")
                return;
            }
            
            self.createCategory(with: text)
            
//            let key = self.createGroup(with: text)
//            let group = Group(name: text, createdBy: self.user.uid, members: [self.user.uid], gId: key, photoURL: "")
//            self.groupList.append(group)
//
//            self.groupTableView.beginUpdates()
//            self.groupTableView.insertRows(at: [NSIndexPath(row: self.groupList.count - 1, section: 0) as IndexPath], with: .fade)
//            self.groupTableView.endUpdates()
            
            //            self.groupTableView.reloadData()
            
            
            
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { [weak alert] (_) in
            alert?.dismiss(animated: true, completion: nil)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func categoryPickerClick(_ sender: Any) {
        
        guard categoryList.count > 0 else {
            
            self.view.makeToast("Add a category")
            return
        }
        let dropDown = DropDown()
        
        let button = sender as! UIButton
        dropDown.anchorView = button
        
        var dataSource:[String] = ["-Select category-"]
        
        for item in categoryList
        {
            dataSource.append(item.name)
        }
        
        dropDown.dataSource = dataSource
        dropDown.show()
        DropDown.startListeningToKeyboard()
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            
            button.setTitle(item, for: .normal)
            self.selectedCategoryId = index
        }
    }
    
    
    // MARK: - Other Functions
    
    func deselectAllbuttons()
    {
        for item in answerButtons
        {
            item.isSelected = false
        }
    }
    
    
    // MARK: - Firebase Operatons
    
    func observeCategory()
    {
        let nvactivity = common.setActitvityIndicator(inView: self.view)
        nvactivity.startAnimating()
        
        let categoryRef = databaseRef.child(CATEGORY)
        categoryRef.queryOrderedByValue().observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.childrenCount == 0
            {
                nvactivity.stopAnimating()
                self.view.makeToast("No Categories found")
                return
            }
            for item in snapshot.children
            {
                
                let categoryValue = item as! DataSnapshot
                let catData = categoryValue.value as! Dictionary<String,AnyObject>
                let category = QuestionCategory(name: catData["name"] as! String, Id: self.categoryList.count + 1, firebaseId: categoryValue.key)
                self.categoryList.append(category)
                nvactivity.stopAnimating()
            }
        }
    }
    
    func createCategory(with name:String)
    {
        
        let categoryRef = databaseRef.child(CATEGORY)
        let categoryData = [
            "name": name,
            "QuestionsId": nil,
            "createdBy":common.user.uid,
            ] as [String : Any]
        let groupHandle = categoryRef.childByAutoId()
        groupHandle.setValue(categoryData) { (error, databaseRef) in
            if error == nil
            {
                let newCategory = QuestionCategory(name: name, Id: self.categoryList.count + 1, firebaseId: groupHandle.key)
                self.categoryList.append(newCategory)
                
                self.view.makeToast("New category added")
                
            }
            
        }
       
    }
    
    func insertQuestion(questionData: [String : Any], categoryId: String)
    {
        let questionRef = databaseRef.child(QUESTIONS)
        
      
        let questionHandle = questionRef.childByAutoId()
        questionHandle.setValue(questionData, withCompletionBlock: { (error, data) in
            if (error == nil)
            {
                self.insertQuestionIdInCategory(categoryId: categoryId, questionId: questionHandle.key)
                
            }
            else
            {
                self.view.makeToast("Error occured during adding question")
                return
            }
        })
    }
    
    func insertQuestionIdInCategory(categoryId: String, questionId: String)
    {
        let categoryRef = databaseRef.child(CATEGORY).child(categoryId).child("Questions")
        categoryRef.child(questionId).setValue(true) { (error, dataRef) in
            
            if (error == nil)
            {
                self.view.makeToast("Question added")
                
            }
            else
            {
                self.view.makeToast("Error occured during adding question")
                return
            }
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
