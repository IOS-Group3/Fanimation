//
//  HomeScreen.swift
//  Fanimation
//
//  Created by Ahmed  Elshetany  on 11/11/21.
//  Last Modified: 11/19/21 by Recleph Mere
//

import SwiftUI

struct HomeScreen: View {
    var body: some View {
        NavigationView {
            VStack {
                // Add top Card UI HERE
                CurrentlyAiringView()
                PopularAnimeView()
                
            }.navigationTitle("Discover")
        }
	}
}

struct HomeScreen_Previews: PreviewProvider {
	static var previews: some View {
		HomeScreen()
	}
}


