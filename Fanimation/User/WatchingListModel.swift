//
//  WatchingListModel.swift
//  Fanimation
//
//  Created by Paola Jose on 11/28/21.
//

import Foundation

struct WatchingList: Codable {
    var animeId:Int
    var animeTitle:String
    var imageURL: String
    var startDate:String
    var progress: Int
    var score: Int
    
    init(animeId:Int, animeTitle:String, imageURL:String, startDate:String, progress: Int, score: Int) {
        self.animeId = animeId
        self.animeTitle = animeTitle
        self.imageURL = imageURL
        self.startDate = startDate
        self.progress = progress
        self.score = score
    }
    
    init() {
        animeId = -1
        animeTitle = ""
        imageURL = ""
        startDate = ""
        progress = -1
        score = -1
    }
    
    enum CodingKeys: CodingKey {
        case animeId
        case animeTitle
        case imageURL
        case startDate
        case progress
        case score
    }
    
}
