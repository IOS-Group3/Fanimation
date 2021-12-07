//
//  AnimeDetailsScreen.swift
//  Fanimation
//
//  Created by Ahmed  Elshetany  on 11/20/21.
//

import SwiftUI

func getBackground(anime: Anime) -> String {
	return anime.synopsis!
}

struct AnimeDetailsScreen: View {
	var anime: Anime
	@State var showMore: Bool = false
	@Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
	var btnBack : some View {
		Button(
			action: {
				self.presentationMode.wrappedValue.dismiss()
			}
		)
		{
			HStack {
				Image(systemName: "chevron.left") // set image here
					.aspectRatio(contentMode: .fit)
					.foregroundColor(Color.init("dark"))
				Text("Back").foregroundColor(Color.init("dark"))
			}
		}
	}
	
	var body: some View {
		ScrollView{
			VStack(alignment: .leading){
				HStack {
					AsyncImage(
						url: URL(string: anime.image_url)!,
						placeholder: { LoadingCard() },
						image: {
							Image(uiImage: $0)
								.resizable()
						}
					).frame(width: 150, height: 250).cornerRadius(15)
					Spacer()
					VStack {
						Text(anime.title)
							.fontWeight(.bold)
							.font(.title)
							.foregroundColor(.white)
						Spacer()
						Rating(rating: anime.avgRating ?? 0)
						Spacer()
						Rank(rank: anime.rank ?? 0)
						Spacer()
						Popularity(pop: anime.popularity ?? 0)
						Spacer()
						
					}
					Spacer()
				}
				.padding()
				Text("Description")
					.font(.title)
					.fontWeight(.bold)
					.multilineTextAlignment(.leading)
					.padding(.top)
				
				VStack{
					if anime.synopsis!.count > 400 {
						if showMore {
							Text(anime.synopsis ?? "").fontWeight(.semibold)
							
						} else {
							Text(String(anime.synopsis![..<anime.synopsis!.index(anime.synopsis!.startIndex, offsetBy: 399)]) + " ......").fontWeight(.semibold)
						}
						
						Button(
							action: {
								showMore.toggle()
							},
							label: {
								if showMore {
									Text("Show less")
									Image(systemName: "arrowtriangle.up.circle.fill")
								} else {
									Text("Show More")
									Image(systemName: "arrowtriangle.down.circle.fill")
                                }
							}
                        )
					} else {
						Text(anime.synopsis ?? "").fontWeight(.semibold)
					}
				}
				.multilineTextAlignment(.leading)
				.padding(.horizontal).animation(.easeInOut,value: showMore)
				
				
				Spacer()

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
			.navigationBarBackButtonHidden(true)
			.navigationBarItems(leading: btnBack)
            .overlay(editButton(animeTitle: anime.title, animeId: anime.mal_id, imageURL: anime.image_url))
	}
}

struct editButton: View {
    @State var editToggle:Bool = false
    @State var curr:Settings
    @State var isLoading:Bool = false
    let animeTitle:String
    let animeId:Int
    let imageURL:String
    
    init(animeTitle:String, animeId:Int, imageURL:String) {
        self.animeTitle = animeTitle
        self.animeId = animeId
        self.imageURL = imageURL
        self.curr = Settings(animeId: animeId, animeTitle: animeTitle, imageURL: imageURL)
    }
    
    var body: some View {
        VStack {
            Spacer()
            if editToggle {
                EditListScreen(editToggle: self.$editToggle, currSettings:self.$curr).padding(.top, 50).transition(.move(edge: .bottom))
            }
            Spacer()
            HStack {
                    Spacer()
                    Button(action: {
                        //check
                        isLoading.toggle() //Loading activator while settings are fetched
                        let firebase = FirebaseRequests()
                        firebase.queryAnime(animeId: animeId, animeTitle:animeTitle, imageURL: imageURL) { (result) in
                            curr = result
                            editToggle.toggle()
                            isLoading.toggle()
                        }
                    }) {
                        if isLoading {
                            ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color.white)).scaleEffect(2)
                                .frame(width: 75, height: 75).background(AngularGradient(gradient: Gradient(colors: [Color(red: 0.26, green: 0.632, blue: 0.981),Color(red: 0.278, green: 0.701, blue: 0.98), Color(red: 0.278, green: 0.701, blue: 0.98), Color(red: 0.26, green: 0.632, blue: 0.981)]), center: .center).opacity(0.92)).clipShape(Circle())
                        }else {
                            Image(systemName: "highlighter").font(.system(size: 30))
                                .frame(width: 75, height: 75)
                                .foregroundColor(Color.white)
                            .background(AngularGradient(gradient: Gradient(colors: [Color(red: 0.26, green: 0.632, blue: 0.981),Color(red: 0.278, green: 0.701, blue: 0.98), Color(red: 0.278, green: 0.701, blue: 0.98), Color(red: 0.26, green: 0.632, blue: 0.981)]), center: .center).opacity(0.92)).clipShape(Circle())
                        }
                        
                    }
            }.padding(.trailing, 20.0)
        }.background(editToggle ? Color.black.ignoresSafeArea().opacity(0.5): Color.black.ignoresSafeArea().opacity(0)).animation(.easeInOut,value: editToggle)
    }
}

struct Rating: View {
	var rating: Double
	var body: some View {
		HStack {
			Image(systemName: "star")
				.resizable()
				.foregroundColor(.white)
				.frame(width: 25, height: 25, alignment: .center)
			Text(String(format: "%.2f", rating))
				.fontWeight(.semibold)
				.font(.title2)
				.foregroundColor(.white)
		}
	}
}
struct Rank: View {
	var rank: Int
	var body: some View {
		VStack {
			Text("Rank")
				.fontWeight(.semibold)
				.font(.title2)
				.foregroundColor(.black)
			Text("# \(rank)")
				.fontWeight(.semibold)
				.font(.title2)
				.foregroundColor(.black)
			
		}
	}
}
struct Popularity: View {
	var pop: Int
	var body: some View {
		VStack {
			Text("Popularity")
				.fontWeight(.semibold)
				.font(.title2)
				.foregroundColor(.black)
			Text("# \(pop)")
				.fontWeight(.semibold)
				.font(.title2)
				.foregroundColor(.black)
		}
	}
}


struct AnimeDetailsScreen_Previews: PreviewProvider {
	static var previews: some View {
		AnimeDetailsScreen(anime: Anime())
	}
}
