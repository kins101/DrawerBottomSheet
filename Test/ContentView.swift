//
//  ContentView.swift
//  Test
//
//  Created by Apple on 8/17/23.
//

import SwiftUI

struct ContentView: View {
    @State var isShowing: Bool = false
    @State private var isPresented: Bool = false

    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Button {
                    withAnimation {
                        isPresented.toggle()
                    }
                } label: {
                    Text("PresentationDetents")
                        .foregroundColor(.white)
                }
                
                Button {
                    withAnimation {
                        isShowing.toggle()
                    }
                } label: {
                    Text("Custom Sheet")
                        .foregroundColor(.white)
                }
            }
            
            DrawerBottomSheet(isShowing: $isShowing, content: AnyView(TestView()))
        }
        .sheet(isPresented: $isPresented) {
            ScrollView {
                TestView()
            }
            .padding()
            .presentationDetents([.fraction(0.8), .large])
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
