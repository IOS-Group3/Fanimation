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

struct Anime: Codable {
    var mal_id: Int
    var title: String
    var image_url: String
    var start_date: String?
}
