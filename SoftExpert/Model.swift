//
//  Model.swift
//  SoftExpert
//
//  Created by Mona Hammad on 1/22/20.
//  Copyright © 2020 Mona Hammad. All rights reserved.
//

import Foundation

struct Model : Codable {
    let q : String?
    let from : Int?
    let to : Int?
    let more : Bool?
    let count : Int?
    let hits : [Hits]?

    enum CodingKeys: String, CodingKey {

        case q = "q"
        case from = "from"
        case to = "to"
        case more = "more"
        case count = "count"
        case hits = "hits"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        q = try values.decodeIfPresent(String.self, forKey: .q)
        from = try values.decodeIfPresent(Int.self, forKey: .from)
        to = try values.decodeIfPresent(Int.self, forKey: .to)
        more = try values.decodeIfPresent(Bool.self, forKey: .more)
        count = try values.decodeIfPresent(Int.self, forKey: .count)
        hits = try values.decodeIfPresent([Hits].self, forKey: .hits)
    }

}
struct Hits : Codable {
    let recipe : Recipe?
    let bookmarked : Bool?
    let bought : Bool?

    enum CodingKeys: String, CodingKey {

        case recipe = "recipe"
        case bookmarked = "bookmarked"
        case bought = "bought"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        recipe = try values.decodeIfPresent(Recipe.self, forKey: .recipe)
        bookmarked = try values.decodeIfPresent(Bool.self, forKey: .bookmarked)
        bought = try values.decodeIfPresent(Bool.self, forKey: .bought)
    }

}
struct Recipe : Codable {
    let uri : String?
    let label : String?
    let image : String?
    let source : String?
    let url : String?
    let shareAs : String?
    let yield : Double?
    let dietLabels : [String]?
    let healthLabels : [String]?
    let cautions : [String]?
    let ingredientLines : [String]?
    let ingredients : [Ingredients]?
    let calories : Double?
    let totalWeight : Double?
    let totalTime : Double?
    let totalNutrients : [String: Nutrition]?
   // let totalDaily : TotalDaily?
   // let digest : [Digest]?

    enum CodingKeys: String, CodingKey {

        case uri = "uri"
        case label = "label"
        case image = "image"
        case source = "source"
        case url = "url"
        case shareAs = "shareAs"
        case yield = "yield"
        case dietLabels = "dietLabels"
        case healthLabels = "healthLabels"
        case cautions = "cautions"
        case ingredientLines = "ingredientLines"
        case ingredients = "ingredients"
        case calories = "calories"
        case totalWeight = "totalWeight"
        case totalTime = "totalTime"
        case totalNutrients = "totalNutrients"
//        case totalDaily = "totalDaily"
//        case digest = "digest"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        uri = try values.decodeIfPresent(String.self, forKey: .uri)
        label = try values.decodeIfPresent(String.self, forKey: .label)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        source = try values.decodeIfPresent(String.self, forKey: .source)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        shareAs = try values.decodeIfPresent(String.self, forKey: .shareAs)
        yield = try values.decodeIfPresent(Double.self, forKey: .yield)
        dietLabels = try values.decodeIfPresent([String].self, forKey: .dietLabels)
        healthLabels = try values.decodeIfPresent([String].self, forKey: .healthLabels)
        cautions = try values.decodeIfPresent([String].self, forKey: .cautions)
        ingredientLines = try values.decodeIfPresent([String].self, forKey: .ingredientLines)
        ingredients = try values.decodeIfPresent([Ingredients].self, forKey: .ingredients)
        calories = try values.decodeIfPresent(Double.self, forKey: .calories)
        totalWeight = try values.decodeIfPresent(Double.self, forKey: .totalWeight)
        totalTime = try values.decodeIfPresent(Double.self, forKey: .totalTime)
        totalNutrients = try values.decodeIfPresent([String: Nutrition].self, forKey: .totalNutrients)
//        totalDaily = try values.decodeIfPresent(TotalDaily.self, forKey: .totalDaily)
//        digest = try values.decodeIfPresent([Digest].self, forKey: .digest)
    }

}
struct Ingredients : Codable {
    let text : String?
    let weight : Double?

    enum CodingKeys: String, CodingKey {

        case text = "text"
        case weight = "weight"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        text = try values.decodeIfPresent(String.self, forKey: .text)
        weight = try values.decodeIfPresent(Double.self, forKey: .weight)
    }

}
struct Nutrition : Codable {
    let label : String?
    let quantity : Double?
    let unit : String?

    enum CodingKeys: String, CodingKey {

        case label = "label"
        case quantity = "quantity"
        case unit = "unit"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        label = try values.decodeIfPresent(String.self, forKey: .label)
        quantity = try values.decodeIfPresent(Double.self, forKey: .quantity)
        unit = try values.decodeIfPresent(String.self, forKey: .unit)
    }

}
