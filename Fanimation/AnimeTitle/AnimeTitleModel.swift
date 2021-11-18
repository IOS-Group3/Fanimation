//
//  AnimeTitle.swift
//  Fanimation
//
//  Created by Ahmed  Elshetany  on 11/17/21.
//

import Foundation

struct AnimeTitleModel:Identifiable, Hashable, Decodable {
	var id: Int
	var name: String
	var description: String
	var imageUrl: String
	var rank: Int
	var popularity: Int
	var avgRating: Double
	
	init(id: Int, name: String, description: String, imageUrl: String, rank: Int, popularity: Int, avgRating: Double){
		self.id = id
		self.name = name
		self.description = description
		self.imageUrl = imageUrl
		self.rank = rank
		self.popularity = popularity
		self.avgRating = avgRating
	}
}
