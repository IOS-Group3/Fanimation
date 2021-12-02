//
//  AnimeDetailsScreen.swift
//  Fanimation
//
//  Created by Ahmed  Elshetany  on 11/20/21.
//

//TODO: Add Styling

import SwiftUI

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
				Text(anime.description)
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
		AnimeDetailsScreen(anime: Anime(mal_id: 666, title: "Hunter X Hunter", image_url: "https://cdn.myanimelist.net/images/anime/11/33657l.jpg", description: "Hunter x Hunter is set in a world where Hunters exist to perform all manner of dangerous tasks like capturing criminals and bravely searching for lost treasures in uncharted territories. Twelve-year-old Gon Freecss is determined to become the best Hunter possible in hopes of finding his father, who was a Hunter himself and had long ago abandoned his young son. However, Gon soon realizes the path to achieving his goals is far more challenging than he could have ever imagined. Along the way to becoming an official Hunter, Gon befriends the lively doctor-in-training Leorio, vengeful Kurapika, and rebellious ex-assassin Killua. To attain their own goals and desires, together the four of them take the Hunter Exam, notorious for its low success rate and high probability of death. Throughout their journey, Gon and his friends embark on an adventure that puts them through many hardships and struggles. They will meet a plethora of monsters, creatures, and characters—all while learning what being a Hunter truly means.", avgRating: 6.78, rank: 44, popularity: 22))
	}
}
