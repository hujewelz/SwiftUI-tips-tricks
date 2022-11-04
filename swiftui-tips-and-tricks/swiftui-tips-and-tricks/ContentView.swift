//
//  ContentView.swift
//  swiftui-tips-and-tricks
//
//  Created by luobobo on 2022/11/5.
//

import SwiftUI

struct Item<Content: View>: Identifiable {
    let title: String
    let content: () -> Content
    
    var id: String { title }
}


struct ContentView: View {
    
    let items: [Item] = [
        .init(title: "data", content: DataText.init)
    ]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(items) { item in
                    NavigationLink(destination: item.content) {
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
