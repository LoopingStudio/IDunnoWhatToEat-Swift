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
    var thumbnail: UIImage?
    var area: String
    var tags: String
    var ingredients: [String]
    var measures: [String]
    var youtubeLink: String
    
    init() {
        self.id = 0
        self.mealName = "Base Meal"
        self.category = "Base Category"
        self.instructions = "Base Instructions"
        self.area = "Base Area"
        self.tags = "Base Tag"
        self.ingredients = ["Ingredient 1", "Ingredient 2"]
        self.measures = ["Measure 1", "Measure 2"]
        self.youtubeLink = "https://www.youtube.com/"
    }
    
    init(id: Int, mealName: String, category: String, instructions: String, area: String, tags: String, ingredients: [String], measures: [String], youtubeLink: String) {
        self.id = id
        self.mealName = mealName
        self.category = category
        self.instructions = instructions
        self.area = area
        self.tags = tags
        self.ingredients = ingredients
        self.measures = measures
        self.youtubeLink = youtubeLink
    }
    
    func toString() -> String{
        return "Recipe : \n\(mealName), in category : \n\(category)"
    }
    
    func setThumbnail(image: UIImage?){
        self.thumbnail = image
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

@IBDesignable
public class Gradient: UIView {
    @IBInspectable var startColor:   UIColor = .black { didSet { updateColors() }}
    @IBInspectable var endColor:     UIColor = .white { didSet { updateColors() }}
    @IBInspectable var startLocation: Double =   0.05 { didSet { updateLocations() }}
    @IBInspectable var endLocation:   Double =   0.95 { didSet { updateLocations() }}
    @IBInspectable var horizontalMode:  Bool =  false { didSet { updatePoints() }}

    override public class var layerClass: AnyClass { CAGradientLayer.self }

    var gradientLayer: CAGradientLayer { layer as! CAGradientLayer }

    func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = .init(x: 0, y: 0.5)
            gradientLayer.endPoint   = .init(x: 1, y: 0.5)
        } else {
            gradientLayer.startPoint = .init(x: 0.5, y: 0)
            gradientLayer.endPoint   = .init(x: 0.5, y: 1)
        }
    }
    func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
    func updateColors() {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updatePoints()
        updateLocations()
        updateColors()
    }

}
