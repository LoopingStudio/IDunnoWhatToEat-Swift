//
//  ViewController.swift
//  IDunnoWhatToEat-Swift
//
//  Created by Kelian Daste on 13/01/2021.
//

import UIKit
import Kingfisher

class MainViewController: UIViewController {

    @IBOutlet weak var mealName: UILabel!
    
    @IBOutlet weak var mealImage: UIImageView!
    @IBOutlet weak var getARecipeButton: UIButton!
    @IBOutlet weak var goToDetailButton: UIButton!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    private var isFetching = false
    
    private var randomRecipe: RecipeModel?
    private var nextRecipe: RecipeModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Api.shared.fetchRandomRecipe { (firstRecipe) in
            print("First recipe : \(firstRecipe.mealName)")
            self.randomRecipe = firstRecipe
            self.setRecipeView()
            self.fetchRecipe()
        }
    }
    
    func setRecipeView(){
        if let meal = randomRecipe {
            mealName.text = meal.mealName
            mealImage.image = meal.thumbnail
            loadingView.isHidden = true
        }
    }
    
    func fetchRecipe(){
        if isFetching {
            print("A Recipe is currently fetching")
            loadingView.isHidden = false
        } else {
            print("FETCH RECIPE")
            if nextRecipe != nil {
                self.randomRecipe = self.nextRecipe
                self.setRecipeView()
            }
            isFetching = true
            Api.shared.fetchRandomRecipe { (newRecipe) in
                self.nextRecipe = newRecipe
                self.isFetching = false
                self.setRecipeView()
                print("New recipe fetched: \(newRecipe.mealName)")
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

