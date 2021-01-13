//
//  ViewController.swift
//  IDunnoWhatToEat-Swift
//
//  Created by Kelian Daste on 13/01/2021.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var getARecipeButton: UIButton!
    @IBOutlet weak var goToDetailButton: UIButton!
    
    private var randomRecipe: RecipeModel?
    private var nextRecipe: RecipeModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func fetchRecipe(){
        Api.shared.fetchRandomRecipe { (newRecipe) in
            self.randomRecipe = self.nextRecipe
            self.nextRecipe = newRecipe
            
            print("RECIPES: \n\(self.randomRecipe?.toString())\n\(self.nextRecipe?.toString())")
            
            if self.randomRecipe == nil {
                self.fetchRecipe()
            }
        }
    }

    @IBAction func getARecipe(_ sender: Any) {
        fetchRecipe()
    }
    
    @IBAction func goToDetails(_ sender: Any) {
        performSegue(withIdentifier: "goToDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? RecipeDetailViewController{
            destination.recipeModel = randomRecipe
        }
    }
}

