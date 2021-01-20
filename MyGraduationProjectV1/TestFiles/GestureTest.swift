//
//  GestureTest.swift
//  MyGraduationProjectV1
//
//  Created by YES on 2021/1/14.
//

import SwiftUI

struct GestureTest: View {
    
    @State private var dragged = CGSize.zero
    @State private var accumulated = CGSize.zero

    var body: some View {
        VStack{
            ZStack(alignment:.leading) {
                VStack {
                    Rectangle()
                        .foregroundColor(Color(.systemGray6))
                }
                
                HStack {
                    Circle()
                        .frame(width: 30, height: 30).border(Color.red)
                        .offset(x: self.dragged.width)

                        .gesture(DragGesture()
                            .onChanged{ value in
                                self.dragged = CGSize(width: value.translation.width + self.accumulated.width, height: value.translation.height + self.accumulated.height)
                                

                        }
                        .onEnded{ value in
                            self.dragged = CGSize(width: value.translation.width + self.accumulated.width, height: value.translation.height + self.accumulated.height)
                            self.accumulated = self.dragged
                            }
                    )
                }
            }.frame(width: 200, height: 30, alignment: .center)
            
            Text("\(Int(accumulated.width))")
        }
    }
}

struct GestureTest_Previews: PreviewProvider {
    static var previews: some View {
        GestureTest()
    }
}
