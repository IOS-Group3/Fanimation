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
    var startDate:String
    var progress: Int
    var score: Int
    
    init(animeId:Int, animeTitle:String, startDate:String, progress: Int, score: Int) {
        self.animeId = animeId
        self.animeTitle = animeTitle
        self.startDate = startDate
        self.progress = progress
        self.score = score
    }
    
    init() {
        animeId = -1
        animeTitle = ""
        startDate = ""
        progress = -1
        score = -1
    }
    
    enum CodingKeys: CodingKey {
        case animeId
        case animeTitle
        case startDate
        case progress
        case score
    }
    
    /*func searchAnime(watching: [WatchingList]) -> (WatchingList) {
        if watching.contains(where: {$0.animeId == animeId}) {
            //get item
            if let item = watching.first(where: {$0.animeId == animeId}) {
                return item
            }
            else {
                return WatchingList()
            }
        }
        return WatchingList()
    }*/
}
