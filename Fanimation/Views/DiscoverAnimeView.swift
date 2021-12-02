//
//  DiscoverAnimeView.swift
//  Fanimation
//
//  Created by Recleph on 11/23/21.
//

import SwiftUI

struct DiscoverAnimeView: View {
	@State var animeList = [Anime]()
	let service = APIService()
	let url = URL(string:  "https://api.jikan.moe/v3/top/anime/1/upcoming")
	
	func loadData() {
		service.fetchAnimeList(url: url) { result in
			switch result {
				case .success(let animelist):
					var fullAnimeList = animelist
					fullAnimeList.shuffle()
					// GET three random Anime Titles
					for i in 0...3 {
						self.animeList.append(fullAnimeList[i])
					}
				case .failure(_):
					print("Error invoking URL")
			}
		}
	}
	
	var body: some View {
		VStack(alignment: .leading) {
			Text("Discover")
				.font(.title)
				.fontWeight(.bold)
				.padding(.leading, 30)
				.padding(.top, 50)
			if animeList.count > 0 {
				TabView {
					ForEach(animeList, id: \.mal_id) { anime in
						ZStack {
							AsyncImage(
								url: URL(string: anime.image_url)!,
								placeholder: { LoadingCard() },
								image: {Image(uiImage: $0).resizable()}
							).cornerRadius(15)
							
						}.frame(alignment: .bottomLeading)
					}
				}.tabViewStyle(PageTabViewStyle())
					.frame(width:350, height: 300)
					.cornerRadius(15)
			}
		}.onAppear(perform: loadData)
	}
}

struct DiscoverAnimeView_Previews: PreviewProvider {
	static var previews: some View {
		DiscoverAnimeView()
	}
}
