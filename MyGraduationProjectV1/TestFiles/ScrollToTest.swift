//
//  ScrollToTest.swift
//  MyGraduationProjectV1
//
//  Created by YES on 2021/1/14.
//

import SwiftUI

struct ScrollToTest: View {
    @State var isDragging = false

    @State var draggedOffset = CGSize.zero
    
    @State private var currentPosition: CGSize = .zero
    @State private var newPosition: CGSize = .zero
    
    var body: some View {
        ScrollViewReader { reader in
            VStack {
                
                HStack {
                    Button(action: {
                        reader.scrollTo(1)
                    }, label: {
                        Text("jump A")
                    })
                    Button(action: {
                        withAnimation(.linear(duration: 1)){
                            reader.scrollTo(2)
                        }
                    }, label: {
                        Text("jump B")
                    })
                    Button(action: {
                        withAnimation(.spring()){
                            reader.scrollTo(3)
                        }
                    }, label: {
                        Text("jump C")
                    })
                }
                List{
                    Section(header:Text("a")){
                    VStack {
                        Text("a")
                            .frame(width: 100, height: 500, alignment: .center)
                    }.id(1)
                    }
                    
                    Section(header:Text("b")){
                    VStack {
                        Text("b")
                            .frame(width: 100, height: 500, alignment: .center)
                    }.id(2)
                    }
                    
                    Section(header:Text("c")){
                    VStack {
                        Text("c")
                            .frame(width: 100, height: 500, alignment: .center)
                    }.id(3)
                    }
                }
            }
        }
    }
}

struct ScrollToTest_Previews: PreviewProvider {
    static var previews: some View {
        ScrollToTest()
    }
}
