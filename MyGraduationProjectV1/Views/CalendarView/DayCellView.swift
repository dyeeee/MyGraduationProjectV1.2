//
//  CellView.swift
//  CalSwiftUI
//
//  Created by Adam Kes on 11/13/19.
//  Copyright © 2019 KesDev. All rights reserved.
//

import SwiftUI


struct DayCellView: View {
    @ObservedObject var day: Day
    @State var done:Bool = false
    
    var angleList:[Double]{
        var list:[Double] = []
        for i in stride(from: -60.0, to: 60.0, by: 5) {
            list.append(i)
        }
        return list
    }
    
    var offsetList:[CGFloat] = [0,1,2,3]
    
    
    
    var body: some View {
        ZStack {
            if self.done{
            Image("StudyDone3")
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .scaleEffect(1.7)
                .opacity(1)
                .foregroundColor(Color(.systemOrange))
                .rotationEffect(.degrees(angleList.randomElement()!))
                .offset(x: offsetList.randomElement()!, y: offsetList.randomElement()!)
            }
            Text(day.dayName)
                .font(.title3)
                //.fontWeight(.semibold)
                .padding(1)
        }
        .frame(width: UIScreen.main.bounds.width/7-15, height: 32)
        .overlay(
            RoundedRectangle(cornerRadius: 5.0)
                .stroke())
        .foregroundColor(day.textColor)
        .background(day.backgroundColor)
        //.foregroundColor(Color(.systemGray))

//            .onTapGesture {
//                if self.day.disabled == false && self.day.selectableDays {
//                    self.day.isSelected.toggle()
//                }
//                
//            }
    }
}


struct CellView_Previews: PreviewProvider {
    static var previews: some View {
        DayCellView(day: Day(date: Date()))
    }
}
