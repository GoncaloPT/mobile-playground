//
//  Movie.swift
//  favorite-movies-app
//
//  Created by ctw00977-admin on 16/09/2020.
//  Copyright © 2020 ctw00977-admin. All rights reserved.
//

import Foundation

class Movie{
    var id: String = ""
    var title: String = ""
    var year: String = ""
    var imageUrl: String = ""
    var plot: String = ""
    
    init(id: String, title:String, year: String, imageUrl: String, plot: String = "") {
        self.id = id
        self.title = title
        self.year = year
        self.imageUrl = imageUrl
        self.plot = plot
    }
}
