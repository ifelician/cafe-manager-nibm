//
//  CategoryViewController.swift
//  cafe-manager
//
//  Created by Felician Ishark on 2021-04-30.
//

import UIKit
import FirebaseDatabase
import Loaf

class CategoryViewController: UIViewController {

    let databaseReference = Database.database().reference()
    
    var categoryList: [Category] = []
    
    @IBOutlet weak var txtCategoryName: UITextField!
    @IBOutlet weak var tblCategory: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
   
    
    @IBAction func onAddCategoryPressed(_ sender: UIButton) {
        if let name = txtCategoryName.text {
            addCategory(name: name)
        }
    }
}


extension CategoryViewController {
    func addCategory(name: String) {
        databaseReference
            .child("categories")
            .childByAutoId()
            .child("name")
            .setValue(name) {
                error, ref in
                if let error = error {
                    Loaf(error.localizedDescription, state: .error, sender: self).show()
                }
                else{
                    Loaf("Category Created", state: .success, sender: self).show()
                    self.refreshCategories()
                }
            }
        
    }
    
    func refreshCategories(){
        databaseReference
            .child("categories")
            .observeSingleEvent(of: .value, with: {
                snapshot in
                if snapshot.hasChildren(){
                    print(snapshot.value)
                }
            })
    }
}
