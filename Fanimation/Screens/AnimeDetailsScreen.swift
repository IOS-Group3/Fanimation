//
//  AnimeDetailsScreen.swift
//  Fanimation
//
//  Created by Ahmed  Elshetany  on 11/20/21.
//

//TODO: Add Styling

import SwiftUI

func getBackground(anime: Anime) -> String {
    return anime.synopsis!
}

struct AnimeDetailsScreen: View {
	var anime: Anime
	var body: some View {
		ScrollView{
			VStack{
				HStack {
					AsyncImage(
						url: URL(string: anime.image_url)!,
						placeholder: { LoadingCard() },
						image: {
							Image(uiImage: $0)
								.resizable()
						}
					).frame(width: 150, height: 250).cornerRadius(15)
					VStack {
						Text(anime.title)
						Rating(rating: anime.avgRating ?? 0)
						Rank(rank: anime.rank ?? 0)
						Popularity(pop: anime.popularity ?? 0)
					}
					
				}
				Text("Description")
				Text(anime.synopsis ?? "")
					.multilineTextAlignment(.leading)
				Spacer()
			}
			
			.padding(.leading)
			.padding(.top, 50)
			
			.background(Image("waveWallpaper3")
							.resizable()
						
							.aspectRatio(1, contentMode: .fill)
							.frame(width:UIScreen.main.bounds.width)
			)
			Spacer()
		}.ignoresSafeArea()
	}
}

struct Rating: View {
	var rating: Double
	var body: some View {
		HStack {
			Image(systemName: "star")
			Text(String(format: "%.2f", rating))
		}
	}
}
struct Rank: View {
	var rank: Int
	var body: some View {
		VStack {
			Text("Rank")
			Text("# \(rank)")
		}
	}
}
struct Popularity: View {
	var pop: Int
	var body: some View {
		VStack {
			Text("Popularity")
			Text("# \(pop)")
		}
	}
}


struct AnimeDetailsScreen_Previews: PreviewProvider {
	static var previews: some View {
		AnimeDetailsScreen(anime: Anime())
	}
}

/*
 AnimeDetailsScreen
 */
