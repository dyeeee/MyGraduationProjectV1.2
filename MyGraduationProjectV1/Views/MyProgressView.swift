//
//  MyProgressView.swift
//  MyGraduationProjectV1
//
//  Created by YES on 2020/12/30.
//

import SwiftUI

struct MyProgressView: View {
    @State var progressValue: Float = 1197/1583
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.white)
                .frame(width: .infinity, height: 180, alignment: .center)
                .shadow(radius: 2)

            VStack(alignment: .leading){
                HStack {
                    Text("TaskName").font(.title3)
                    Spacer()
                    Button(action: {}, label: {
                        HStack(spacing:5) {
                            Image(systemName: "book")
                            Text("List")
                        }.foregroundColor(.gray)
                    })
                }
                HStack{
                    Text("Doing 20")
                    Text("Done 1197")
                    Text("UnDone 205")
                    Text("All 1583")
                }.font(.caption)
                
                HStack{
                    LineProgressBar(progressValue: $progressValue)
                        //.frame(width: 150.0, height: 150.0)
                        //.padding(.bottom,10)
                }
                
                
                HStack {
                    VStack{
                        Text("20")
                            
                        Text("NewThings")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                    VStack{
                        Text("50")
                        Text("ToDos")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                    VStack{
                        Text("\(progressValue*100,specifier: "%.1f")%")
                        Text("Done Rate")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Button(action: {}, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 30)
                                .frame(width: 100, height: 30, alignment: .center)
                            Text("Start").foregroundColor(.white)
                        }
                        
                    })
                }
            
            }.padding([.leading,.trailing], 15)
            
        }
    }
}

struct MyProgressView_Previews: PreviewProvider {
    static var previews: some View {
        MyProgressView()
    }
}
