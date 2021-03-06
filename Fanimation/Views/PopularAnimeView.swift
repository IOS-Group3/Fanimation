/*
 Group 5: Fanimation
 Member 1: Paola Jose Lora
 Member 2: Recleph Mere
 Member 3: Ahmed Elshetany
 */

//
//  PopularAnimeView.swift
//  Fanimation
//
//  Created by Recleph on 11/20/21.
//

import SwiftUI

struct PopularAnimeView: View {
    @State var animelist = [Anime]()
    let service = APIService()
    let url = URL(string:  "https://api.jikan.moe/v3/top/anime/1/bypopularity")
    
    func loadData() {
        service.fetchAnimeList(url: url) { result in
            switch result {
            case .success(let animelist):
					print(animelist)
                self.animelist = animelist
            case .failure(_):
                print("Error invoking URL")
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Popular")
                .font(.headline)
                .fontWeight(.bold)
                .padding([.top, .leading])
            
            ScrollView(.horizontal) {
                HStack(spacing: 20) {
                    ForEach(animelist, id: \.mal_id) { anime in
                        //  the UI
                        ZStack (alignment: .bottomTrailing){
                            AsyncImage(
                                url: URL(string: anime.image_url)!,
                                placeholder: { LoadingCard() },
                                image: {Image(uiImage: $0).resizable()}
                            )
                                .frame(width: 200, height: 300)
                                .cornerRadius(15)
                            VStack {
                                Text(anime.title).font(.system(size: 20, weight: .heavy, design: .default)).foregroundColor(Color.white).padding(20)
                            }.frame(width: 200, height: 300, alignment: .bottomLeading).cornerRadius(15)
                        }
                    }
                }
            }.padding(.horizontal)
        }.onAppear(perform: loadData)
    }
}

struct PopularAnimeView_Previews: PreviewProvider {
    static var service = APIService()
    static var animelist = [Anime]()
    
    static var previews: some View {
        PopularAnimeView()
    }
}
