//
//  ScheduleAddSubject.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 11.09.23.
//

import SwiftUI

struct ScheduleAddSubject: View {
    
    @Binding var isPresented: Bool
    @AppStorage("ppsubjects")
    var subjects: CodableWrapper<Array<Subject>> = .init(value: .init())
    
    var body: some View {
        NavigationStack {
            Form {
                
            }
            .navigationTitle("Fach")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Abbrechen") {
                        isPresented.toggle()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Hinzufügen") {
                        
                    }
                }
            }
        }
    }
}

#Preview {
    ScheduleAddSubject(isPresented: .constant(true))
}
