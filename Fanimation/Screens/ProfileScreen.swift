//
//  ProfileScreen.swift
//  Fanimation
//
//  Created by Ahmed  Elshetany  on 11/11/21.
//  Last Modified by Recleph Mere on 12/04/21

import SwiftUI
import Firebase
import FirebaseStorage
struct ProfileScreen: View {
    let anime = Anime()
    let popularity_url = URL(string:  "https://api.jikan.moe/v3/top/anime/1/bypopularity")
    @State var watchingCount: Int = 13
    @State var completedCount: Int = 21
    @State var plantoWatchCount: Int = 15
    @State var totalCount: Int = 0
    
    @State var watchingWidth: Int = 0
    @State var completedWidth: Int = 0
    
    @State var favoriteList = [Anime]()
    
    func calculateProgress() {
        totalCount = watchingCount + completedCount + plantoWatchCount
        watchingWidth = Int(((Double(watchingCount) / Double(totalCount)) * 200.0).rounded(.down))
        completedWidth = Int(((Double(completedCount) / Double(totalCount)) * 200.0).rounded(.down))
    }
	var body: some View {
        NavigationView {
            ScrollView {
                HStack {
                    Spacer()
                    VStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25, style: .continuous).fill(Color.blue).frame(height: 140)
                                .padding(EdgeInsets(top: 150, leading: 20, bottom: 0, trailing: 20)).shadow(color: Color.black.opacity(0.7), radius: 4, x: 1, y: 1)
                            HStack {
                                AsyncImage(
                                    url: URL(string: anime.image_url)!,
                                    placeholder: { LoadingCard() },
                                    image: {
                                        Image(uiImage: $0)
                                            .resizable()
                                    }
                                ).frame(width: 130, height: 200).cornerRadius(15).padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 0)).shadow(radius: 10)
                                //Spacer()
                                VStack (alignment: .leading){
                                    Text("Username").font(Font.custom("Poppins-SemiBold", size: 18))
                                    Text("Joined 2021").font(Font.custom("Poppins-Regular", size: 14))
                                }.padding(EdgeInsets(top: 120, leading: 10, bottom: 0, trailing: 0))
                                Spacer()
                            }
                        }
                        ZStack (alignment: .leading){
                            RoundedRectangle(cornerRadius: 25, style: .continuous).fill(Color.blue).frame(height: 250)
                                .padding(EdgeInsets(top: 40, leading: 20, bottom: 0, trailing: 20)).shadow(color: Color.black.opacity(0.7), radius: 4, x: 1, y: 1)
                            VStack (alignment: .leading){
                                Text("Anime stats").padding(EdgeInsets(top: 40, leading: 40, bottom: 0, trailing: 20)).font(Font.custom("Poppins-SemiBold", size: 20))
                                HStack {
                                    VStack (alignment: .leading) {
                                        Circle().fill(Color.purple).frame(width: 12, height: 12).padding(EdgeInsets(top: 5, leading: 40, bottom: 0, trailing: 0))
                                        Circle().fill(Color.green).frame(width: 12, height: 12).padding(EdgeInsets(top: 15, leading: 40, bottom: 0, trailing: 0))
                                        Circle().fill(Color.gray).frame(width: 12, height: 12).padding(EdgeInsets(top: 15, leading: 40, bottom: 0, trailing: 0))
                                    }
                                    VStack (alignment: .leading){
                                        Text("Watching").padding(EdgeInsets(top: 5, leading: 10, bottom: 0, trailing: 0)).font(Font.custom("Poppins-SemiBold", size: 12))
                                    
                                        Text("Completed").padding(EdgeInsets(top: 5, leading: 10, bottom: 0, trailing: 0)).font(Font.custom("Poppins-SemiBold", size: 12))
                                    
                                        Text("Plan to Watch").padding(EdgeInsets(top: 5, leading: 10, bottom: 0, trailing: 0)).font(Font.custom("Poppins-SemiBold", size: 12))
                                    }
                                    VStack (alignment: .trailing){
                                        Text("\(watchingCount)").padding(EdgeInsets(top: 5, leading: 40, bottom: 0, trailing: 0)).font(Font.custom("Poppins-SemiBold", size: 12))
                                    
                                        Text("\(completedCount)").padding(EdgeInsets(top: 5, leading: 40, bottom: 0, trailing: 0)).font(Font.custom("Poppins-SemiBold", size: 12))
                                    
                                        Text("\(plantoWatchCount)").padding(EdgeInsets(top: 5, leading: 40, bottom: 0, trailing: 0)).font(Font.custom("Poppins-SemiBold", size: 12))
                                    }
                                }
                                HStack {
                                    Spacer()
                                    ZStack (alignment: .leading){
                                        // Plan to Watch percentage
                                        RoundedRectangle(cornerRadius: 25, style: .continuous).foregroundColor(Color.gray.opacity(0.9)).frame(width: 200, height: 10, alignment: .center).padding(EdgeInsets(top: 20, leading: 40, bottom: 0, trailing: 0))
                                        // Completed Percentage
                                        RoundedRectangle(cornerRadius: 25, style: .continuous).foregroundColor(Color.green).frame(width: CGFloat(watchingWidth) + CGFloat(completedWidth), height: 10, alignment: .center).padding(EdgeInsets(top: 20, leading: 40, bottom: 0, trailing: 0))
                                        // Watching percentage
                                        RoundedRectangle(cornerRadius: 25, style: .continuous).foregroundColor(Color.purple).frame(width: CGFloat( watchingWidth), height: 10, alignment: .center).padding(EdgeInsets(top: 20, leading: 40, bottom: 0, trailing: 0))
                                    
                                    }
                                    Spacer()
                                }
                            
                            }
                        }
                        // TODO: Update AnimeListView to pull from DB when URL is null or title is 'Favourites'
                        AnimeListView(url: popularity_url!, title: "Favourites")
                        
                    }
                    Spacer()
                }
            }.onAppear(perform: calculateProgress).toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        print("Saved tapped")
                    } label: {
                        Image(systemName: "bell")
                    }
                    
                    Button {
                        print("Settings tapped")
                    } label : {
                        Image(systemName: "gearshape")
                    }
                }
            }
            
        }
    }
}

struct ProfileScreen_Previews: PreviewProvider {
	static var previews: some View {
		ProfileScreen()
	}
}


//Here's a link for reference:https://firebase.google.com/docs/storage/ios/upload-files
func uploadProfile(imageData:URL) {
    let user = Auth.auth().currentUser
    // Get a reference to the storage service using the default Firebase App
    let storage = Storage.storage()

    // Create a storage reference from our storage service
    let storageRef = storage.reference().child("Users/\(user?.uid)")
    
    storageRef.putFile(from: imageData, metadata: nil) { storageData, error in
        if (error != nil) {
            print(error?.localizedDescription)
        }
        else {
            storageRef.downloadURL { url, error in
                if error != nil {
                    return
                }
                let urlString = url?.absoluteString
            }
        }
    }
    
}

func updateUserProfile(photoURL:URL) {
    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
    changeRequest?.photoURL = photoURL
    changeRequest?.commitChanges { error in
        if error != nil {
            print("\(error?.localizedDescription)")
        }
        else {
            print("Update successful!")
        }
    }
}
