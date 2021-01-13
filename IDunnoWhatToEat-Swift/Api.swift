//
//  Api.swift
//  IDunnoWhatToEat-Swift
//
//  Created by Kelian Daste on 13/01/2021.
//

import Foundation
import Alamofire

class Api {
    
    public static let shared = Api()
    static let RECIPE1 = "{\"idMeal\":\"52871\",\"strMeal\":\"Yaki Udon\",\"strDrinkAlternate\":null,\"strCategory\":\"Vegetarian\",\"strArea\":\"Japanese\",\"strInstructions\":\"Boil some water in a large saucepan. Add 250ml cold water and the udon noodles. (As they are so thick, adding cold water helps them to cook a little bit slower so the middle cooks through). If using frozen or fresh noodles, cook for 2 mins or until al dente; dried will take longer, about 5-6 mins. Drain and leave in the colander.\r\nHeat 1 tbsp of the oil, add the onion and cabbage and sauté for 5 mins until softened. Add the mushrooms and some spring onions, and sauté for 1 more min. Pour in the remaining sesame oil and the noodles. If using cold noodles, let them heat through before adding the ingredients for the sauce – otherwise tip in straight away and keep stir-frying until sticky and piping hot. Sprinkle with the remaining spring onions.\",\"strMealThumb\":\"https://www.themealdb.com/images/media/meals/wrustq1511475474.jpg\",\"strTags\":\"LowCalorie\",\"strYoutube\":\"https://www.youtube.com/watch?v=5Iy0MCowSvA\",\"strIngredient1\":\"Udon Noodles\",\"strIngredient2\":\"Sesame Seed Oil\",\"strIngredient3\":\"Onion\",\"strIngredient4\":\"Cabbage\",\"strIngredient5\":\"Shiitake Mushrooms\",\"strIngredient6\":\"Spring Onions\",\"strIngredient7\":\"Mirin\",\"strIngredient8\":\"Soy Sauce\",\"strIngredient9\":\"Caster Sugar\",\"strIngredient10\":\"Worcestershire Sauce\",\"strIngredient11\":\"\",\"strIngredient12\":\"\",\"strIngredient13\":\"\",\"strIngredient14\":\"\",\"strIngredient15\":\"\",\"strIngredient16\":\"\",\"strIngredient17\":\"\",\"strIngredient18\":\"\",\"strIngredient19\":\"\",\"strIngredient20\":\"\",\"strMeasure1\":\"250g\",\"strMeasure2\":\"2 tbs\",\"strMeasure3\":\"1 sliced\",\"strMeasure4\":\"0.25\",\"strMeasure5\":\"10\",\"strMeasure6\":\"4\",\"strMeasure7\":\"4 tbsp\",\"strMeasure8\":\"2 tbs\",\"strMeasure9\":\"1 tblsp \",\"strMeasure10\":\"1 tblsp \",\"strMeasure11\":\"\",\"strMeasure12\":\"\",\"strMeasure13\":\"\",\"strMeasure14\":\"\",\"strMeasure15\":\"\",\"strMeasure16\":\"\",\"strMeasure17\":\"\",\"strMeasure18\":\"\",\"strMeasure19\":\"\",\"strMeasure20\":\"\",\"strSource\":\"https://www.bbcgoodfood.com/recipes/yaki-udon\",\"dateModified\":null}"
    
    func fetchRandomRecipe(completion: @escaping(RecipeModel) -> Void) {
        AF.request("https://www.themealdb.com/api/json/v1/1/random.php").responseJSON { (response) in
            switch response.result {
            case .success:
                if let dictio = response.value as? [String: Any], let meals = dictio["meals"] as? [[String: Any]] {
                    if meals.count > 0 {
                        let meal = meals[0]
                        let id = meal["idMeal"] as? Int ?? 0
                        let mealName = meal["strMeal"] as? String ?? "No"
                        let category =  meal["strCategory"] as? String ?? "No"
                        let instructions =  meal["strInstructions"] as? String ?? "No"
                        let area =  meal["strArea"] as? String ?? "No"
                        let tags =  meal["strTags"] as? String ?? "No"
                        let youtubeLink =  meal["strYoutube"] as? String ?? "No"
                        
                        var ingredients = [String]()
                        var measures = [String]()
                        for i in 1...20 {
                            if let ingredient = meal["strIngredient\(i)"] as? String, !ingredient.isEmpty{
                                ingredients.append(ingredient)
                            }
                            if let measure = meal["strMeasure\(i)"] as? String, !measure.isEmpty{
                                measures.append(measure)
                            }
                        }
                        
                        let recipe = RecipeModel(id: id, mealName: mealName, category: category, instructions: instructions, area: area, tags: tags, ingredients: ingredients, measures: measures, youtubeLink: youtubeLink)
                        
                        let thumbnail =  meal["strMealThumb"] as? String ?? "No"
                        if let url = URL(string: thumbnail){
                            DispatchQueue.global().async {
                                let data = try? Data(contentsOf: url)
                                DispatchQueue.main.async {
                                    var image: UIImage?
                                    if let data = data {
                                        image = UIImage(data: data)
                                        recipe.setThumbnail(image: image)
                                    }
                                    completion(recipe)
                                }
                            }
                        } else {
                            completion(recipe)
                        }
                    }
                }
            case .failure:
                print(response.error!)
            }
        }
    }
}
