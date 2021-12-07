//
//  CompletedList.swift
//  Fanimation
//
//  Created by Paola Jose on 11/28/21.
//

import Foundation

struct CompletedList: Codable {
    var animeId: Int
    var animeTitle: String
    var imageURL: String
    var startDate: String
    var endDate: String
    var score: Int
    
    init(animeId: Int, animeTitle: String, imageURL:String, startDate: String, endDate: String, score: Int) {
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
        case startDate
        case imageURL
        case endDate
        case score
    }
}
