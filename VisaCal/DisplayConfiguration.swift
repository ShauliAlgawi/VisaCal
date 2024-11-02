//
//  DisplayConfiguration.swift
//  VisaCal
//
//  Created by Shauli Algawi on 02/11/2024.
//

import Foundation

/*
 
 DisplayConfiguration is an enum that define the fields of the Recipe object.
 It has 2 variables:
 
 * keyPath: the keyPath representation of the Recipe properties
 * displyName: the disoplay title of each field.
 
 */

//  Using this array we can determin which of the Recipe fields we will display in the RecipeDetails view. That way we gain more scalability and maintanability to the code as we can determin which field we would like to display without adding any new code in inside the RecipeDetails view.
//  This enum can be extanded to even decide what will be the color, font and other view modifiers that we can use for each field. 
let displayableFields: [DisplayConfiguration] = [.name, .fats, .calories, .carbos ,.description]


enum DisplayConfiguration {
    
    case calories
    case carbos
    case description
    case difficulty
    case fats
    case headline
    case id
    case image
    case name
    case proteins
    case thumb
    case time
    
    var keyPath: KeyPath<Recipe, String> {
        switch self {
        case .calories:
            return \Recipe.calories
        case .carbos:
            return \Recipe.carbos
        case .description:
            return \Recipe.description
        case .difficulty:
            return \Recipe.displayableDifficulty
        case .fats:
            return \Recipe.fats
        case .headline:
            return \Recipe.headline
        case .id:
            return \Recipe.id
        case .image:
            return \Recipe.image
        case .name:
            return \Recipe.name
        case .proteins:
            return \Recipe.proteins
        case .thumb:
            return \Recipe.thumb
        case .time:
            return \Recipe.time
        }
    }
    
    var displayName: String {
        switch self {
        case .calories:
            return "Calories"
        case .carbos:
            return "Carbos"
        case .description:
            return "Description"
        case .difficulty:
            return "Difficulty"
        case .fats:
            return "Fats"
        case .headline:
            return "headlinH"
        case .id:
            return ""
        case .image:
            return ""
        case .name:
            return "Name"
        case .proteins:
            return "Proteins"
        case .thumb:
            return ""
        case .time:
            return "Time"
        }
    }
}

extension Recipe {
    var displayableDifficulty: String {
        String(format: "%d", difficulty)
    }
}
