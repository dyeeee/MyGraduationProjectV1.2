//
//  MonthView.swift
//  CalSwiftUI
//
//  Created by Adam Kes on 11/12/19.
//  Copyright © 2019 KesDev. All rights reserved.
//

import SwiftUI

@available(OSX 10.15, *)
@available(iOS 13.0, *)
struct MonthView: View {
    //    @Environment(\.managedObjectContext) private var viewContext
    //var DayContentItemList: FetchedResults<DayContentItem>
    @ObservedObject var dayContentViewModel:DayContentViewModel
    @State var isCurrentMonth:Bool = false
    
    var month: Month
    
    var body: some View {
        VStack(alignment:.center,spacing:3) {
            HStack {
                Spacer()
                Button(action: {
                    self.dayContentViewModel.getAllDayContentItems()
                }, label: {
                    Image(systemName: "arrow.triangle.2.circlepath")
                }).buttonStyle(BorderlessButtonStyle())
                
                
                Text("\(month.monthNameYear)")
                    .font(.custom("Baskerville", size: CGFloat(20),relativeTo: .title))
                //                    .onTapGesture {
                //                        self.dayContentViewModel.getAllItems(monthString: month.monthString)
                //                }
                
            }
            //.padding(.trailing,20)
            
            .foregroundColor(.black)
            
            VStack {
                
                GridStack(rows: month.monthRows, columns: month.monthDays.count) {
                    row, col in
                    if self.month.monthDays[col+1]![row].dayDate == Date(timeIntervalSince1970: 0)
                    {
                        Text("").frame(width: 32, height: 32)
                    }
                    else if
                        (self.dayContentViewModel.dateStringList.contains(
                         self.month.monthDays[col+1]![row].dateString))
//                        (self.dayContentViewModel.haveContent(dateString: self.month.monthDays[col+1]![row].dateString,isCurrentMonth: self.isCurrentMonth))
                    { // 如果这一天是有coredata保存的内容的，显示打卡状态
                        DayCellView(day: self.month.monthDays[col+1]![row],done:true)
                        //                            .onTapGesture(perform: {
                        //                                print(self.dayContentViewModel.showContent(dateString: self.month.monthDays[col+1]![row].dateString))
                        //                            })
                    }
                    else {
                        DayCellView(day: self.month.monthDays[col+1]![row])
                        //                            .onTapGesture{
                        //                                print("ok")
                        //                            }
                    }
                    
                }
            }
        }
        //        .onAppear(perform: {
        //            self.dayContentViewModel.getAllItems()
        //        })
        
        
    }
    
    
    
}
@available(OSX 10.15, *)
@available(iOS 13.0, *)
struct MonthView_Previews: PreviewProvider {
    static var previews: some View {
        MonthView(dayContentViewModel: DayContentViewModel(), month: Month(startDate: Date(), selectableDays: true))
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
