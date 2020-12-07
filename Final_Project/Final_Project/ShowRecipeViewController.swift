//
//  ShowRecipeViewController.swift
//  Final_Project
//
//  Created by user181204 on 12/2/20.
//

import UIKit

class ShowRecipeViewController: UIViewController {
    
    var recipe: Recipe? = nil

    override func viewDidLoad() {
        if let rec = recipe as Recipe? {
            recipeTitle.text = rec.title
            recipeDesc.text = rec.description
            recipeDir.text = rec.directions
            recipeIng.text = rec.ingredients
        }

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeDesc: UILabel!
    @IBOutlet weak var recipeDir: UILabel!
    @IBOutlet weak var recipeIng: UILabel!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
