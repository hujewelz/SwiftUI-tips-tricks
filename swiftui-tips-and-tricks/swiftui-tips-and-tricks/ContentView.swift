//
//  ContentView.swift
//  swiftui-tips-and-tricks
//
//  Created by luobobo on 2022/11/5.
//

import SwiftUI

struct Item: Identifiable {
    let title: String
    let content: () -> any View
    
    init(_ title: String, content: @escaping () -> any View) {
        self.title = title
        self.content = content
    }
    
    var id: String { title }
}


struct ContentView: View {
    
    let items: [Item] = [
        .init("Date", content: DateText.init),
        .init("Custom button style", content: CustomButtonStyle.init),
        .init("Bottom sheet", content: BottomSheetExample.init)
    ]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        AnyView(item.content())
                    } label: {
                        Text(item.title)
                    }
                }
            }
            .navigationTitle("Tips & tricks")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
