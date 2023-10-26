//
//  DrawerBottomSheet.swift
//  Test
//
//  Created by Apple on 10/26/23.
//

import SwiftUI

struct DrawerBottomSheet: View {
    @Binding var isShowing: Bool
    var content: AnyView
    var cornerRadius: CGFloat = 16
    var backgroundColor: Color = .white
    
    @State var offset: CGFloat = 0
    @State var lastOffset: CGFloat = 0
    @GestureState var gestureOffset: CGFloat = 0
    @State var contentSize: CGSize = .zero
    let sheetLimit: CGFloat = 150
    
    var body: some View {
        GeometryReader { proxy in
            let height = proxy.frame(in: .global).height
            let defaultOffset = height*1/4
            
            ZStack {
                if isShowing {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                        .onTapGesture {
                            hideSheet()
                        }
                }
                
                ZStack(alignment: .bottom) {
                    if isShowing {
                        SizeReader(size: $contentSize) {
                            let hiddenViewHeight = defaultOffset + contentSize.height - height
                            
                            content
                                .cornerRadius(cornerRadius, corners: [.topLeft, .topRight])
                                .offset(y: defaultOffset + offset)
                                .gesture(DragGesture().updating($gestureOffset, body: { value, out, _ in
                                    out = value.translation.height
                                    onChange(hiddenViewHeight)
                                }).onEnded({ value in
                                    withAnimation {
                                        if offset > 0 {
                                            if offset > sheetLimit {
                                                hideSheet()
                                            } else {
                                                offset = 0
                                            }
                                        } else {
                                            if contentSize.height <= (height - defaultOffset) {
                                                offset = 0
                                            } else {
                                                if abs(offset) > hiddenViewHeight {
                                                    self.offset = -hiddenViewHeight
                                                }
                                            }
                                        }
                                    }
                                    
                                    lastOffset = offset
                                }))
                               
                        }
                        .transition(.move(edge: .bottom))
                    }
                }
            }
            
            if isShowing {
                VStack {
                        Divider()
                            .background(Color.gray)
                        VStack {
                            HStack {
                                Button {
                                    
                                } label: {
                                    Text("Join space")
                                        .foregroundColor(.black)
                                }
                                
                                Button {
                                    
                                } label: {
                                    Text("Change avatar")
                                        .foregroundColor(.black)
                                }
                            }
                            
                            Text("Download: 213MB")
                        }
                        .padding()
                }
                .background(.white)
                .frame(height: 111)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .transition(.move(edge: .bottom))
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    func onChange(_ hiddenViewHeight: CGFloat) {
        DispatchQueue.main.async {
            withAnimation {
                let totalOffset = gestureOffset + lastOffset
                
                if totalOffset > 0 {
                    self.offset = totalOffset
                } else if totalOffset > -hiddenViewHeight-300 {
                    self.offset = totalOffset
                }
            }
        }
    }
    
    private func hideSheet() {
        withAnimation {
            offset = 0
            isShowing.toggle()
        }
    }
}

struct TestView: View {
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack() {
                VStack(spacing: 24) {
                    ForEach(0..<20) { i in
                        Text("Questions and requests from viewers. In addition, the charged card is called")
                    }
                    
                    Button {
                        
                    } label: {
                        Text("Test")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(.gray)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }

                }
                .padding(.top, 16)
                .padding(.horizontal, 16)
            }
            .padding(.bottom, 111)
        }
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorners(radius: radius, corners: corners) )
    }
}

struct RoundedCorners: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

