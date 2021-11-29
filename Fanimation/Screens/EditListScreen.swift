//
//  EditListScreen.swift
//  Fanimation
//
//  Created by Paola Jose on 11/26/21.
//

import SwiftUI

struct EditListScreen: View {
    var editToggle: Binding<Bool>
    @State var statusList:Int
    @State var isFavorited:Bool
    @State var isList:Int
    @State var isRemoved:Bool = false
    @State var scoreButton: Int
    @State var progressButton: Int
    let animeTitle:String
    let animeId:Int
    var currSettings: [Any]
    
    //TODO: Create a struct for the settings
    init(editToggle: Binding<Bool>, animeTitle: String, animeId: Int, statusList:Int? = 1, isFavorited:Bool? = false, scoreButton:Int? = -1, progressButton:Int? = 0, isList:Int? = 0) {
        self.animeTitle = animeTitle
        self.animeId = animeId
        self.editToggle = editToggle
        self.statusList = statusList!
        self.isFavorited = isFavorited!
        self.scoreButton = scoreButton!
        self.progressButton = progressButton!
        self.isList = isList!
        currSettings = [statusList, progressButton, scoreButton, isList, isFavorited]
        
    }
    
        var body: some View {
            VStack {
                Group {
                    HStack(alignment: .top ){
                    Button(action: {
                        editToggle.wrappedValue.toggle()
                            }) {
                                RoundedRectangle(cornerRadius: 5.0)
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(Color(hue: 0.0, saturation: 0.40, brightness: 1.00))
                            }
                            .overlay(Image(systemName: "xmark")
                                        .font(.system(size: 10))
                                        .foregroundColor(Color(red: 0.907, green: 0.344, blue: 0.344, opacity: 1.0))
                                        .padding())
                            
                            .foregroundColor(Color(hue: 0, saturation: 0.78, brightness: 0.98)).shadow(color: Color(hue: 0, saturation: 0.91, brightness: 0.88), radius: 0.2)
                                    Spacer()
                        
                    Button(action: {
                            /*
                             if isRemoved & (statusList == currSettings[0])  {
                                //RemoveAnime(animeId, statusList)
                             }
                             else if(statusList != currSettings[0]) {
                                //Remove Anime(animeId, statusList)
                                //Add Anime(animeId, animeTitle, statusList, progrssButton, scoreButton)
                                
                             }
                             else if(statusList == currSettings[0] & isList == currSettings[0]) {
                                //Update Anime(animeId,animeTitle, statusList, progrssButton, scoreButton)
                             }
                             else if statusList == currSettings[0] {
                                //Add Anime(animeId, animeTitle, statusList, progrssButton, scoreButton)
                             }
                             
                             //Added to favorites
                             if(isFavorite != currSettings[4] {
                                //UpdateFavorites(animeId, animeTitle)
                             }
                             
                             //Refresh Lists. 
                             We will need deletion, original list, new list, and favorites
                             If user deleted list but list did not change
                                Just delete
                             If user deleted list and list did change
                                Delete
                                Add to new list
                            
                                If user did not delete
                                If user did not delete but change list
                                    Delete
                                    Add to new list
                                If user did not change list but changed score
                                    Change score
                                If user did not change list but changed progress
                                    Change progress
                                
                                If user added to favorites
                                    Add to favories
                                If user remove from favorites
                                    Remove from favorites
                             */
                        editToggle.wrappedValue.toggle()
                            }) {
                                RoundedRectangle(cornerRadius: 5.0)
                                    .frame(width: 65, height: 35)
                                    .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.86, green: 0.973, blue: 0.949)/*@END_MENU_TOKEN@*/)
                            }
                        .overlay(Text("Save")
                                    .font(Font.custom("Poppins-Medium", size: 15))
                                    .foregroundColor(Color(red: 0.338, green: 0.878, blue: 0.723))
                                    .padding(.vertical, 5.0)
                                    .padding(.horizontal, 12.0))
                        .overlay(RoundedRectangle(cornerRadius: 5.0)
                                    .stroke(lineWidth: 0.5))
                        .foregroundColor(/*@START_MENU_TOKEN@*/Color(red: 0.86, green: 0.973, blue: 0.949)/*@END_MENU_TOKEN@*/)
                        .shadow(color: Color(red: 0.338, green: 0.878, blue: 0.723), radius: 0.2)
                    
                }
                HStack {
                    Text("Status")
                        .font(Font.custom("Poppins-Black", size: 18))
                    Spacer()
                }
                HStack() {
                    Button("Watching", action: {                   statusList = 1 }).buttonStyle(statusList == 1 ? StatusButton(foreColor: Color.white, backColor: Color("blue1")) : StatusButton(foreColor: Color("blue2"), backColor: Color.white))
                    
                    Spacer()
                    Button("Plan to Watch", action: {
                        statusList = 2
                    }).buttonStyle(statusList == 2 ? StatusButton(foreColor: Color.white, backColor: Color("blue1")) : StatusButton(foreColor: Color("blue2"), backColor: Color.white))
                    
                    Spacer()
                    Button("Completed", action: {
                        statusList = 3
                    }).buttonStyle(statusList == 3 ? StatusButton(foreColor: Color.white, backColor: Color("blue1")) : StatusButton(foreColor: Color("blue2"), backColor: Color.white))
                }
            }
                ListSettings(button: statusList, scoreButton: $scoreButton, progressButton: $progressButton)
                
                HStack() {
                    Button(action: {
                        isList = 0
                    }) {
                        Image(systemName: "trash").foregroundColor(isList == statusList ? Color(red: 0.907, green: 0.344, blue: 0.344, opacity: 1.0) : Color.gray)
                        Text("Remove from list").font(Font.custom("Poppins-bold", size: 10)).foregroundColor(isList == statusList ? Color(red: 0.907, green: 0.344, blue: 0.344, opacity: 1.0): Color.gray)
                        
                    }.disabled(isList != statusList)
                    Spacer()
                    Button(action: {
                        isFavorited.toggle()
                    }) {
                        if isFavorited {
                            Image(systemName: "heart.fill").foregroundColor(Color(red: 0.907, green: 0.344, blue: 0.344, opacity: 1.0))
                            Text("Remove from favorites").font(Font.custom("Poppins-bold", size: 10)).foregroundColor(Color(red: 0.907, green: 0.344, blue: 0.344, opacity: 1.0))
                        }
                        else {
                            Image(systemName: "heart").foregroundColor(Color(red: 0.907, green: 0.344, blue: 0.344, opacity: 1.0))
                            Text("Add to favorites").font(Font.custom("Poppins-bold", size: 10)).foregroundColor(Color(red: 0.907, green: 0.344, blue: 0.344, opacity: 1.0))
                        }

                    }
                    
                }
                
            }.padding(10).frame(width: 350, height: 400).overlay(RoundedRectangle(cornerRadius: 10.0)
                                                                                    .stroke(lineWidth: 0.2)
                                                                    .shadow(color: Color("blue1"),radius: 2))
                .background(RoundedRectangle(cornerRadius: 10.0)
                                .foregroundColor(Color.white))
        }
}


struct StatusButton: ButtonStyle {
    
    var foreColor:Color
    var backColor: Color

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(Font.custom("Poppins-Medium", size: 15))
            .foregroundColor(foreColor)
            .padding(.vertical, 5.0)
            .padding(.horizontal, 8.0)
            .overlay(RoundedRectangle(cornerRadius: 5.0)
                        .stroke(lineWidth: 0.1)
                        .foregroundColor(Color.white)
                        .shadow(color: Color("blue1"),radius: 2))
            .background(RoundedRectangle(cornerRadius: 5.0)
                        .foregroundColor(backColor)
                        .shadow(color: Color("blue3"),radius: 2))
            .animation(.default)
    
    }

}

struct NumButton: ButtonStyle {
    var foreColor:Color
    var backColor: Color
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(foreColor)
            .font(Font.custom("Poppins-Medium", size: 18))
            .frame(width: 18, height: 15)
            .padding(10)
            .overlay(RoundedRectangle(cornerRadius: 5)
                            .stroke(lineWidth: 0.5)
                            .foregroundColor(backColor)
                            .shadow(color: backColor,radius: 2))
            .background(RoundedRectangle(cornerRadius: 5.0)
                            .foregroundColor(backColor))
            .animation(.default)
    }
    
    
}
struct ListSettings: View {
    let listPressed: Int
    var scoreButton: Binding<Int>
    var progressButton: Binding<Int>
    init(button: Int, scoreButton: Binding<Int>, progressButton: Binding<Int>) {
        listPressed = button
        self.scoreButton = scoreButton
        self.progressButton = progressButton
    }
    
    var body: some View {
            VStack {
                if listPressed == 1 {
                    HStack {
                        Text("Progress")
                            .font(Font.custom("Poppins-Black", size: 18))
                        Spacer()
                    }
                    ScrollView(.horizontal, showsIndicators: false) {
                    HStack() {
                        Spacer().padding(.horizontal, 40.0)
                        ForEach((0..<11), id: \.self) { number in
                            Button("\(number)", action: {
                                progressButton.wrappedValue = number
                            }).buttonStyle(progressButton.wrappedValue == number ?  NumButton(foreColor: Color.white, backColor: Color("blue2")) : NumButton(foreColor: Color("blue2"), backColor: Color.white)).padding(5)
                            
                        }
                        
                        }
                    }
                }
                if listPressed != 2 {
                    HStack {
                        
                        Text("Score")
                            .font(Font.custom("Poppins-Black", size: 18))
                        Spacer()
                    }
                    ScrollView(.horizontal, showsIndicators: false) {
                    HStack() {
                        Spacer().padding(.horizontal, 40.0)
                        ForEach((-1..<11), id: \.self) { number in
                            Button(number == -1 ? "-" : "\(number)", action: {
                                scoreButton.wrappedValue = number
                            }).buttonStyle(scoreButton.wrappedValue == number ?  NumButton(foreColor: Color.white, backColor: Color("blue2")) : NumButton(foreColor: Color("blue2"), backColor: Color.white)).padding(5)
                            
                    }
                        
                    }
                }
            }
            Spacer()
        }
    
    }
}

