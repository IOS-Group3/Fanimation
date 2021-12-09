/*
 Group 5: Fanimation
 Member 1: Paola Jose Lora
 Member 2: Recleph Mere
 Member 3: Ahmed Elshetany
 */


//
//  FavoritesListModel.swift
//  Fanimation
//
//  Created by Paola Jose on 11/28/21.
//  Last Modified: 12/07/21 by Recleph Mere

import Foundation

struct FavoritedAnime: Codable {
    var animeId: Int
    var animeTitle: String
    var imageURL: String
    var startDate: String
    var endDate: String
    var score: Int
    
    init(animeId: Int, animeTitle: String, imageURL: String, startDate: String, endDate: String, score: Int) {
        self.animeId = animeId
        self.animeTitle = animeTitle
        self.imageURL = imageURL
        self.startDate = startDate
        self.endDate = endDate
        self.score = score
    }
    
    init() {
        animeId = -1
        animeTitle = ""
        imageURL = ""
        startDate = ""
        endDate = ""
        score = -1
    }
    
    enum CodingKeys: CodingKey {
        case animeId
        case animeTitle
        case imageURL
        case startDate
        case endDate
        case score
    }
    
}
