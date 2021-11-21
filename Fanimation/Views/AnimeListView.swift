//
//  AnimeListView.swift
//  Fanimation
//
//  Created by Recleph on 11/20/21.
//

import SwiftUI

struct AnimeListView: View {
    @State var animelist = [Anime]()
    let service = APIService()
    var url: URL
    
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
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 20) {
                ForEach(animelist, id: \.mal_id) { anime in
                    //  the UI
                    VStack {
                        Text(anime.title).font(.title2).foregroundColor(.primary)
                        Text(anime.start_date ?? "").font(.headline).foregroundColor(.secondary)
                    }.frame(width: 200, height: 300)
                        .background(Color.blue)
                }
            }
        }.onAppear(perform: loadData)
    }
}

struct AnimeListView_Previews: PreviewProvider {
    static var service = APIService()
    static var animelist = [Anime]()
    static var url = URL(string:  "https://api.jikan.moe/v3/top/anime/1/bypopularity")
    
    static var previews: some View {
        AnimeListView(url: url!)
    }
}
