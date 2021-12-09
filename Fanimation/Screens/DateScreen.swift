/*
 Group 5: Fanimation
 Member 1: Paola Jose Lora
 Member 2: Recleph Mere
 Member 3: Ahmed Elshetany
 */

//
//  DateScreen.swift
//  Fanimation
//
//  Created by Paola Jose on 12/5/21.
//

import SwiftUI

struct DateScreen: View {
    let dateFormatter = DateFormatter()
    
    @State private var date = Date()
    var currDate: Binding<String>
    var datePick: Binding<Int>
    var limitDate: String
    init(datePick: Binding<Int>, limitDate:String? = "", currDate:Binding<String>) {
        self.datePick = datePick
        self.currDate = currDate
        self.limitDate = limitDate!
    }
    
    var body: some View {
            VStack() {
                    Text("Select Date").font(Font.custom("Poppins-Black", size: 18)).padding(5)
                    HStack() {
                        if limitDate == "" {
                            DatePicker(
                                "",
                                selection: $date,
                                displayedComponents: [.date]
                                
                            ).frame(width: 60, height: 40, alignment: .center)
                                .labelsHidden()
                        } else {
                            
                            if datePick.wrappedValue == 1 {
                                DatePicker(
                                    "",
                                    selection: $date,
                                    in: calendarStart(limitDate: limitDate),
                                    displayedComponents: [.date]
                                    
                                ).frame(width: 60, height: 40, alignment: .center)
                                    .labelsHidden()
                            }
                            else {
                                DatePicker(
                                    "",
                                    selection: $date,
                                    in: calendarEnd(limitDate: limitDate),
                                    displayedComponents: [.date]
                                    
                                ).frame(width: 60, height: 40, alignment: .center)
                                    .labelsHidden()
                            }
                        }
                        
                    }.datePickerStyle(CompactDatePickerStyle()).padding(5)
                
                    Button("OK") {
                        dateFormatter.dateFormat = "MM/dd/yyyy"
                        
                        currDate.wrappedValue = dateFormatter.string(from: date)
                        datePick.wrappedValue = 0
                    }.buttonStyle(StatusButton(foreColor: Color("blue2"), backColor: Color.white))
                }.frame(width: 200, height: 150).background(RoundedRectangle(cornerRadius: 10.0).foregroundColor(Color.white)
                                                            )
        }
}

func calendarStart(limitDate: String) -> (PartialRangeThrough<Date>) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/yyyy"
    let date:Date = dateFormatter.date(from: limitDate)!
    return  ...date
}

func calendarEnd(limitDate: String) -> (PartialRangeFrom<Date>) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/yyyy"
    let date:Date = dateFormatter.date(from: limitDate)!
    return  date...
}
