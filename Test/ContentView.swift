//
//  ContentView.swift
//  Test
//
//  Created by Apple on 8/17/23.
//

import SwiftUI

struct ContentView: View {
    @State var isShowing: Bool = false
    
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            
            Button {
                withAnimation {
                    isShowing.toggle()
                }
            } label: {
                Text("Click")
                    .foregroundColor(.white)
            }

            DrawerBottomSheet(isShowing: $isShowing, content: AnyView(TestView()))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
