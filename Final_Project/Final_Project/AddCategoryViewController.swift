//
//  AddCategoryViewController.swift
//  Final_Project
//
//  Created by user181204 on 12/2/20.
//

import UIKit

protocol AddCategoryDelegate: class {
    func didCreate(_ category: Category)
}

class AddCategoryViewController: UIViewController {
    
    
    @IBOutlet weak var catTitle: UITextField!
    
    weak var delegate: AddCategoryDelegate?
    
    @IBOutlet weak var circle: UIImageView!
    
    var color: String = "ffffff"
    
    @IBAction func cancel(_sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_sender: Any) {
        let newCategory = createNewCategory()
        dump(newCategory)
        if (newCategory != nil) {
            delegate?.didCreate(newCategory!)
        }
    }
    
    @IBAction func turnBlue(_sender: Any) {
        circle.image = UIImage(named: "circle_blue")
        color = "97d2fb"
    }
    @IBAction func turnPink(_sender: Any) {
        circle.image = UIImage(named: "circle_pink")
        color = "fdc5f5"
    }
    @IBAction func turnOrange(_sender: Any) {
        circle.image = UIImage(named: "circle_orange")
        color = "ffcf8e"
    }
    @IBAction func turnGreen(_sender: Any) {
        circle.image = UIImage(named: "circle_green")
        color = "aeeea9"
    }
    @IBAction func turnWhite(_sender: Any) {
        circle.image = UIImage(named: "circle_white")
        color = "ffffff"
    }
    
    func createNewCategory() -> Category? {
        if (catTitle.hasText) {
            return Category(title: catTitle.text!, color: color, count: 0)
         }
        return nil
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
