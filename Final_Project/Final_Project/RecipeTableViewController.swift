//
//  RecipeTableViewController.swift
//  Final_Project
//
//  Created by user181204 on 12/2/20.
//

import UIKit
import Firebase

class RecipeTableViewController: UITableViewController, AddRecipeDelegate {
       
    
    var category: Category? = nil
    var recipeArr: [Recipe] = []
    var data: [String:Any]?
    let db = Firestore.firestore()
    var docRef : DocumentReference!
 
   
    
    var dvRecipe: Recipe? = nil
    
    @IBAction func addRecipe(_ sender: Any) {
        performSegue(withIdentifier: "addRecipe", sender: nil)
    }
    
    func didCreate(_ recipe: Recipe) {
        dismiss(animated: true, completion: nil)
       
        recipeArr.append(recipe)
      
        print("attempt to update db")
        self.updateFirebase(i: recipeArr.count)
        
        self.tableView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let settings = FirestoreSettings()
        db.settings = settings
        
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.recipeArr = [Recipe]()
        db.collection("recipes").getDocuments() { (snapshot, err) in
            if let err = err {
                print ("error \(err)")
            } else {
                for document in snapshot!.documents {
                    if (document.data()["category"] != nil) {
                    if ((document.data()["category"] as! String) == self.category?.title) {
                        self.recipeArr.append(Recipe(category: document.data()["category"] as! String, title: document.data()["title"] as! String, description: document.data()["description"] as! String, ingredients: document.data()["ingredients"] as! String, directions: document.data()["directions"] as! String))
                    }
                }
                }
                self.tableView.reloadData()
                
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return recipeArr.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "baseRecipe", for: indexPath)
        cell.textLabel?.text = recipeArr[indexPath.row].title
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        self.dvRecipe = recipeArr[indexPath.row]
        performSegue(withIdentifier: "showRecipe", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showRecipe") {
            let dvc = segue.destination as! ShowRecipeViewController
            dvc.recipe = self.dvRecipe
        } else if segue.identifier == "addRecipe" {
            let addR = segue.destination as! UINavigationController
            let add = addR.topViewController as! AddRecipeViewController
            add.delegate = self
            add.category = self.category
        }
        
    }
    
    func updateFirebase(i: Int) {
        let rec = recipeArr[i-1]
        let dataToSave : [String: Any] = ["category": self.category?.title, "title": rec.title, "description":rec.description, "ingredients": rec.ingredients, "directions":rec.directions]
        
        docRef = db.collection("recipes").document("\(i+1)")
        docRef.setData(dataToSave, completion: { error in
            if let _ = error {
                print("error here")
            } else {
                print("no error")
            }
        })
    }
}
