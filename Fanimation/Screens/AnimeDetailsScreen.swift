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
	@State var anime: Anime
    var body: some View {
		ScrollView{
            GeometryReader { proxy in
                let height = proxy.size.height
                let width = proxy.size.width
                VStack{
                    AsyncImage(
                        url: URL(string: anime.image_url)!,
                        placeholder: { LoadingCard() },
                        image: {
                            Image(uiImage: $0)
                                .resizable()
                        }
                    ).frame(width: width * 0.50, height: height * 40)
                        .cornerRadius(15)
			
                    Text(anime.title).font(Font.custom("Poppins-Semibold", size: 20))
                    VStack(alignment: .leading) {
                        Text("Description").padding(20).font(Font.custom("Poppins-Semibold", size: 18))
                        Text(anime.synopsis!).multilineTextAlignment(.leading).frame(width: width * 0.80, height: height * 15).truncationMode(.tail).padding(EdgeInsets(top: 0, leading: 30, bottom: 20, trailing: 20)).font(Font.custom("Poppins-Semibold", size: 14))
                    }
                }.padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            }
        }
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
