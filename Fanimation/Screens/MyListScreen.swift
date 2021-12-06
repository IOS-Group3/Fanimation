//
//  MyListScreen.swift
//  Fanimation
//
//  Created by Ahmed  Elshetany  on 11/11/21.
//

import SwiftUI
//import Firebase
import FirebaseAuth
struct MyListScreen: View {
	var user: UserModel = UserModel(id: "33", email: "aelshetany@knights.ucf", profilePicUrl: "https://lh6.googleusercontent.com/proxy/8e57l1xjHUiJZlEWvzL2Spk7Znoc1SlogT3JeZWkGOlF1oOiOG5UzG91IxKZ92CUkqBRfEDQ8g5I22tOmrsEbEzqSg=w1200-h630-p-k-no-nu")
	
	@State var selectedTabIndex: Int = 0
	private let tabBarText = ["Watching", "Plan to Watch", "Completed"]
	
	
	var watchingList: [Anime] =  [Anime(),Anime(),Anime()]
	var planToWatchList: [Anime] =  [Anime(),Anime(),Anime()]
	var completed: [Anime] =  [Anime(),Anime(),Anime()]
	var body: some View {
		VStack {
			User(user: user)
			ZStack {
				VStack {
					
					HStack {
						ForEach(0..<tabBarText.count, id: \.self) { num in
							HStack {
								Button(action: {
									self.selectedTabIndex = num
								}, label: {
									Spacer()
									
									
									Text(tabBarText[num])
										.foregroundColor(selectedTabIndex == num ? .init("blue1") : .init("blue3"))
									
									
									Spacer()
								})
							}.font(.system(size: 17, weight: .semibold))
						}
					}
					Divider()
					switch selectedTabIndex {
						case 0:
							AnimeList(animelist: [Anime(),Anime(),Anime()])
						case 1:
							AnimeList(animelist: [Anime(),Anime(),Anime()])
						default:
							AnimeList(animelist: [Anime(),Anime(),Anime()])
							
					}
					Spacer()
						.frame(height: 3.0)
						.accentColor(.gray)
					
				}.edgesIgnoringSafeArea(.bottom)
			}
			Spacer()
		}
		
	}
}

struct User : View {
	var user: UserModel
	var body : some View {
		HStack {
			Spacer()
			AsyncImage(
				url: URL(string: user.profilePicUrl)!,
				placeholder: { LoadingCard()},
				image: {Image(uiImage: $0).resizable()}
				
			).frame(width: 100, height: 100)
				.clipShape(Circle())
				.shadow(radius: 7)
			Spacer()
			Text(user.email).font(.title3)
				.fontWeight(.heavy)
			Spacer()
		}
	}
}
struct AnimeList: View {
	var animelist : [Anime]
	@State var anime = Anime()
	@State var showDetailView = false
	let service = APIService()
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
		ScrollView(showsIndicators: false) {
			VStack(spacing: 20) {
				ForEach(animelist, id: \.mal_id) { anime in
					
					HStack(alignment: .bottom, spacing: -10){
						Spacer()
						
						
						VStack {
							Spacer()
							Text(anime.title)
								.font(.system(size: 20, weight: .heavy, design: .default))
								.foregroundColor(Color.black)
							Text(anime.start_date ?? "2020")
								.font(.system(size: 20, design: .default))
								.fontWeight(.thin)
								.foregroundColor(Color.black)
							
							Spacer()
							HStack{
								Spacer()
								Button(action: {
									//TODO: add functionality
									print("edit")
								}) {
									Image(systemName: "pencil")
								}
								Spacer()
								//TODO: add functionality
								Button(action: {
									print("add")
								}) {
									Image(systemName: "plus")
								}
								Spacer()
							}
							Spacer()
							ProgressView(value: 0.455)
								.padding(.all)
								.accentColor(.green)
							
							Spacer()
						}
						.background(Color.white.shadow(color: Color("dark"), radius: 5))
						.frame(width: 200, height: 150)
						
						NavigationLink(destination: AnimeDetailsScreen(anime: self.anime), isActive: $showDetailView) {
							AsyncImage(
								url: URL(string: anime.image_url)!,
								placeholder: { LoadingCard() },
								image: {Image(uiImage: $0).resizable()}
							)
								.frame(width: 150, height: 200)
								.cornerRadius(15).onTapGesture { openDetailView(animeID: anime.mal_id)}
						}
						Spacer()
						
					}
				}
			}
		}
	}
}

struct MyListScreen_Previews: PreviewProvider {
	static var previews: some View {
		MyListScreen()
		//		AnimeList(animelist: [Anime(),Anime(),Anime()])
		
	}
}
