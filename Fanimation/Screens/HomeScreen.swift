/*
 Group 5: Fanimation
 Member 1: Paola Jose Lora
 Member 2: Recleph Mere
 Member 3: Ahmed Elshetany
 */

//
//  HomeScreen.swift
//  Fanimation
//
//  Created by Ahmed  Elshetany  on 11/11/21.
//  Last Modified: 12/06/21 by Recleph Mere
//
import SwiftUI

struct HomeScreen: View {
    
    @State var user: UserModel = UserModel(id: "33", email: "aelshetany@knights.ucf", username: "", profilePicUrl: "https://firebasestorage.googleapis.com/v0/b/fanimation-a2ee9.appspot.com/o/profileImages%2Fblank.png?alt=media&token=c1a5957e-aa94-4ff8-84df-d298aa2567e9")
    let popularity_url = URL(string:  "https://api.jikan.moe/v3/top/anime/1/bypopularity")
    let currAiring_url = URL(string:  "https://api.jikan.moe/v3/top/anime/1/airing")
    
    let firebaseServices = FirebaseRequests()
    @State var loading = true
    
    func getUserInfo() {
        firebaseServices.fetchUserProfile() { user in
            self.user = user
            loading = false
            
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                
                if loading {
                    HelloUserView(user: user)
                } else {
                    HelloUserView(user: user)
                }
                DiscoverAnimeView()
                AnimeListView(url: currAiring_url!, title: "Currently Airing")
                AnimeListView(url: popularity_url!, title: "Popular")
                Spacer()
            }.onAppear(perform: getUserInfo)
            .ignoresSafeArea()
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
