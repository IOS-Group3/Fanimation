//
//  HomeScreen.swift
//  Fanimation
//
//  Created by Ahmed  Elshetany  on 11/11/21.
//  Last Modified: 11/19/21 by Recleph Mere
//
import SwiftUI

struct HomeScreen: View {
    
    var user: UserModel = UserModel(id: "33", email: "aelshetany@knights.ucf", profilePicUrl: "https://lh6.googleusercontent.com/proxy/8e57l1xjHUiJZlEWvzL2Spk7Znoc1SlogT3JeZWkGOlF1oOiOG5UzG91IxKZ92CUkqBRfEDQ8g5I22tOmrsEbEzqSg=w1200-h630-p-k-no-nu")
    let popularity_url = URL(string:  "https://api.jikan.moe/v3/top/anime/1/bypopularity")
    let currAiring_url = URL(string:  "https://api.jikan.moe/v3/top/anime/1/airing")
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                
                HelloUserView(user: user)
                DiscoverAnimeView()
                AnimeListView(url: currAiring_url!, title: "Currently Airing")
                AnimeListView(url: popularity_url!, title: "Popular")
                Spacer()
            }
            .ignoresSafeArea()
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
