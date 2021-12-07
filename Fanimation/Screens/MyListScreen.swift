//
//  MyListScreen.swift
//  Fanimation
//
//  Created by Ahmed  Elshetany  on 11/11/21.
//  Last Modified by Paola Jose Mere on 12/06/21.

import SwiftUI

import FirebaseAuth
struct MyListScreen: View {
	@State var user: UserModel = UserModel(id: "33", email: "aelshetany@knights.ucf", username: "", profilePicUrl: "https://firebasestorage.googleapis.com/v0/b/fanimation-a2ee9.appspot.com/o/profileImages%2Fblank.png?alt=media&token=c1a5957e-aa94-4ff8-84df-d298aa2567e9")
	
	@State var selectedTabIndex: Int = 0
	private let tabBarText = ["Watching", "Plan to Watch", "Completed"]
    let firebaseServices = FirebaseRequests()
    @State var loading = true
	
	
	
    @State var watchingList: [WatchingList] =  []
	@State var pendingList: [PendingList] =  []
	@State var completedList: [CompletedList] =  []
    
    func getUserInfo() {
        firebaseServices.fetchUserProfile() { user in
            self.user = user
            loading = false
            
        }
    }
	var body: some View {
		VStack {
            if loading {
                ProgressView()
            } else {
                User(user: user)
            }
			ZStack {
				VStack {
					
					HStack {
						ForEach(0..<tabBarText.count, id: \.self) { num in
							HStack {
								Button(action: {
									self.selectedTabIndex = num
                                    if num == 0 {
                                        firebaseServices
                                    }
                                    else if num == 1 {
                                        
                                    }
                                    else { //num == 2
                                        
                                    }
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
            }.onAppear(perform: getUserInfo)
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
			Text(user.username).font(.title3)
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
