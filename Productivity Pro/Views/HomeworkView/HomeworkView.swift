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

                if subjects.value.isEmpty {
                    ContentUnavailableView(
                        "Du hast noch keine Fächer erstellt.",
                        systemImage: "tray.2",
                        description: Text("Schreibtisch \(Image(systemName: "arrow.right")) Fächer")
                    )
                } else {
                    HomeworkList()
                }
                
            }
            .navigationTitle("Hausaufgaben")
        }
        .modifier(LockScreen())
    }
}

#Preview {
    HomeworkView()
}
