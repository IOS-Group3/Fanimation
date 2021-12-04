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
    
    init(animeId:Int, animeTitle:String ) {
        self.animeId = animeId
        self.animeTitle = animeTitle
    }
    
    enum CodingKeys: CodingKey {
        case animeTitle
        case animeId
    }
    
    init() {
        animeId = -1
        animeTitle = ""
    }
    
        
}
