/*
 Group 5: Fanimation
 Member 1: Paola Jose Lora
 Member 2: Recleph Mere
 Member 3: Ahmed Elshetany
 */


//
//  HelloUserView.swift
//  Fanimation
//
//  Created by Recleph on 11/23/21.
//

import SwiftUI

struct HelloUserView: View {
    var user: UserModel
    
    var body: some View {
        VStack {
            Spacer()
            HStack(alignment: .top) {
                AsyncImage(
                    url: URL(string: user.profilePicUrl)!,
                    placeholder: { LoadingCard()},
                    image: {Image(uiImage: $0).resizable()}
                    
                ).frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .shadow(radius: 7)
                
                
                VStack(alignment: .leading) {
                    Spacer()
                    Text("Welcome Back")
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                    Spacer()
                    Text(user.username)
                        .font(.title3)
                        .fontWeight(.heavy)
                    Spacer()
                }
                Spacer()
            }
            Spacer()
        }.padding(.leading)
            .padding(.top, 50)
            .background(Image("waveWallpaper3")
                            .resizable()
                            .aspectRatio(1, contentMode: .fill)
                            .frame(width:UIScreen.main.bounds.width)
                            .padding(.top, 200)
            )
            
    }
}
