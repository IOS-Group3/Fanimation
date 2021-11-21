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
		AnimeTitleModel(id: 666, name: "Hunter X Hunter", description: "Hunter x Hunter is set in a world where Hunters exist to perform all manner of dangerous tasks like capturing criminals and bravely searching for lost treasures in uncharted territories. Twelve-year-old Gon Freecss is determined to become the best Hunter possible in hopes of finding his father, who was a Hunter himself and had long ago abandoned his young son. However, Gon soon realizes the path to achieving his goals is far more challenging than he could have ever imagined. Along the way to becoming an official Hunter, Gon befriends the lively doctor-in-training Leorio, vengeful Kurapika, and rebellious ex-assassin Killua. To attain their own goals and desires, together the four of them take the Hunter Exam, notorious for its low success rate and high probability of death. Throughout their journey, Gon and his friends embark on an adventure that puts them through many hardships and struggles. They will meet a plethora of monsters, creatures, and characters—all while learning what being a Hunter truly means.", imageUrl: "https://cdn.myanimelist.net/images/anime/11/33657l.jpg", rank: 44, popularity: 22, avgRating: 6.78),
	]
	
	var user: UserModel = UserModel(id: 33, email: "aelshetany@knights.ucf", profilePicUrl: "https://lh6.googleusercontent.com/proxy/8e57l1xjHUiJZlEWvzL2Spk7Znoc1SlogT3JeZWkGOlF1oOiOG5UzG91IxKZ92CUkqBRfEDQ8g5I22tOmrsEbEzqSg=w1200-h630-p-k-no-nu")
	
	var body: some View {
		
		GeometryReader { proxy in
			let width = proxy.size.width
			let height = proxy.size.height
			ScrollView(showsIndicators: false) {
				HelloUser(user: user)
				VStack(alignment: .leading) {
					Text("Discover")
						.font(.title)
						.fontWeight(.bold)
						.padding(.leading, 30)
						.padding(.top, 50)
					
					TabView{
						ZStack {
							AsyncImage(
								url: URL(string: "https://img1.hulu.com/user/v3/artwork/4160deed-5e27-4f23-aa9a-a8e4f126e9cb?base_image_bucket_name=image_manager&base_image=86d73021-c991-4ad5-ba25-4814b6b01a65&size=1200x630&format=jpeg")!,
								placeholder: { LoadingCard() },
								image: {
									Image(uiImage: $0)
										.resizable()
								}
							)
						}
						ZStack {
							AsyncImage(
								url: URL(string: animes[1].imageUrl)!,
								placeholder: { LoadingCard() },
								image: {
									Image(uiImage: $0)
										.resizable()
								}
							)
						}
						
						ZStack {
							AsyncImage(
								url: URL(string: animes[2].imageUrl)!,
								placeholder: { LoadingCard() },
								image: {
									Image(uiImage: $0)
										.resizable()
								}
							)
						}
					}
					.frame(width: width * 0.9, height: height / 2)
					.cornerRadius(15)
					.padding(.horizontal)
					.tabViewStyle(PageTabViewStyle())
				}
				
				SubTitle(animes: animes, subtitle: "Currently Airing")
				SubTitle(animes: animes, subtitle: "Popular")
				SubTitle(animes: animes, subtitle: "Recommended")
				Spacer()
			}
			.ignoresSafeArea()
		}
	}
	
}

struct HelloUser: View {
	var user: UserModel
	var body: some View {
		VStack {
			Spacer()
			HStack(alignment: .top) {
				AsyncImage(
					url: URL(string: user.profilePicUrl)!,
					placeholder: { LoadingCard() },
					image: {
						Image(uiImage: $0)
							.resizable()
					}
				)
					.frame(width: 100, height: 100)
					.clipShape(Circle())
					.shadow(radius: 7)
				
				VStack(alignment: .leading) {
					Spacer()
					Text("Welcome Back")
						.font(.body)
						.fontWeight(.medium)
						.foregroundColor(.white)
					Spacer()
					Text(user.email)
						.font(.title3)
						.fontWeight(.heavy)
					Spacer()
				}
				Spacer()
			}
			Spacer()
		}.padding(.leading)
			.padding(.top, 50)
			.background(Image("waveWallpaper3")
							.resizable()
							.aspectRatio(1, contentMode: .fill)
							.frame(width:UIScreen.main.bounds.width)
							.padding(.top, 200)
			)
	}
}



struct AnimeCard: View {
	var anime: AnimeTitleModel
	var body: some View {
		NavigationLink(destination: Text("More Anime")) {
		ZStack{
			AsyncImage(
				url: URL(string: anime.imageUrl)!,
				placeholder: { LoadingCard() },
				image: {
					Image(uiImage: $0)
						.resizable()
				}
			)
			VStack {
				Spacer()
				Text(anime.name).font(.system(size: 15, weight: .heavy, design: .default)).foregroundColor(Color.white)
			}
		}
		.frame(width: 150, height: 1000 / 3.5)
		.cornerRadius(15)
		}
	}
}

struct LoadingCard: View{
	var body: some View{
		Image("playstore").resizable()
	}
}

struct ViewMore: View {
	var body: some View {
		NavigationLink(destination: Text("More Anime")) {
			VStack {
				Spacer()
				Spacer()
				Spacer()
				Image(systemName: "chevron.right.circle.fill")
					.resizable()
					.frame(width: 50, height: 50)
				Spacer()
				Text("More").fontWeight(.bold)
				Spacer()
				Spacer()
				Spacer()
			}
			.padding()
			.frame(width: 150, height: 1000 / 3.5)
			.background(Color.init("blue3"))
			.cornerRadius(15)
		}
		
	}
}

struct SubTitle: View {
	var animes: [AnimeTitleModel]
	var subtitle: String
	var body: some View {
		VStack(alignment: .leading) {
			Text(subtitle)
				.font(.headline)
				.fontWeight(.bold)
				.padding([.top, .leading])
			
			ScrollView(.horizontal, showsIndicators: false) {
				HStack {
					AnimeCard(anime: animes[0])
					AnimeCard(anime: animes[1])
					AnimeCard(anime: animes[2])
					AnimeCard(anime: animes[3])
					ViewMore()
				}
				.padding(.horizontal)
				
			}
		}
	}
}






struct HomeScreen_Previews: PreviewProvider {
	static var previews: some View {
		HomeScreen()
	}
}


