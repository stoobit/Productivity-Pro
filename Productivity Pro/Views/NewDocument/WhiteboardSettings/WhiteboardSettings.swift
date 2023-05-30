//
//  WhiteboardSettings.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 17.09.22.
//

import SwiftUI

struct WhiteboardSettings: View {
    
    @Binding var document: Document
    let dismiss: () -> Void
    
    @State var backgroundColor: String = "white"
    @State var backgroundTemplate: String = "blank"
    
    var body: some View {
        VStack {
            GeometryReader { reader in
                ZStack {
                    
                    VStack {
                        Spacer()
                        TabView(selection: $backgroundTemplate) {
                            BlankIcon(reader.size).tag("blank")
                            RuledIcon(reader.size).tag("ruled")
                        }
                        .tabViewStyle(.page(indexDisplayMode: .never))
                        Spacer()
                    }
                    
                    VStack {
                        ColorSelector()
                        Spacer()
                    }
                    
                }
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Create") { create() }
                }
            }
            .overlay { IndicatorView() }
        }
    }
    
    @ViewBuilder func BlankIcon(_ size: CGSize) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .foregroundColor(Color(backgroundColor))
                .frame(width: size.width * 0.9, height: size.height * 0.7)
            
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color.accentColor, lineWidth: 3)
                .frame(width: size.width * 0.9, height: size.height * 0.7)
        }
    }
    
    @ViewBuilder func RuledIcon(_ size: CGSize) -> some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .foregroundColor(Color(backgroundColor))
            
            HStack {
                Spacer()
                
                Path { path in
                    for i in 1...100 {
                        path.addRect(CGRect(x: 0, y: CGFloat(i) * 20, width: size.width, height: 1))
                    }
                }
                .fill(Color.secondary)
                .colorScheme(colorScheme())
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                
                Spacer()
            }
            
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color.accentColor, lineWidth: 3)
            
        }
        .frame(width: size.width * 0.9, height: size.height * 0.7)
    }
    
    @ViewBuilder func IndicatorView() -> some View {
        VStack {
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.secondary)
                
                HStack {
                    Spacer()
                    Circle()
                        .frame(width: 5, height: 5)
                        .frame(width: 5, height: 5)
                        .foregroundColor(backgroundTemplate == "blank" ? .white : .secondary)
                    
                    Spacer()
                    Circle()
                        .frame(width: 5, height: 5)
                        .foregroundColor(backgroundTemplate == "ruled" ? .white : .secondary)
                    
                    Spacer()
                }
            }
            .frame(width: 50, height: 20)
        }
        .padding()
    }
    
    @ViewBuilder func ColorSelector() -> some View {
        VStack {
            HStack {
                Text("Color")
                    .font(.body)
                    .foregroundColor(.primary)
                
                Spacer()
                
                ColorCircle("white")
                ColorCircle("yellow")
                ColorCircle("gray")
                ColorCircle("black")
                
            }
            .padding(.vertical, 5)
        }
        .padding()
    }
    
    @ViewBuilder func ColorCircle(_ value: String) -> some View {
        Button(action: { withAnimation { backgroundColor = value } }) {
            Circle()
                .fill(Color(value))
                .shadow(color: backgroundColor == value ? .clear : .primary, radius: 2)
                .frame(width: 30, height: 30)
                .padding(.horizontal, 10)
                .overlay {
                    if backgroundColor == value {
                        Circle()
                            .stroke(Color.accentColor, lineWidth: 3)
                    }
                }
        }
    }
    
    func create() {
        withAnimation {
            
            document.documentType = .whiteboard
            
            let whiteboard = Whiteboard(
                backgroundColor: backgroundColor,
                backgroundTemplate: backgroundTemplate
            )
            
            document.whiteboard = whiteboard
            dismiss()
        }
    }
    
    func colorScheme() -> ColorScheme {
        var cs: ColorScheme = .dark
        
        if backgroundColor == "white" || backgroundColor == "yellow" {
            cs = .light
        }
        
        return cs
    }
    
}

struct Hello_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello, world!")
            .sheet(isPresented: .constant(true)) {
                WhiteboardSettings(document: .constant(Document()), dismiss: {})
            }
    }
}
