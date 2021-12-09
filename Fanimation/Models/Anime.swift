/*
 Group 5: Fanimation
 Member 1: Paola Jose Lora
 Member 2: Recleph Mere
 Member 3: Ahmed Elshetany
 */

//
//  Anime.swift
//  Fanimation
//
//  Created by Recleph on 11/20/21.
//

import Foundation

struct Response: Codable {
    var top: [Anime]
}

struct Discover: Codable {
    var results: [Anime]
}

struct Ratings: Codable {
    var animeId: Int
    var animeTitle: String
    var imageURL: String
    var score: Int
}

struct Anime: Codable {
    var mal_id: Int
    var title: String
    var image_url: String
    var start_date: String?
	var avgRating: Double?
	var rank: Int?
	var popularity: Int?
    var synopsis: String?
    
    init(mal_id:Int, title:String? = "", image_url:String? = "") {
        self.mal_id = mal_id
        self.title = title!
        self.image_url = image_url!
    }
    
    init() {
        mal_id = 66
        title = "Hunter X Hunter"
        image_url = "https://cdn.myanimelist.net/images/anime/11/33657l.jpg"
        start_date = nil
        synopsis = "Hunter x Hunter is set in a world where Hunters exist to perform all manner of dangerous tasks like capturing criminals and bravely searching for lost treasures in uncharted territories. Twelve-year-old Gon Freecss is determined to become the best Hunter possible in hopes of finding his father, who was a Hunter himself and had long ago abandoned his young son. However, Gon soon realizes the path to achieving his goals is far more challenging than he could have ever imagined. Along the way to becoming an official Hunter, Gon befriends the lively doctor-in-training Leorio, vengeful Kurapika, and rebellious ex-assassin Killua. To attain their own goals and desires, together the four of them take the Hunter Exam, notorious for its low success rate and high probability of death. Throughout their journey, Gon and his friends embark on an adventure that puts them through many hardships and struggles. They will meet a plethora of monsters, creatures, and characters—all while learning what being a Hunter truly means."
    }
    
}
