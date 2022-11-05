//
//  BottomSheet.swift
//  swiftui-tips-and-tricks
//
//  Created by luobobo on 2022/11/5.
//

import SwiftUI

struct BottomSheetExample: View {
    @State private var isPresented = false
    
    var body: some View {
        Button {
            isPresented.toggle()
        } label: {
            Text("Present")
        }
        .bottomSheet(isPresented: $isPresented) {
            BottomSheetContent()
        }
    }
}

struct BottomSheetContent: View {
    var body: some View {
        VStack {
            Text("Hello, World!")
        }
        .frame(height: 300)
        .frame(maxWidth: .infinity)
        .background(Color.red)
    }
}

extension View {
    func bottomSheet<Content>(isPresented: Binding<Bool>,
                              @ViewBuilder content: () -> Content) -> some View where Content: View {
        modifier(BottomSheetModifier(isPresented: isPresented, content: content))
    }
}

private struct BottomSheetModifier<SheetContent>: ViewModifier where SheetContent: View {
    
    @Binding var isPresented: Bool
    let sheetContent: SheetContent
    
    init(isPresented: Binding<Bool>, @ViewBuilder content: () -> SheetContent) {
        _isPresented = isPresented
        self.sheetContent = content()
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
            BottomSheet(isPresented: $isPresented) {
                sheetContent
            }
        }
    }
}

private struct BottomSheet<Content>: View where Content: View {
    
    @Binding var isPresented: Bool
    let content: Content
    
    @State private var contentHeight: CGFloat = 0
    
    init(isPresented: Binding<Bool>, @ViewBuilder content: () -> Content) {
        _isPresented = isPresented
        self.content = content()
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black.opacity(isPresented ? 0.6 : 0)
                .onTapGesture {
                    isPresented.toggle()
                }
            
            GeometryReader { proxy in
                content
                    .background(ViewGeometry())
                    .onPreferenceChange(ViewSizeKey.self) { size in
                        contentHeight = size.height
                    }
                    .offset(y: isPresented ? proxy.size.height - contentHeight : proxy.size.height)
            }
        }
        .animation(.spring(), value: isPresented)
        .edgesIgnoringSafeArea(.all)
        
    }
}

struct ViewSizeKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

struct ViewGeometry: View {
    var body: some View {
        GeometryReader { proxy in
            Color.clear
                .preference(key: ViewSizeKey.self, value: proxy.size)
        }
    }
}

struct BottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetExample()
    }
}
