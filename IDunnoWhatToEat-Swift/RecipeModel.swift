//
//  RecipeModel.swift
//  IDunnoWhatToEat-Swift
//
//  Created by Kelian Daste on 13/01/2021.
//

import Foundation
import UIKit

class RecipeModel {
    var id: Int
    var mealName: String
    var category: String
    var instructions: String
    var thumbnail: String
    var area: String
    var tags: String
    var ingredients: [String]
    var measures: [String]
    var youtubeLink: String
    
    var image: UIImage?
    
    init() {
        self.id = 0
        self.mealName = "Base Meal"
        self.category = "Base Category"
        self.instructions = "Base Instructions"
        self.thumbnail = ""
        self.area = "Base Area"
        self.tags = "Base Tag"
        self.ingredients = ["Ingredient 1", "Ingredient 2"]
        self.measures = ["Measure 1", "Measure 2"]
        self.youtubeLink = "https://www.youtube.com/"
    }
    
    init(id: Int, mealName: String, category: String, instructions: String, thumbnail: String, area: String, tags: String, ingredients: [String], measures: [String], youtubeLink: String) {
        self.id = id
        self.mealName = mealName
        self.category = category
        self.instructions = instructions
        self.thumbnail = thumbnail
        self.area = area
        self.tags = tags
        self.ingredients = ingredients
        self.measures = measures
        self.youtubeLink = youtubeLink
    }
    
    func toString() -> String{
        return "Recipe : \n\(mealName), in category : \n\(category)"
    }
}


/*
 idMeal    :    52871
 strMeal    :    Yaki Udon
 strDrinkAlternate    :    null
 strCategory    :    Vegetarian
 strArea    :    Japanese
 strInstructions    :    Boil some water in a large saucepan.
 strMealThumb    :    https://www.themealdb.com/images/media/meals/wrustq1511475474.jpg
 strTags    :    LowCalorie
 strYoutube    :    https://www.youtube.com/watch?v=5Iy0MCowSvA
 strIngredient1    :    Udon Noodles
 strIngredient2    :    Sesame Seed Oil
 strIngredient3    :    Onion
 strMeasure1    :    250g
 strMeasure2    :    2 tbs
 strMeasure3    :    1 sliced

 strSource    :    https://www.bbcgoodfood.com/recipes/yaki-udon
 dateModified    :    null

 */
extension UIImageView {
   func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
      URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
   }
   func downloadImage(from url: URL) {
      getData(from: url) {
         data, response, error in
         guard let data = data, error == nil else {
            return
         }
         DispatchQueue.main.async() {
            self.image = UIImage(data: data)
         }
      }
   }
}
