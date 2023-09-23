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
                    .modelContainer(
                        for: Homework.self,
                        isAutosaveEnabled: true,
                        isUndoEnabled: false
                    )
                
            }
            .navigationTitle("Hausaufgaben")
        }
    }
}

#Preview {
    HomeworkView()
}
