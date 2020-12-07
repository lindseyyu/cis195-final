//
//  AddRecipeViewController.swift
//  Final_Project
//
//  Created by user181204 on 12/2/20.
//

import UIKit

protocol AddRecipeDelegate: class {
    func didCreate(_ recipe: Recipe)
}

class AddRecipeViewController: UIViewController {
    
    weak var delegate: AddRecipeDelegate?
    var category: Category? = nil
    
    @IBOutlet weak var rTitle: UITextField!
    @IBOutlet weak var sDesc: UITextField!
    @IBOutlet weak var rDir: UITextField!
    @IBOutlet weak var iList: UITextField!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancel(_sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func save(_sender: Any) {
        let newRecipe = createNewRecipe()
        dump(newRecipe)
        if newRecipe != nil {
            delegate?.didCreate(newRecipe!)
        }
    }

    func createNewRecipe() -> Recipe? {
        if (rTitle.hasText && sDesc.hasText && rDir.hasText && iList.hasText) {
            return Recipe(category: self.category!.title, title: rTitle.text!, description: sDesc.text!, ingredients: iList.text!, directions: rDir.text!)
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
