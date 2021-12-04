//
//  AnimeDetailsScreen.swift
//  Fanimation
//
//  Created by Ahmed  Elshetany  on 11/20/21.
//  Modified by Paola Jose on 12/01/21.

//TODO: Add Styling

import SwiftUI

struct AnimeDetailsScreen: View {
	var anime: AnimeTitleModel
    var body: some View {
		ScrollView{
		VStack{
			AsyncImage(
				url: URL(string: anime.imageUrl)!,
				placeholder: { LoadingCard() },
				image: {
					Image(uiImage: $0)
						.resizable()
				}
			).frame(width: 200, height: 400)
			
			Text(anime.name)
			Rating(rating: anime.avgRating)
			Rank(rank: anime.rank)
			Popularity(pop: anime.popularity)
			Text(anime.description)
				.multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
            
            Spacer()
                .padding(/*@START_MENU_TOKEN@*/.top/*@END_MENU_TOKEN@*/)
		}
        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        }.overlay(editButton(animeTitle: anime.name, animeId: anime.id))

    }
}

struct editButton: View {
    @State var editToggle:Bool = false
    let  animeTitle:String
    let  animeId:Int
    
    init(animeTitle:String, animeId:Int) {
        self.animeTitle = animeTitle
        self.animeId = animeId
    }
    
    var body: some View {
        VStack {
            Spacer()
            if editToggle {
                
                //EditListScreen(editToggle: self.$editToggle, currSettings: <#Binding<Settings>#>,animeTitle:animeTitle,animeId: animeId).padding(.top, 50).transition(.move(edge: .bottom))
                
            }
            Spacer()
            HStack {
                    Spacer()
                
                    Button(action: {
                        editToggle.toggle()
                    }) {
                        Image(systemName: "square.and.pencil")
                            .font(.system(size: 25))
                            .frame(width: 60, height: 60)
                            .foregroundColor(Color.white)
                        .background(AngularGradient(gradient: Gradient(colors: [Color(red: 0.26, green: 0.632, blue: 0.981),Color(red: 0.278, green: 0.701, blue: 0.98), Color(red: 0.278, green: 0.701, blue: 0.98), Color(red: 0.26, green: 0.632, blue: 0.981)]), center: .center).opacity(0.92)).clipShape(Circle())            }

            }.padding(.trailing, 20.0)
        }.background(editToggle ? Color.black.ignoresSafeArea().opacity(0.5): Color.black.ignoresSafeArea().opacity(0)).animation(.easeInOut,value: editToggle)
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
		AnimeDetailsScreen(anime: AnimeTitleModel(id: 666, name: "Hunter X Hunter", description: "Hunter x Hunter is set in a world where Hunters exist to perform all manner of dangerous tasks like capturing criminals and bravely searching for lost treasures in uncharted territories. Twelve-year-old Gon Freecss is determined to become the best Hunter possible in hopes of finding his father, who was a Hunter himself and had long ago abandoned his young son. However, Gon soon realizes the path to achieving his goals is far more challenging than he could have ever imagined. Along the way to becoming an official Hunter, Gon befriends the lively doctor-in-training Leorio, vengeful Kurapika, and rebellious ex-assassin Killua. To attain their own goals and desires, together the four of them take the Hunter Exam, notorious for its low success rate and high probability of death. Throughout their journey, Gon and his friends embark on an adventure that puts them through many hardships and struggles. They will meet a plethora of monsters, creatures, and characters—all while learning what being a Hunter truly means.", imageUrl: "https://cdn.myanimelist.net/images/anime/11/33657l.jpg", rank: 44, popularity: 22, avgRating: 6.78))
    }
}
