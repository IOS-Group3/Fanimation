//
//  EditListScreen.swift
//  Fanimation
//
//  Created by Paola Jose on 11/26/21.
//

import SwiftUI

struct EditListScreen: View {
    var editToggle: Binding<Bool>
    @State var switchDate:Int = 0 //Start
    var isDate:Bool = false
    var isDateStart:Bool =  false
    @State var dateStart:String
    var isDateEnd:Bool = false
    @State var dateEnd:String
    @State var statusList:Int
    @State var isFavorited:Bool
    @State var isList:Int
    @State var isRemoved:Bool = false
    @State var scoreButton: Int
    @State var progressButton: Int
    let animeTitle:String
    let animeId:Int
    var currSettings: Binding<Settings>
    
    init(editToggle: Binding<Bool>, currSettings:Binding<Settings>) {
        self.animeTitle = currSettings.wrappedValue.animeTitle
        self.animeId = currSettings.wrappedValue.animeId
        self.editToggle = editToggle
        self.statusList = currSettings.wrappedValue.statusList
        self.isFavorited = currSettings.wrappedValue.isFavorited
        self.scoreButton = currSettings.wrappedValue.scoreButton
        self.progressButton = currSettings.wrappedValue.progressButton
        self.isList = currSettings.wrappedValue.isList
        self.dateStart = currSettings.wrappedValue.startDate
        self.dateEnd = currSettings.wrappedValue.endDate
        self.currSettings = currSettings
        
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
                        let firebase = FirebaseRequests()
                            //List has only been removed
                             if isRemoved && (statusList == currSettings.wrappedValue.statusList)  {
                                 firebase.DeleteAnime(animeId: animeId, list: statusList)
                             }
                            //Anime switched to another list
                            else if(statusList != currSettings.wrappedValue.statusList) {
                                firebase.DeleteAnime(animeId: animeId, list: currSettings.wrappedValue.statusList)
                                //Watching List
                                if statusList == 1 {
                                    firebase.AddToWatching(watching: WatchingList(animeId: animeId, animeTitle: animeTitle, startDate: dateStart, progress: progressButton, score: scoreButton))
                                }
                                //Planning List
                                else if statusList == 2  {
                                    firebase.AddToPlan(planning: PendingList(animeId: animeId, animeTitle: animeTitle))
                                }
                                //Completed List
                                else if statusList == 3 {
                                    firebase.AddToCompleted(completed: CompletedList(animeId: animeId, animeTitle: animeTitle, startDate: dateStart, endDate: dateEnd, score: scoreButton))
                                }
                             }
                        //Add anime for the first time
                        else if statusList == currSettings.wrappedValue.statusList{
                            //Watching List
                            if statusList == 1 {
                                firebase.AddToWatching(watching: WatchingList(animeId: animeId, animeTitle: animeTitle, startDate: dateStart, progress: progressButton, score: scoreButton))
                            }
                            //Planning List
                            else if statusList == 2  {
                                firebase.AddToPlan(planning: PendingList(animeId: animeId, animeTitle: animeTitle))
                            }
                            //Completed List
                            else if statusList == 3 {
                                firebase.AddToCompleted(completed: CompletedList(animeId: animeId, animeTitle: animeTitle, startDate: dateStart, endDate: dateEnd, score: scoreButton))
                            }
                        }
                             
                        //Added/Removed to favorites
                        if isFavorited != currSettings.wrappedValue.isFavorited {
                            firebase.UpdateFavorites(add: isFavorited, favorites: FavoriteList(animeId: animeId, animeTitle: animeTitle, startDate: dateStart, endDate: dateEnd, score: scoreButton))
                             }
                        else if isFavorited { //Favorites but something changed
                            if dateStart != currSettings.wrappedValue.startDate || dateEnd != currSettings.wrappedValue.endDate || scoreButton != currSettings.wrappedValue.scoreButton {
                                firebase.UpdateFavorites(add: isFavorited, favorites: FavoriteList(animeId: animeId, animeTitle: animeTitle, startDate: dateStart, endDate: dateEnd, score: scoreButton))
                            }
                                
                        }
                             
                        //Update current lists
                        if isRemoved && statusList == currSettings.wrappedValue.statusList {
                            currSettings.wrappedValue = Settings(animeId: animeId, animeTitle: animeTitle, statusList: statusList, isFavorited: isFavorited, scoreButton: scoreButton, progressButton: progressButton)
                        }
                        else {
                            currSettings.wrappedValue = Settings(animeId: animeId, animeTitle: animeTitle)
                        }
                        
                        
                        //Exit
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
                ListSettings(button: statusList, scoreButton: $scoreButton, progressButton: $progressButton, datePick: $switchDate, dateStart: $dateStart, dateEnd: $dateEnd)
                //Optional
                
                //startDate(isStartDate:isDateStart)
                Spacer()
                HStack() {
                    Button(action: {
                        isList = -1
                        isRemoved.toggle()
                        isFavorited = false
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
                    
                }.disabled(isRemoved && statusList == currSettings.wrappedValue.statusList)
                
            }.padding(10).frame(width: 350, height: 425).overlay(RoundedRectangle(cornerRadius: 10.0)
                                                                                    .stroke(lineWidth: 0.2)
                                                                    .shadow(color: Color("blue1"),radius: 2)).overlay(dateSelect(datePick: $switchDate, startDate: $dateStart, endDate: $dateEnd))
                .background(RoundedRectangle(cornerRadius: 10.0)
                                .foregroundColor(Color.white))
                
        }
}
struct dateSelect: View {
    var datePick: Binding<Int>
    var startDate:Binding<String>
    var endDate:Binding<String>
    
    init(datePick: Binding<Int>, startDate:Binding<String>, endDate:Binding<String>) {
        self.datePick = datePick
        self.startDate = startDate
        self.endDate = endDate
    }
    
    var body: some View {
        VStack() {
            Spacer()
            HStack {
                Spacer()
                if datePick.wrappedValue != 0 {
                    if datePick.wrappedValue == 1 {
                        DateScreen(datePick: datePick, limitDate: endDate.wrappedValue, currDate: startDate).animation(.easeInOut)
                    }
                    else {
                        DateScreen(datePick: datePick, limitDate: startDate.wrappedValue, currDate: endDate).animation(.easeInOut)
                    }
                    
                }
                Spacer()
            }
            Spacer()
        }
        .background(RoundedRectangle(cornerRadius: 10.0)
                        .fill(datePick.wrappedValue != 0 ? Color.black.opacity(0.5): Color.black.opacity(0.0))).animation(.easeInOut,value: datePick.wrappedValue != 0)
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
    var dateStart:Binding<String>
    var dateEnd:Binding<String>
    @State var datePick: Binding<Int>
    init(button: Int, scoreButton: Binding<Int>, progressButton: Binding<Int>, datePick: Binding<Int>, dateStart:Binding<String>, dateEnd:Binding<String>) {
        listPressed = button
        self.scoreButton = scoreButton
        self.progressButton = progressButton
        self.datePick = datePick
        self.dateStart = dateStart
        self.dateEnd = dateEnd
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
                if listPressed != 2 {
                    HStack {
                        if dateStart.wrappedValue  != "" {
                            Button(action: {
                                datePick.wrappedValue = 0
                                dateStart.wrappedValue = ""
                            }){
                                Image(systemName: "minus").foregroundColor(Color("blue1")).font(.system(size: 15))
                                Text("Remove start date:").font(Font.custom("Poppins-Black", size: 18)).foregroundColor(Color.black)
                                Text("\(dateStart.wrappedValue)").font(Font.custom("Poppins-Medium", size: 15)).foregroundColor(Color("blue2"))
                            }
                        }
                        else {
                            Button(action: {
                                datePick.wrappedValue = 1
                                
                            }){
                                Image(systemName: "plus").foregroundColor(Color("blue1")).font(.system(size: 18))
                                Text("Add start date").font(Font.custom("Poppins-Black", size: 18)).foregroundColor(Color.black)
                                
                            }
                        }
                        Spacer()
                    }
                    if(listPressed == 3) {
                        HStack {
                            if dateEnd.wrappedValue  != "" {
                                Button(action: {
                                    datePick.wrappedValue = 0
                                    dateEnd.wrappedValue = ""
                                }){
                                    Image(systemName: "minus").foregroundColor(Color("blue1")).font(.system(size: 15))
                                    Text("Remove end date:").font(Font.custom("Poppins-Black", size: 18)).foregroundColor(Color.black)
                                    Text("\(dateEnd.wrappedValue)").font(Font.custom("Poppins-Medium", size: 15)).foregroundColor(Color("blue2"))
                                }
                            }
                            else {
                                Button(action: {
                                    datePick.wrappedValue = 2
                                    
                                }){
                                    Image(systemName: "plus").foregroundColor(Color("blue1")).font(.system(size: 18))
                                    Text("Add end date").font(Font.custom("Poppins-Black", size: 18)).foregroundColor(Color.black)
                                }
                            }
                            Spacer()
                        }
                    }
                    Spacer()
                }
        }
    
    }
}

