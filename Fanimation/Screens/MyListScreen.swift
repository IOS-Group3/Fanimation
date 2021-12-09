//
//  MyListScreen.swift
//  Fanimation
//
//  Created by Ahmed  Elshetany  on 11/11/21.
//  Last Modified by Paola Jose Mere on 12/06/21.

import SwiftUI
import Firebase
import FirebaseAuth
struct MyListScreen: View {
	@State var user: UserModel = UserModel(id: "33", email: "aelshetany@knights.ucf", username: "", profilePicUrl: "https://firebasestorage.googleapis.com/v0/b/fanimation-a2ee9.appspot.com/o/profileImages%2Fblank.png?alt=media&token=c1a5957e-aa94-4ff8-84df-d298aa2567e9")
	
	@State var selectedTabIndex: Int = 0
	private let tabBarText = ["Watching", "Plan to Watch", "Completed"]
	let firebaseServices = FirebaseRequests()
	@State var loading = true
	let db = Firestore.firestore()
	
	
	@State var watchingList: [WatchingList] =  []
	@State var pendingList: [PendingList] =  []
	@State var completedList: [CompletedList] =  []
	@State var watchAnime:[Anime] = []
	@State var editToggle:Bool = false
	
	func getUserInfo() {
		firebaseServices.fetchUserProfile() { user in
			self.user = user
			loading = false
			
		}
	}
	func getLists() {
		firebaseServices.fetchWatchingList { (result) in
			watchingList = result
			print("\(result)")
			firebaseServices.fetchPendingList { (pending) in
				pendingList = pending
				print("\(pending)")
				firebaseServices.fetchCompletedList { (completed) in
					completedList = completed
					print("\(completed)")
				}
			}
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
									
								}, label: {
									Spacer()
									
									
									Text(tabBarText[num])
										.foregroundColor(selectedTabIndex == num ? .init("blue1") : .init("blue3"))
									
									
									Spacer()
								})
							}.font(.system(size: 17, weight: .semibold))
						}.disabled(editToggle)
						
					}
					Divider()
					switch selectedTabIndex {
							
						case 0:
							Screens(animelist: WatchToAnime(watchingList: watchingList),list: 1,editToggle: $editToggle, watching: self.$watchingList, pending: self.$pendingList, completed: self.$completedList)
								.background(editToggle ? Color.black.ignoresSafeArea().opacity(0.5): Color.black.ignoresSafeArea().opacity(0)).animation(.easeInOut,value: editToggle).onAppear(perform: getLists)
						case 1:
							Screens(animelist: PendingToAnime(pendingList: pendingList), list: 2, editToggle: $editToggle, watching: self.$watchingList, pending: self.$pendingList, completed: self.$completedList)
								.background(editToggle ? Color.black.ignoresSafeArea().opacity(0.5): Color.black.ignoresSafeArea().opacity(0)).animation(.easeInOut,value: editToggle)
						default:
							Screens(animelist: CompletedToAnime(completedList: completedList), list: 3, editToggle: $editToggle, watching: self.$watchingList, pending: self.$pendingList, completed: self.$completedList)
							
							
					}
					Spacer()
						.frame(height: 3.0)
						.accentColor(.gray)
					
					
				}.edgesIgnoringSafeArea(.bottom)
				
				
				
			}.onAppear(perform: getUserInfo)
				.onAppear(perform: getLists)
			
			Spacer()
		}
		
	}
}

struct Screens: View {
	var animelist : [Anime]
	let list:Int
	var editToggle:Binding<Bool>
	@State var curr:Settings = Settings(animeId: -1, animeTitle: "", imageURL: "")
	var watching:Binding<[WatchingList]>
	var pending:Binding<[PendingList]>
	var completed:Binding<[CompletedList]>
	
	init(animelist:[Anime], list:Int, editToggle:Binding<Bool>, watching:Binding<[WatchingList]>, pending:Binding<[PendingList]>, completed:Binding<[CompletedList]>){
		self.list = list
		self.editToggle = editToggle
		self.animelist = animelist
		self.watching = watching
		self.pending = pending
		self.completed = completed
	}
	var body: some View {
		VStack {
			if(!editToggle.wrappedValue) {
				AnimeList(animelist: animelist, list: list, editToggle: editToggle, watching: watching, curr: $curr, pending:pending, completed: completed).animation(.easeInOut, value: !editToggle.wrappedValue)
			}
			else {
				ZStack {
					Color.black.opacity(0.5).ignoresSafeArea(.all).animation(.easeInOut(duration: 2).delay(1), value:(editToggle.wrappedValue))
					
				}
			}
		}.overlay(editView(editToggle: editToggle, curr: $curr))
		
		
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
	let firebase = FirebaseRequests()
	var animelist : [Anime]
	let list:Int
	@State var editToggle:Binding<Bool>
	var curr:Binding<Settings>
	var watching:Binding<[WatchingList]>
	var pending:Binding<[PendingList]>
	var completed:Binding<[CompletedList]>
	@State var anime = Anime()
	@State var showDetailView = false
	let service = APIService()
	
	init(animelist:[Anime], list:Int, editToggle:Binding<Bool>, watching:Binding<[WatchingList]>, curr:Binding<Settings>, pending:Binding<[PendingList]>, completed:Binding<[CompletedList]>){
		self.list = list
		self.editToggle = editToggle
		self.animelist = animelist
		self.watching = watching
		self.pending = pending
		self.completed = completed
		self.curr = curr
		
	}
	
	func getLists() {
		firebase.fetchWatchingList { (result) in
			watching.wrappedValue = result
			firebase.fetchPendingList { (pendingResults) in
				pending.wrappedValue = pendingResults
				firebase.fetchCompletedList { (completedResults) in
					completed.wrappedValue = completedResults
				}
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
	
	func fetchProgress(watchingList:[WatchingList], animeId:Int) ->(Int) {
		
		if watchingList.contains(where: {$0.animeId == animeId}) {
			//get item
			if let item = watchingList.first(where: {$0.animeId == animeId}) {
				//Check favorites, don't retrieve
				print(item.progress)
				return item.progress
			}
			else {
				return 0
			}
		}
		else {
			return 0
		}
		
	}
	var body: some View {
		ScrollView(showsIndicators: false) {
			VStack(spacing: 20) {
				ForEach(animelist, id: \.mal_id) { anime in
					VStack{
						ZStack {
							RoundedRectangle(cornerRadius: 15, style: .continuous).fill(Color.white).frame( width: 350, height: 200)
								.shadow(color: Color.black.opacity(0.7), radius: 4, x: 1, y: 1)
							
							HStack {
								Spacer()
								NavigationLink(destination: AnimeDetailsScreen(anime: self.anime), isActive: $showDetailView) {
									AsyncImage(
										url: URL(string: anime.image_url)!,
										placeholder: { LoadingCard() },
										image: {Image(uiImage: $0).resizable()}
									)
										.frame(width: 130, height: 200).cornerRadius(15)
										.offset(x: 10)
										.shadow(radius: 10)
										.onTapGesture { openDetailView(animeID: anime.mal_id)}
								}.disabled(editToggle.wrappedValue)
								Spacer()
								
								VStack(alignment: .center) {
									Spacer()
									Text(anime.title)
										.font(.system(size: 20, weight: .heavy, design: .default))
										.foregroundColor(Color.black)
									Spacer()
									Text(anime.start_date ?? "2020")
										.font(.system(size: 20, design: .default))
										.fontWeight(.thin)
										.foregroundColor(Color.black)
									
									Spacer()
									Spacer()
									var progression = fetchProgress(watchingList: watching.wrappedValue, animeId: anime.mal_id)
									HStack{
										Spacer()
										Button(action: {
											firebase.queryAnime(animeId: anime.mal_id, animeTitle: anime.title, imageURL: anime.image_url) { (result) in
												curr.wrappedValue = result
												editToggle.wrappedValue.toggle()
												
											}
											
											print("edit")
										}) {
											Image(systemName: "pencil")
										}
										Spacer()
										if (list == 1) {
											Button(action: {
												progression += 1
												firebase.updateProgress(animeId: anime.mal_id, progress: Int(progression)) { (result) in
													if result == true {
														firebase.fetchWatchingList {(result) in
															watching.wrappedValue = result
														}
													}
												}
												
											}) {
												Image(systemName: "plus")
											}.disabled(progression >= 10 ? true : false)
											Spacer()
										}
									}
									//								Spacer()
									if(list == 1) {
										ProgressView(value: Double(progression), total: 10.0)
											.padding(.all, 50)
											.accentColor(.green)
									}
								}
								.offset(y: 10)
								Spacer()
							}
							
							
							
							Spacer()
						}
						
					}
				}
			}
		}.onAppear(perform: getLists)
	}
}

struct editView: View {
	var editToggle:Binding<Bool>
	var curr:Binding<Settings>
	init(editToggle:Binding<Bool>, curr:Binding<Settings>) {
		self.editToggle = editToggle
		self.curr = curr
	}
	var body: some View {
		HStack {
			if(editToggle.wrappedValue) {
				EditListScreen(editToggle: editToggle, currSettings: curr).transition(.move(edge: .bottom))
			}
		}
	}
}

func WatchToAnime(watchingList:[WatchingList]) -> ([Anime]) {
	var anime:[Anime] = []
	
	for list in watchingList {
		anime.append(Anime(mal_id: list.animeId, title: list.animeTitle, image_url: list.imageURL))
	}
	
	return anime
}
func PendingToAnime(pendingList:[PendingList]) -> ([Anime]) {
	var anime:[Anime] = []
	
	for list in pendingList {
		anime.append(Anime(mal_id: list.animeId, title: list.animeTitle, image_url: list.imageURL))
	}
	
	return anime
}
func CompletedToAnime(completedList:[CompletedList]) -> ([Anime]) {
	var anime:[Anime] = []
	
	for list in completedList {
		anime.append(Anime(mal_id: list.animeId, title: list.animeTitle, image_url: list.imageURL))
	}
	
	return anime
}

struct MyListScreen_Previews: PreviewProvider {
	static var previews: some View {
		MyListScreen()
		//		AnimeList(animelist: [Anime(),Anime(),Anime()])
		
	}
}
