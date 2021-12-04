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
				.padding(.horizontal)
				
				
				Spacer()
				
				Button (
					action:{
						// TODO: add functionality
						print("edit")
					}, label: {
						HStack(alignment: .center) {
							Spacer()
							Image(systemName: "highlighter")
								.resizable()
								.padding()
								.foregroundColor(.white)
								.background(Color.init("blue2"))
								.frame(width: 75, height: 75)
								.clipShape(Circle())
								.shadow(radius: 10)
								.overlay(Circle().stroke(Color.init("blue1"), lineWidth: 5))
						}.padding()
					}
				)
				
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

