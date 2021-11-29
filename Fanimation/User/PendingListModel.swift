//
//  PendingListModel.swift
//  Fanimation
//
//  Created by Paola Jose on 11/28/21.
//

import Foundation

struct PendingList {
    var animeId: Int
    var animeTitle:String
    
    init(animeId:Int, animeTitle:String ) {
        self.animeId = animeId
        self.animeTitle = animeTitle
    }
    
    init() {
        animeId = -1
        animeTitle = ""
    }
}
