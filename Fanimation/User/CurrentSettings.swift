//
//  CurrentSettings.swift
//  Fanimation
//
//  Created by Paola Jose on 11/28/21.
//

import Foundation

struct Settings {
    var animeTitle:String
    var animeId:Int
    var statusList:Int
    var isFavorited:Bool
    var isList:Int
    var scoreButton: Int
    var progressButton: Int
    
    init(animeId:Int, animeTitle:String, statusList:Int, isFavorited:Bool, scoreButton: Int? = -1 , progressButton: Int? = 0) {
        self.animeId = animeId
        self.animeTitle = animeTitle
        self.statusList = statusList
        self.isFavorited = isFavorited
        self.isList = statusList
        self.scoreButton = scoreButton!
        self.progressButton = progressButton!
    }
    
    //Anime is not on any list
    init(animeId:Int, animeTitle:String) {
        self.animeId = animeId
        self.animeTitle = animeTitle
        self.statusList = 1
        self.isFavorited = false
        self.isList = -1
        self.scoreButton = -1
        self.progressButton = 0
    }    
}
