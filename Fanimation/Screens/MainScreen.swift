//
//  MainScreen.swift
//  Fanimation
//
//  Created by Paola Jose on 11/13/21.
//

import SwiftUI
//import Firebase

struct MainScreen: View {
	init() {
		UITabBar.appearance().unselectedItemTintColor = UIColor.init(named: "light")
		UITabBar.appearance().backgroundColor = .gray.withAlphaComponent(0.2)
	}
	
	@State var selectedTabIndex = 0
    
	private let tabBarImageNames = ["house.fill", "square.grid.2x2", "person.fill"]
	private let tabBarText = ["Home", "My List", "Profile"]
	var body: some View {
		GeometryReader { proxy in
			ZStack {
				VStack {
					switch selectedTabIndex {
						case 0:
							HomeScreen()
						case 1:
							MyListScreen()
						default:
							ProfileScreen()
					}
					Spacer()
					Divider()
						.frame(height: 3.0)
						.accentColor(.gray)
					HStack {
						ForEach(0..<tabBarImageNames.count, id: \.self) { num in
							HStack {
								Button(action: {
									self.selectedTabIndex = num
								}, label: {
									Spacer()
									VStack {
										Image(systemName: tabBarImageNames[num])
											.foregroundColor(selectedTabIndex == num ? .init("blue1") : .init("blue3"))
											.frame(width: 50, height: 50)
											.background(selectedTabIndex == num ? Color(red: 156/255, green: 197/255, blue:250/255) : Color.white.opacity(1))
											.cornerRadius(20)
										
										Text(tabBarText[num])
											.foregroundColor(selectedTabIndex == num ? .init("blue1") : .init("blue3"))
									}
									
									
									Spacer()
								})
							}.font(.system(size: 17, weight: .semibold))
						}
					}
					.padding(.bottom, proxy.safeAreaInsets.bottom)
				}.edgesIgnoringSafeArea(.bottom)
			}
			
		}
		
	}
}

struct MainScreen_Previews: PreviewProvider {
	static var previews: some View {
		MainScreen()
	}
}
