//
//  ContentView.swift
//  Fanimation
//
//  Created by Ahmed  Elshetany  on 10/27/21.
//

import SwiftUI

struct WelcomeScreen: View {
	var content:[[String:String]] =
	[
		[
			"title" : "Welcome",
			"detail" : "To the world's largest anime & manga database and community.",
			"image1" :  "welcome2",
			"image2" : "welcome3",
			"image3" : "welcome4"
		],[
			"title" : "Stay up to Date",
			"detail" : "Discover the latest from Japan.",
			"image1" :  "welcome6",
			"image2" : "welcome8",
			"image3" : "welcome5"
		],[
			"title" : "Create your list",
			"detail" : "Use your list to organize and track what titles you've completed, your current progress, what you plan to watch or read and so much more.",
			"image1" :  "welcome10",
			"image2" : "welcome11",
			"image3" : "welcome13"
		]
	]
	@State var index = 0;
	var body: some View {
		ZStack {
			Color("blue1")
				.ignoresSafeArea()
			VStack{ // main Vstack
				Text("Fanimation")
				VStack{ // For the grid
					HStack{
						Image(content[index]["image1"] ?? "welcome1")
							.resizable()
							.aspectRatio(contentMode: .fill)
							.frame(width: 150, height: 300)
							.cornerRadius(15)
						
						Image(content[index]["image2"] ?? "welcome1")
							.resizable()
							.aspectRatio(contentMode: .fill)
							.frame(width: 150, height: 300)
							.cornerRadius(15)
					}
					Image(content[index]["image3"] ?? "welcome1")
						.resizable()
						.aspectRatio(contentMode: .fill)
						.frame(width: 300, height: 200)
						.cornerRadius(20)
				}
				
				VStack(alignment: .leading, spacing: 5.0) {
					//					Text("Welcome")
					Text(content[index]["title"]!)
						.font(.largeTitle)
						.foregroundColor(Color("dark")).padding()
					Text(content[index]["detail"]!)
						.padding()
					
					HStack {
						ProgressView(value: Double(index) + 1, total: 3)
							.progressViewStyle(LinearProgressViewStyle(tint: Color.red))
							.padding(.horizontal, 50)
						
						Button(action: {
							if index >= content.count {
								
							} else {
								index += 1
							}
						}) {
							Image(systemName: "arrow.right")
						}
					}.padding()
					Spacer()
				}.background(Color.white)
					.cornerRadius(20)
					.ignoresSafeArea()
			}
			
		}
	}
}

struct WelcomeScreen_Previews: PreviewProvider {
	static var previews: some View {
		WelcomeScreen()
	}
}
