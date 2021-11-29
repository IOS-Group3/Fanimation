//
//  FavoritesListModel.swift
//  Fanimation
//
//  Created by Paola Jose on 11/28/21.
//

import Foundation

struct Favoritelist {
    var animeId: Int
    var animeTitle: String
    var startDate: String
    var endDate: String
    var score: Int
    
    init(animeId: Int, animeTitle: String, startDate: String, endDate: String, score: Int) {
        self.animeId = animeId
        self.animeTitle = animeTitle
        self.startDate = startDate
        self.endDate = endDate
        self.score = score
    }
    
    init() {
        animeId = -1
        animeTitle = ""
        startDate = ""
        endDate = ""
        score = -1
    }
    
}
