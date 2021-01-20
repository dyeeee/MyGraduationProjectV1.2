//
//  HistoryCalendarView.swift
//  MyGraduationProjectV1
//
//  Created by YES on 2021/1/18.
//

import SwiftUI

struct HistoryCalendarView: View {
    var startDate: Date {
        let dateFormat = DateFormatter.init()
        dateFormat.dateFormat = "yyyyMMdd"
        let date:Date = dateFormat.date(from: "20201101") ?? Date()
        return date
    }
    var monthsToDisplay: Int {
        let dateFormat = DateFormatter.init()
        dateFormat.dateFormat = "yyyyMMdd"
        let date:Date = dateFormat.date(from: "20201101") ?? Date()
        let months:Int = date.monthsBetweenDate(toDate: Date()) + 1
        return months
    }
    
    @ObservedObject var dayContentViewModel:DayContentViewModel
    
    @State var dateString = "20210116"
    @Binding var isLoading:Bool
    
    var body: some View {
        NavigationView {
            ScrollViewReader { reader in
                VStack {
                    VStack {
                        HStack{
                            TextField("yyyyMMdd", text: $dateString)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            Button(action: {
                                self.dayContentViewModel.createItem(dateString: dateString)
                            }, label: {
                                Text("Create Test")
                            })
                            Button(action: {
                                self.dayContentViewModel.deleteAll()
                            }, label: {
                                Text("DeleteAll")
                            })
                        }
                        WeekdaysView().padding(.bottom, -10)
                    }
                    
                    ScrollView {
                        VStack(spacing: 10) {
                            ForEach(0..<self.monthsToDisplay) {
                                num in
                                
                                MonthView(dayContentViewModel:self.dayContentViewModel, month: Month(startDate: self.nextMonth(currentMonth: self.startDate, add: num), selectableDays: true))
                                    .id(Int(num+1))
                            }
                        }

                    }
                }.navigationBarTitle("History")
                .navigationBarTitleDisplayMode(.inline)
                .padding(.all, 20)
                .onAppear(perform: {
                    //self.dayContentViewModel.getAllItems()
                    withAnimation{
                        reader.scrollTo(self.monthsToDisplay)
                    }
                })
            }
        }
        .onAppear(perform: {
            //DispatchQueue.main.async {
                self.isLoading = false
                print("完成历史日历页面加载")
            //}
        })
    }
    
    func nextMonth(currentMonth: Date, add: Int) -> Date {
        var components = DateComponents()
        components.month = add
        let next = Calendar.current.date(byAdding: components, to: currentMonth)!
        return next
    }
    
    func nextMonthString(currentMonth: Date, add: Int) -> String {
        var components = DateComponents()
        components.month = add
        let next = Calendar.current.date(byAdding: components, to: currentMonth)!
        return next.dateToString(format: "yyyyMM")
    }
}

struct HistoryCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryCalendarView(dayContentViewModel: DayContentViewModel(), isLoading: .constant(false))
    }
}
