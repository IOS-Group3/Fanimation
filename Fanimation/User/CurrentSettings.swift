/*
 Group 5: Fanimation
 Member 1: Paola Jose Lora
 Member 2: Recleph Mere
 Member 3: Ahmed Elshetany
 */


//
//  CurrentSettings.swift
//  Fanimation
//
//  Created by Paola Jose on 11/28/21.
//  Last Modified: 12/07/2021 by Recleph Mere

import Foundation

struct Settings {
    var animeTitle:String
    var animeId:Int
    var imageURL: String
    var statusList:Int
    var isFavorited:Bool
    var isList:Int
    var scoreButton: Int
    var progressButton: Int
    var startDate: String
    var endDate: String
    
    init(animeId:Int, animeTitle:String, imageURL:String, statusList:Int, isFavorited:Bool, scoreButton: Int? = -1 , progressButton: Int? = 0, startDate: String? = "", endDate: String? = "") {
        self.animeId = animeId
        self.animeTitle = animeTitle
        self.imageURL = imageURL
        self.statusList = statusList
        self.isFavorited = isFavorited
        self.isList = statusList
        self.scoreButton = scoreButton!
        self.progressButton = progressButton!
        self.startDate = startDate!
        self.endDate = endDate!
    }
    
    //Anime is not on any list
    init(animeId:Int, animeTitle:String, imageURL:String) {
        self.animeId = animeId
        self.animeTitle = animeTitle
        self.imageURL = imageURL
        self.statusList = 1
        self.isFavorited = false
        self.isList = -1
        self.scoreButton = -1
        self.progressButton = 0
        self.startDate = ""
        self.endDate = ""
    }    
}
