//
//  AddThoughtVC.swift
//  Notes
//
//  Created by Peter Emel on 12/12/19.
//  Copyright © 2019 Peter Emel. All rights reserved.
//

import UIKit
import Firebase

class AddThoughtVC: UIViewController, UITextViewDelegate {

    //Outlets
    @IBOutlet private weak var categorySegment: UISegmentedControl!
    @IBOutlet private weak var userNameTxt: UITextField!
    @IBOutlet private weak var thoughtTxt: UITextView!
    @IBOutlet private weak var postButton: UIButton!
    
    //variables
    private var selectedCategory = ThoughtCategory.funny.rawValue
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postButton.layer.cornerRadius = 4
        thoughtTxt.layer.cornerRadius = 4
        thoughtTxt.text = "My random thought..."
        thoughtTxt.textColor = UIColor.lightGray
        thoughtTxt.delegate = self

    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        thoughtTxt.text = ""
        thoughtTxt.textColor = UIColor.darkGray
    }
    
    
    @IBAction func postButtonTapped(_ sender: UIButton) {
        guard let username = userNameTxt.text else {return}
        Firestore.firestore().collection(THOUGHTS_REF).addDocument(data: [CATEGORY : selectedCategory, NUM_COMMENTS:0, NUM_LIKES:0, THOUGHT_TXT:thoughtTxt.text, TIMESTAMP:FieldValue.serverTimestamp(), USERNAME:username]) { (err) in
            if let err = err {
                debugPrint("Error adding Document: \(err)")
            }else{
                print("Success!")
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    

    @IBAction func categoryChanged(_ sender: Any) {
        switch categorySegment.selectedSegmentIndex {
        case 0:
            selectedCategory = ThoughtCategory.funny.rawValue
            print("Funny")
        case 1:
            selectedCategory = ThoughtCategory.serious.rawValue
            print("Serious")

        default:
            selectedCategory = ThoughtCategory.crazy.rawValue
            print("Crazy")

        }
    }
}
