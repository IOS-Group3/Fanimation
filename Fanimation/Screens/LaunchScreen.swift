//
//  LaunchScreen.swift
//  Fanimation
//
//  Created by Ahmed  Elshetany  on 10/31/21.
//

import SwiftUI
import Firebase
import FirebaseAuth
struct LaunchScreen: View {
	@State var showMainView: Bool = false
	@State var bowAnimation: Bool = false
	@State private var didSeeWelcomeScreen:Bool = UserDefaults.standard.bool(forKey: "didSeeWelcomeScreen")
	
	var body: some View {
		
		Group {
			if showMainView {
				if didSeeWelcomeScreen {
					//Login or Main screen
					NavigationView {
						if Auth.auth().currentUser != nil {
							MainScreen().navigationBarBackButtonHidden(true)
						}
						else {
							LoginScreen()
								.navigationBarBackButtonHidden(true)
						}
						
						
						MainScreen()
						//							LoginScreen()
							.navigationBarBackButtonHidden(true)
					}
					
				} else {
					WelcomeScreen().onAppear{
						UserDefaults.standard.set(true, forKey: "didSeeWelcomeScreen")
					}
				}
			} else {
				ZStack {
					Color("blue1").edgesIgnoringSafeArea(.all)
					GeometryReader { proxy in
						let size = proxy.size
						
						ZStack{
							HStack (alignment: .bottom, spacing : -100){
								Image("playstore")
									.resizable()
									.aspectRatio(contentMode: .fit)
									.frame(width: size.width / 1.9, height: size.width / 1.9)
								Text("animation")
									.font(.title)
									.fontWeight(.heavy)
									.foregroundColor(.white)
									.multilineTextAlignment(.leading)
									.frame(width: size.width / 1.9, height: size.width / 1.9)
							}
						}.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
						Circle()
							.trim(from: 0, to: bowAnimation ? 0.6 : 0)
							.stroke(
								.linearGradient(.init(colors: [
									Color("light"),
									Color("blue3"),
									Color("blue3"),
									Color("blue3"),
									Color("blue2"),
									Color("blue2"),
									Color("blue1"),
									Color("blue1"),
									Color("blue1"),
									
								]),
												startPoint: .leading, endPoint: .trailing),
								style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round)
							)
							.frame(width: size.width / 1.5, height: size.width / 1.5)
							.rotationEffect(.init(degrees: -200))
							.offset(x : 75, y:220)
					}
				}.onAppear {
					DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
						withAnimation(.linear(duration: 1)) {
							bowAnimation.toggle()
							DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
								showMainView.toggle()
							}
						}
					}
				}
			}
		}
	}
	
	struct LaunchScreen_Previews: PreviewProvider {
		
		static var previews: some View {
			let _ = [
				"iPhone 13 Pro Max",
				"iPhone 13",
				"iPhone 13 mini",
				"iPhone SE 2nd gen","iPhone SE",
				"iPhone 11 Pro Max",
				"iPhone 11 Pro",
				"iPhone 11",
				"iPhone 8 Plus",
				"iPhone SE 1st gen",
				"iPhone 4S"
			]
			LaunchScreen()
				.previewDevice(PreviewDevice(rawValue:"iPhone 8 Plus"))
				.previewDisplayName("iPhone 8 Plus")
		}
	}
}
