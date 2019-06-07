//
//  TextViewControl.swift
//  TextExtract
//
//  Created by Jack on 6/6/19.
//  Copyright © 2019 Jack. All rights reserved.
//

import UIKit
import CoreData

class TextViewControl: UITableViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var titlesArray = [Text]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        tableView.delegate = self
        loadItems()
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(titlesArray.count)
        return titlesArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath)
        cell.textLabel?.text = titlesArray[indexPath.row].title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToText", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Title", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let newItem = Text(context: self.context)
            newItem.title = textField.text!
            self.titlesArray.append(newItem)
            
            self.saveData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Enter Title or Name"
            if alertTextField.text != nil {
                textField = alertTextField
            }
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.titles = titlesArray[indexPath.row].title
        }
    }
 
    func saveData(){
        do {
            try context.save()
            
        } catch {
            print("Error saving catagory")
        }
        self.tableView.reloadData()
    }
    
    func loadItems(with request: NSFetchRequest<Text> = Text.fetchRequest()){
        do {
            titlesArray = try context.fetch(request)
        } catch {
            print("error fetching category")
        }
    }

}
