//
//  LGrammarNouns.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 22.12.23.
//

import SwiftUI

struct LGrammarNouns: View {
    var proxy: GeometryProxy

    var body: some View {
        NavigationLink(destination: {
            NounTable(contents: [
                ["serva", "servae"],
                ["servae", "servarum"],
                ["servae", "servis"],
                ["servam", "servas"],
                ["servā", "servis"],
            ])
            .navigationTitle("a-Deklination")
        }) {
            Label("a-Deklination", systemImage: "tablecells")
        }
        .frame(height: 30)
        
        NavigationLink(destination: {
            NounTable(contents: [
                ["serva", "servae"],
                ["servae", "servarum"],
                ["servae", "servis"],
                ["servam", "servas"],
                ["servā", "servis"],
            ])
            .navigationTitle("a-Deklination")
        }) {
            Label("o-Deklination", systemImage: "tablecells")
        }
        .frame(height: 30)
    }

    @ViewBuilder func NounTable(contents: [[String]]) -> some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea(.all)
            
            LGrammarTable(
                top: ["Singular", "Plural"],
                leading: [
                    "Nominativ",
                    "Genitiv",
                    "Dativ",
                    "Akkusativ",
                    "Ablativ",
                ],
                contents: contents
            )
            .frame(width: proxy.size.width * 0.6)
        }
    }
}
