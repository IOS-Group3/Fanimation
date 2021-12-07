//
//  PendingListModel.swift
//  Fanimation
//
//  Created by Paola Jose on 11/28/21.
//

import Foundation

struct PendingList: Codable, Hashable {
    var animeId: Int
    var animeTitle:String
    var imageURL: String
    
    init(animeId:Int, animeTitle:String, imageURL:String) {
        self.animeId = animeId
        self.animeTitle = animeTitle
        self.imageURL = imageURL
    }
    
    enum CodingKeys: CodingKey {
        case animeTitle
        case animeId
        case imageURL
    }
    
    init() {
        animeId = -1
        animeTitle = ""
        imageURL = ""
    }
    
        
}
