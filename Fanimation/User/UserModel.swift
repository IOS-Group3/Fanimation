//
//  UserModel.swift
//  Fanimation
//
//  Created by Ahmed  Elshetany  on 11/18/21.
//

import Foundation

struct UserModel:Identifiable, Hashable, Decodable {
	var id: Int
	var email: String
	var profilePicUrl: String
	
	init(id: Int, email: String, profilePicUrl: String){
		self.id = id
		self.email = email
		self.profilePicUrl = profilePicUrl
	}
}
