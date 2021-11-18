//
//  HomeScreen.swift
//  Fanimation
//
//  Created by Ahmed  Elshetany  on 11/11/21.
//

import SwiftUI

struct HomeScreen: View {
	var animes: [AnimeTitleModel] =
	[
		AnimeTitleModel(id: 666, name: "Hunter X Hunter", description: "Hunter x Hunter is set in a world where Hunters exist to perform all manner of dangerous tasks like capturing criminals and bravely searching for lost treasures in uncharted territories. Twelve-year-old Gon Freecss is determined to become the best Hunter possible in hopes of finding his father, who was a Hunter himself and had long ago abandoned his young son. However, Gon soon realizes the path to achieving his goals is far more challenging than he could have ever imagined. Along the way to becoming an official Hunter, Gon befriends the lively doctor-in-training Leorio, vengeful Kurapika, and rebellious ex-assassin Killua. To attain their own goals and desires, together the four of them take the Hunter Exam, notorious for its low success rate and high probability of death. Throughout their journey, Gon and his friends embark on an adventure that puts them through many hardships and struggles. They will meet a plethora of monsters, creatures, and characters—all while learning what being a Hunter truly means.", imageUrl: "https://cdn.myanimelist.net/images/anime/11/33657l.jpg", rank: 44, popularity: 22, avgRating: 6.78),
		AnimeTitleModel(id: 666, name: "Hunter X Hunter", description: "Hunter x Hunter is set in a world where Hunters exist to perform all manner of dangerous tasks like capturing criminals and bravely searching for lost treasures in uncharted territories. Twelve-year-old Gon Freecss is determined to become the best Hunter possible in hopes of finding his father, who was a Hunter himself and had long ago abandoned his young son. However, Gon soon realizes the path to achieving his goals is far more challenging than he could have ever imagined. Along the way to becoming an official Hunter, Gon befriends the lively doctor-in-training Leorio, vengeful Kurapika, and rebellious ex-assassin Killua. To attain their own goals and desires, together the four of them take the Hunter Exam, notorious for its low success rate and high probability of death. Throughout their journey, Gon and his friends embark on an adventure that puts them through many hardships and struggles. They will meet a plethora of monsters, creatures, and characters—all while learning what being a Hunter truly means.", imageUrl: "https://cdn.myanimelist.net/images/anime/11/33657l.jpg", rank: 44, popularity: 22, avgRating: 6.78),
		AnimeTitleModel(id: 666, name: "Hunter X Hunter", description: "Hunter x Hunter is set in a world where Hunters exist to perform all manner of dangerous tasks like capturing criminals and bravely searching for lost treasures in uncharted territories. Twelve-year-old Gon Freecss is determined to become the best Hunter possible in hopes of finding his father, who was a Hunter himself and had long ago abandoned his young son. However, Gon soon realizes the path to achieving his goals is far more challenging than he could have ever imagined. Along the way to becoming an official Hunter, Gon befriends the lively doctor-in-training Leorio, vengeful Kurapika, and rebellious ex-assassin Killua. To attain their own goals and desires, together the four of them take the Hunter Exam, notorious for its low success rate and high probability of death. Throughout their journey, Gon and his friends embark on an adventure that puts them through many hardships and struggles. They will meet a plethora of monsters, creatures, and characters—all while learning what being a Hunter truly means.", imageUrl: "https://cdn.myanimelist.net/images/anime/11/33657l.jpg", rank: 44, popularity: 22, avgRating: 6.78),
	]
	
	
	
	var body: some View {
		GeometryReader { proxy in
			//			let width = proxy.size.width
			let height = proxy.size.height
			ScrollView(showsIndicators: false) {
				Spacer()
				HelloUser(anime: animes[0])
				ScrollView(.horizontal, showsIndicators: false) {
					HStack(spacing: 150.0) {
						AnimeCard(anime: animes[0])
						AnimeCard(anime: animes[0])
						AnimeCard(anime: animes[0])
						AnimeCard(anime: animes[0])
						AnimeCard(anime: animes[0])
					}
					
				}.frame(height: height)
			}
//			.ignoresSafeArea()
			.background(Color.init("blue3"))
			.ignoresSafeArea()
			
		}
	}
	
}

struct HelloUser: View {
	var anime: AnimeTitleModel
	var body: some View {
//		GeometryReader { proxy in
			//			let width = proxy.size.width
//			let height = proxy.size.height
			AsyncImage(
				url: URL(string: anime.imageUrl)!,
				placeholder: { Text("Loading ...") },
				image: {
					Image(uiImage: $0)
						.resizable()
				}
			)
				.frame(width: 150, height: 150)
				.clipShape(Circle())
				.shadow(radius: 7)
		}
//	}
}



struct AnimeCard: View {
	var anime: AnimeTitleModel
	var body: some View {
		GeometryReader { proxy in
			//			let width = proxy.size.width
			let height = proxy.size.height
			
			ZStack{
				AsyncImage(
					url: URL(string: anime.imageUrl)!,
					placeholder: { Text("Loading ...") },
					image: {
						Image(uiImage: $0)
							.resizable()
					}
				)
					.frame(width: 150, height: height / 3.5)
					.cornerRadius(15)
				Text(anime.name)
			}
			
		}
	}
}

struct HomeScreen_Previews: PreviewProvider {
	static var previews: some View {
		HomeScreen()
	}
}
