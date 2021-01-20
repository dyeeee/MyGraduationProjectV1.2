//
//  LocationTest.swift
//  MyGraduationProjectV1
//
//  Created by YES on 2021/1/14.
//

import SwiftUI

struct LocationTest: View {
    var body: some View {
        HStack {
            HStack{
                Image(systemName: "scroll.fill")
                
                ForEach(["a","b","c"],id:\.self){
                char in
                Button(action: {
                }, label: {
                    FilterLabel(text:char)
                })
                }
                
            }.foregroundColor(Color("WordLevelsColor"))
            
            HStack {
                Image(systemName: "scroll.fill")
                Button(action: {
                   
                }, label: {
                    HStack(spacing:-5) {
                        ForEach(0..<5){_ in
                            Image(systemName: "star.fill")
                        }
                    }.font(.callout)
                    .overlay(
                        RoundedRectangle(cornerRadius: 2.0)
                            .stroke())
                })
                
                Button(action: {
                    
                }, label: {
                    HStack(spacing:-5) {
                        ForEach(0..<4){_ in
                            Image(systemName: "star.fill")
                        }
                    }.font(.callout)
                    .overlay(
                        RoundedRectangle(cornerRadius: 2.0)
                            .stroke())
                })
                
                Button(action: {
                    
                }, label: {
                    HStack(spacing:-5) {
                        ForEach(0..<3){_ in
                            Image(systemName: "star.fill")
                        }
                    }.font(.callout)
                    .overlay(
                        RoundedRectangle(cornerRadius: 2.0)
                            .stroke())
                })
                
                Button(action: {
                    
                }, label: {
                    HStack(spacing:-5) {
                        ForEach(0..<2){_ in
                            Image(systemName: "star.fill")
                        }
                    }.font(.callout)
                    .overlay(
                        RoundedRectangle(cornerRadius: 2.0)
                            .stroke())
                })
                
                Button(action: {
                    
                }, label: {
                    HStack(spacing:-5) {
                        ForEach(0..<1){_ in
                            Image(systemName: "star.fill")
                        }
                    }.font(.callout)
                    .overlay(
                        RoundedRectangle(cornerRadius: 2.0)
                            .stroke())
                })
            }
            .foregroundColor(Color("WordLevelsColor"))
            
        }
    }
}

struct LocationTest_Previews: PreviewProvider {
    static var previews: some View {
        LocationTest()
    }
}
