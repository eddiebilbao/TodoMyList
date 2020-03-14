//
//  CategoryViewController.swift
//  Todoey
//
//  Created by User on 13/03/2020.
//  Copyright © 2020 naderkaabi. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    let realm = try! Realm()
    var categories : Results<Category>?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
        
    }

    
//MARK: - TableView Delegate Methods
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return categories?.count  ?? 1 // Using Nil Cooalescing Operator
    }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text =  categories?[indexPath.row].name ?? "No Categories added yet"
        return cell
            
    }
        
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            
            // context.delete(categories[indexPath.row])
            // categories.remove(at: indexPath.row)
            // loadCategories()
            
        performSegue(withIdentifier: "goToItems", sender: self)
          
    }
        
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
   }
    
//MARK: - Data Manipulation Methods
       
       
    func save(category: Category){

        do {
            try realm.write {
                realm.add(category)
            }
            
        } catch {
                print("Error saving category \(error)")
        }
        tableView.reloadData()
    }


    func loadCategories(){
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
          
//MARK: - Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add ", style: .default) {
            // what will happen once the user clicks the Add Item button on our UIAlert
            (action) in
                
                let newCategory = Category()
                newCategory.name = textField.text!
                self.save(category: newCategory)
        }
        
        alert.addTextField {
            (alertTextField) in
                alertTextField.placeholder = "Add a New Category"
                textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert,animated: true, completion: nil)
        
    }
    
    //MARK: - TableView Datasource Methods
    
    
    
    
    
   
    
    
    
   
       
}
