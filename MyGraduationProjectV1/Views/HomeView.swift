//
//  HomeView.swift
//  MyGraduationProjectV1
//
//  Created by YES on 2021/1/18.
//

import SwiftUI

struct HomeView: View {
    @State var showHistoryCalendar = false
    @ObservedObject var dayContentViewModel:DayContentViewModel// = DayContentViewModel()
    
    @State var isLoading:Bool = false
    
    @AppStorage("LearnDayCount") var learnDayCount:Int = 1
    @AppStorage("LastLogIn") var lastLogIn:String = "test"
    @AppStorage("IsLastLearnDone") var isLastLearnDone:Bool = false
    
    var body: some View {
        NavigationView {
            
                ZStack{
                    ScrollView {
                    VStack {
                        
                        VStack(spacing:3) {
                            WeekdaysView()
                            MonthView(dayContentViewModel:self.dayContentViewModel,isCurrentMonth:true, month: Month(startDate:Date()))
                                
                            HStack() {
                                
                                Spacer()
                                Button(action: {
                                    self.isLoading = true
                                    print("loading")
                                    self.showHistoryCalendar.toggle()
    //                                DispatchQueue.global(qos: .background).async {
    //
    //                                    DispatchQueue.main.async {
    //                                        self.isLoading = false
    //                                        print("完成加载")
    //                                    }
    //                                }
                                }, label: {
                                    Text("History/AddTest")
                                }).buttonStyle(BorderlessButtonStyle())
                                
                            }
                        }
                        .padding(10)
                        .padding([.bottom], 10)
                        .background(RoundedRectangle(cornerRadius: 20.0, style: .continuous).foregroundColor(.white))
                        
                        VStack {
                            Text("学习天数\(learnDayCount)")
                            Text("上次启动日期\(lastLogIn)")
                            Text("学习是否完成\(isLastLearnDone.description)")
                        }
                        
                        VStack{
                            Button(action: {
                                isLastLearnDone = true
                                self.dayContentViewModel.createItem(dateString: Date().dateToString(format: "yyyyMMdd"))
                            }, label: {
                                Text("模拟完成今天学习")
                            })
                            
                            Button(action: {
                                lastLogIn = "20210120"
                            }, label: {
                                Text("手动设置上次启动日期")
                            })
                            
                            Button(action: {
                                learnDayCount = 1
                            }, label: {
                                Text("重置学习天数")
                            })
                        }
                        
                        
                        Spacer()
                    }.padding([.leading,.trailing,.top],10)
                    
                    //.listStyle(InsetGroupedListStyle())
                    .zIndex(0)
                    //.background(Color(.systemGray6))
                    
                    if (self.isLoading) {
                        
                        ProgressView()
                            .frame(width: 100, height: 100)
                            .background(RoundedRectangle(cornerRadius: 10, style: .continuous).foregroundColor(Color(.systemGray5)))
                            .offset(x: 0, y: -70)
                            .zIndex(1)
                    }
                }
            }
            .background(Color(.systemGray6).edgesIgnoringSafeArea(.all))
            
            .navigationBarTitle("Home")
                .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showHistoryCalendar, content: {
                HistoryCalendarView(dayContentViewModel:self.dayContentViewModel,isLoading:self.$isLoading)
            })
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(dayContentViewModel: DayContentViewModel())
    }
}

struct CenterModifier: ViewModifier {
    func body(content: Content) -> some View {
        HStack {
            Spacer()
            content
            Spacer()
        }
    }
}
