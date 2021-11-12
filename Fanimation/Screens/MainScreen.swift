//
//  MainScreen.swift
//  Fanimation
//
//  Created by Ahmed  Elshetany  on 11/11/21.
//

import SwiftUI

struct MainScreen: View {
	var body: some View {
		TabView{
			HomeScreen().tabItem{Text("Home")}
			MyListScreen().tabItem{Text("My List")}
			ProfileScreen().tabItem{Text("Profile")}
		}
	}
}

struct MainScreen_Previews: PreviewProvider {
	static var previews: some View {
		MainScreen()
	}
}
