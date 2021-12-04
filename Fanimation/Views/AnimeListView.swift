//
//  AnimeListView.swift
//  Fanimation
//
//  Created by Recleph on 11/20/21.
//

import SwiftUI

struct AnimeListView: View {
    @State var animelist = [Anime]()
    @State var anime = Anime()
    @State var showDetailView = false
    let service = APIService()
    var url: URL
    var title: String
    
    func loadData() {
        service.fetchAnimeList(url: url) { result in
            switch result {
            case .success(let animelist):
                self.animelist = animelist
            case .failure(_):
                print("Error invoking URL")
            }
        }
    }
    
    func openDetailView(animeID: Int) {
        let anime_url = URL(string: "https://api.jikan.moe/v3/anime/\(animeID)")
        service.fetchAnimeTitle(url: anime_url) { result in
            switch result {
            case .success(let anime):
                self.anime = anime
                showDetailView = true
            case .failure(_):
                print("Error invoking URL")
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {

            Text(self.title)
                .font(.headline)
                .fontWeight(.bold)
                .padding([.top, .leading])
            
            
            ScrollView(.horizontal) {
                HStack(spacing: 20) {
                    ForEach(animelist, id: \.mal_id) { anime in
                        NavigationLink(destination: AnimeDetailsScreen(anime: self.anime), isActive: $showDetailView) {
                            ZStack (alignment: .bottomTrailing){
                                AsyncImage(
                                    url: URL(string: anime.image_url)!,
                                    placeholder: { LoadingCard() },
                                    image: {Image(uiImage: $0).resizable()}
                                )
                                    .frame(width: 200, height: 300)
                                    .cornerRadius(15).onTapGesture { openDetailView(animeID: anime.mal_id)}
                                VStack {
                                    Text(anime.title).font(.system(size: 20, weight: .heavy, design: .default)).foregroundColor(Color.white).padding(20)
                                }.frame(width: 200, height: 300, alignment: .bottomLeading).cornerRadius(15)
                            }
						}
                    }
                }
            }.padding(.horizontal)
        }.onAppear(perform: loadData)
    }
}


struct AnimeListView_Previews: PreviewProvider {
    static var service = APIService()
    static var animelist = [Anime]()
    static var url = URL(string:  "https://api.jikan.moe/v3/top/anime/1/bypopularity")
    
    static var previews: some View {
        NavigationView {
            AnimeListView(url: url!, title: "Popularity")
        }
    }
}
