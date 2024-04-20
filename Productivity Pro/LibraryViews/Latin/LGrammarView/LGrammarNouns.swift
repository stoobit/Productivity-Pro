//
//  LGrammarNouns.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 22.12.23.
//

import SwiftUI

struct LGrammarNouns: View {
    var body: some View {
        NavigationLink(destination: {
            NounTable(contents: [
                ["serva", "servae"],
                ["servae", "servarum"],
                ["servae", "servis"],
                ["servam", "servas"],
                ["serva", "servis"],
            ])
            .navigationTitle("a-Deklination")
        }) {
            Label("a-Deklination", systemImage: "tablecells")
        }
        .frame(height: 30)

        NavigationLink(destination: {
            NounTable(contents: [
                ["servus / templum", "servi / templa"],
                ["servi / templi", "servorum / templorum"],
                ["servo / templo", "servis / templis"],
                ["servum / templum", "servos / templa"],
                ["servo / templo", "servis / templis"],
            ])
            .navigationTitle("o-Deklination")
        }) {
            Label("o-Deklination", systemImage: "tablecells")
        }
        .frame(height: 30)

        NavigationLink(destination: {
            NounTable(contents: [
                ["senator / nomen", "senatores / nomina"],
                ["senatoris / nominis", "senatorum / nominum"],
                ["senatori / nomini", "senatoribus / nominibus"],
                ["senatorem / nomen", "senatores / nomina"],
                ["senatore / nomine", "senatoribus / nominibus"],
            ])
            .navigationTitle("3. Deklination")
        }) {
            Label("3. Deklination", systemImage: "tablecells")
        }
        .frame(height: 30)

        NavigationLink(destination: {
            NounTable(contents: [
                ["metus", "metus"],
                ["metus", "metuum"],
                ["metui", "metibus"],
                ["metum", "metus"],
                ["metu", "metibus"],
            ])
            .navigationTitle("u-Deklination")
        }) {
            Label("u-Deklination", systemImage: "tablecells")
        }
        .frame(height: 30)

        NavigationLink(destination: {
            NounTable(contents: [
                ["res", "res"],
                ["rei", "rerum"],
                ["rei", "rebus"],
                ["rem", "res"],
                ["re", "rebus"],
            ])
            .navigationTitle("e-Deklination")
        }) {
            Label("e-Deklination", systemImage: "tablecells")
        }
        .frame(height: 30)
    }

    @ViewBuilder func NounTable(contents: [[String]]) -> some View {
        ZStack {
            Color(UIColor.systemGroupedBackground)
                .ignoresSafeArea(.all)

            GeometryReader { proxy in
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
                .frame(
                    width: proxy.size.width * 0.75,
                    height: proxy.size.height * 0.75
                )
                .position(
                    x: proxy.size.width / 2,
                    y: proxy.size.height / 2
                )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
