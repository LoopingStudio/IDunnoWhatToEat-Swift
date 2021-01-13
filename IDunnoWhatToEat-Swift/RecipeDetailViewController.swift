//
//  RecipeDetailViewController.swift
//  IDunnoWhatToEat-Swift
//
//  Created by Kelian Daste on 13/01/2021.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    
    @IBOutlet weak var mealName: UILabel!
    var recipeModel: RecipeModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let recipe = recipeModel {
            mealName.text = recipe.mealName
        }
    }
}
