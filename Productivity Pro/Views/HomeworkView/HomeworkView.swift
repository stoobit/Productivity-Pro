//
//  HomeworkView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 12.09.23.
//

import SwiftUI

struct HomeworkView: View {
    
    @AppStorage("ppsubjects")
    var subjects: CodableWrapper<Array<Subject>> = .init(value: .init())
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(UIColor.systemGroupedBackground)
                    .ignoresSafeArea(.all)
            
                HomeworkList()

                if subjects.value.isEmpty {
                    VStack {
                        Image(systemName: "tray.2")
                            .font(.system(size: 100))
                        
                        Text("Du hast noch keine Fächer erstellt.")
                            .font(.title.bold())
                            .padding([.top, .horizontal])
                            .multilineTextAlignment(.center)
                        
                        Text("Schreibtisch \(Image(systemName: "arrow.right")) Fächer")
                            .foregroundStyle(Color.primary.tertiary)
                    }
                    .foregroundStyle(Color.accentColor.secondary)
                }
                
            }
            .navigationTitle("Hausaufgaben")
        }
    }
}

#Preview {
    HomeworkView()
}
