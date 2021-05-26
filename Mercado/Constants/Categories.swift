//
//  Categories.swift
//  Mercado
//
//  Created by Dina ElShabassy on 5/18/21.
//

import Foundation

struct Categories: Codable {
    let categoryIcon: String
    let categoryName: String
    let itemsCategoryName : String?
    let subCategories: [SubCategory]

    enum CodingKeys: String, CodingKey {
        case categoryIcon = "category_icon"
        case categoryName = "category_name"
        case itemsCategoryName
        case subCategories
    }
}

struct SubCategory: Codable {
    let subcategoryAPI: String
    let subcategoryName: String
    let itemSubCategoryName : String?

    enum CodingKeys: String, CodingKey {
        case subcategoryAPI = "subcategory_api"
        case subcategoryName = "subcategory_name"
        case itemSubCategoryName
    }
}
