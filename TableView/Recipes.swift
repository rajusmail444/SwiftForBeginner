//
//  Recipes.swift
//  TableView
//
//  Created by Rajesh Billakanti on 10/07/16.
//  Copyright © 2016 RAjay. All rights reserved.
//

import Foundation
class Recipes{
    var name:String
    var thumbnails:String
    var prepTime:String
    var ingredients:Array<String>
    
    init(name:String,thumbnails:String,prepTime:String,ingredients:Array<String>){
        self.name = name
        self.thumbnails = thumbnails
        self.prepTime = prepTime
        self.ingredients = ingredients
    }
}
