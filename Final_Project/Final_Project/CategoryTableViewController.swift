//
//  CategoryTableViewController.swift
//  Final_Project
//
//  Created by user181204 on 12/2/20.
//

import UIKit
import Firebase

class CategoryTableViewController: UITableViewController, AddCategoryDelegate {
    
    var catArray = [Category]()
    
    var docRef: DocumentReference!
    
    var data: [String: Any]?
    
    let db = Firestore.firestore()
    
    var dvCat: Category? = nil
    
    func didCreate(_ category: Category) {
        dismiss(animated: true, completion: nil)
        catArray.append(category)
        self.updateFirebase(i: catArray.count - 1)
        self.tableView.reloadData()
    }
    
    @IBAction func addCategory(_ sender: Any) {
        performSegue(withIdentifier: "addCategory", sender: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
       catArray = [Category]()
        db.collection("categories").getDocuments() { (snapshot, err) in
            if let err = err {
                print ("error \(err)")
            } else {
                for document in snapshot!.documents {
                    self.catArray.append(Category(title: (document.data()["title"] as? String)!, color: (document.data()["color"] as? String)!, count: (document.data()["count"] as? Int)!))
                    
                }
                self.tableView.reloadData()
                
                self.catArray.sort(by: {$0.title.lowercased() < $1.title.lowercased()})
            }
        }
        
    }

    // MARK: - Table view data source
    func updateFirebase(i: Int) {
      
        let cat = catArray[i]
        let dataToSave : [String: Any] = ["title": cat.title, "count": cat.count, "color": cat.color]
        docRef = db.collection("categories").document("\(i)")
        docRef.setData(dataToSave, completion: { error in
        if let _ = error {
            print("error found here")
        } else {
            print("no error")
            }
        })
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return  catArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "base", for: indexPath)
        
        db.collection("categories").document("\(indexPath.row)").getDocument { (docSnapshot, error) in
            if let data = docSnapshot?.data() {
                print("querying db")
                cell.textLabel?.text =  data["title"] as? String
                cell.contentView.backgroundColor =  self.hextoUI(hex: data["color"] as! String)
            }
      
            
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        self.dvCat =  catArray[indexPath.row]
        performSegue(withIdentifier: "viewRecipes", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewRecipes" {
            let next = segue.destination as! RecipeTableViewController
            next.category = self.dvCat
        } else if segue.identifier == "addCategory" {
            let next = segue.destination as! UINavigationController
            let addC = next.topViewController as! AddCategoryViewController
            addC.delegate = self
        }
    }
    
    func hextoUI (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

            if (cString.hasPrefix("#")) {
                cString.remove(at: cString.startIndex)
            }

            if ((cString.count) != 6) {
                return UIColor.gray
            }

            var rgbValue:UInt64 = 0
            Scanner(string: cString).scanHexInt64(&rgbValue)

            return UIColor(
                red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: CGFloat(1.0)
            )
    }

    

    
}
