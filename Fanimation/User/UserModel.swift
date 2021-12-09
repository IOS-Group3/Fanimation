/*
 Group 5: Fanimation
 Member 1: Paola Jose Lora
 Member 2: Recleph Mere
 Member 3: Ahmed Elshetany
 */

//
//  UserModel.swift
//  Fanimation
//
//  Created by Ahmed  Elshetany  on 11/18/21.
//

import Foundation

struct UserModel:Identifiable, Hashable, Codable {
	var id: String
	var email: String
	var profilePicUrl: String
    var username: String
	
    init(id: String, email: String, username: String, profilePicUrl: String){
		self.id = id
		self.email = email
		self.profilePicUrl = profilePicUrl
        self.username = username
	}
    
    init(){
        id = "33"
        email = "aelshetany@knights.ucf"
        profilePicUrl = "https://firebasestorage.googleapis.com/v0/b/fanimation-a2ee9.appspot.com/o/profileImages%2Fdefault.png?alt=media&token=0173621f-2d11-4f56-9716-b03c65f69b59"
        username = "Username"
    }
}
