//
//  ContentView.swift
//  Pagination
//
//  Created by Osama Naeem on 14/08/2019.
//  Copyright © 2019 NexThings. All rights reserved.
//

import SwiftUI

struct TestData {
    var id : Int
    var text: String
}


struct ContentView: View {
    var contentArray: [TestData] = [TestData(id: 0, text: "Test 1"), TestData(id: 1, text: "Test 2"), TestData(id: 2, text: "TEst 3"), TestData(id: 4, text: "Test 4")]
    
    
    var body: some View {
      GeometryReader { g in
        ZStack{
            SwiftyUIScrollView(axis: .horizontal, numberOfPages: self.contentArray.count, pagingEnabled: true, pageControlEnabled: true, hideScrollIndicators: true) {
                    HStack(spacing: 0) {
                        ForEach(self.contentArray, id: \.id) { item in
                            TestView(data: item)
                                .frame(width: g.size.width, height: g.size.height)
                        }
                    }
            }.frame(width: g.size.width)
        }.frame(width: g.size.width, height: g.size.height)
            
        }
    }
}


struct TestView: View {
    var data: TestData
    var body: some View {
        
        GeometryReader { g in
                VStack {
                    HStack {
                        Spacer()
                    }
                    Text(self.data.text)
                    Text(self.data.text)
                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .background(Color.yellow)
        }
    }
}



#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
