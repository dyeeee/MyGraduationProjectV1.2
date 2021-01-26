//
//  infiniteLoopTest.swift
//  MyGraduationProjectV1
//
//  Created by YES on 2021/1/26.
//

import SwiftUI

class DataSource: ObservableObject {
  @Published var counter = 0
  @Published var wordExample = ["allow","alleviate","among"]
}

struct infiniteLoopTest: View {
    @ObservedObject var dataSource = DataSource()

    var body: some View {
      VStack {
        Button("Increment counter") {
          dataSource.counter += 1
        }

        Text("Count is \(dataSource.counter)")
      }
    }
}


struct ItemList: View {
    @ObservedObject var dataSource = DataSource()
    
  var body: some View {
    ZStack(alignment:.top) {
        ForEach(dataSource.wordExample ,id:\.self){
           word in
            VStack {
                Text("\(dataSource.wordExample.firstIndex(of: word) ?? 0)")
                Text(word)
            }.offset(x:0,y:CGFloat(dataSource.wordExample.firstIndex(of: word) ?? 1) * 100)
            
        }
        
        VStack {
            Spacer()
            Button("Append item to list") {
                dataSource.wordExample.append("test")
            }
            Button("delete item from list") {
                dataSource.wordExample.remove(at: 0)
            }
        }
    }
  }
}


struct ItemList_Previews: PreviewProvider {
    static var previews: some View {
        ItemList()
    }
}
