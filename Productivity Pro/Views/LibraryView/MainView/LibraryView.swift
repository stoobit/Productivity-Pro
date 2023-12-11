//
//  LibraryView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 10.09.23.
//

import SwiftUI

struct LibraryView: View {
    let columns = [GridItem(.adaptive(minimum: 270))]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(UIColor.systemGroupedBackground)
                    .ignoresSafeArea(.all)
                
                ScrollView {
                    LazyVGrid(columns: columns) {
                       
                        NavigationLink(destination: {
                            LatinView()
                        }) {
                            LibraryViewCard(
                                title: "Latein",
                                image: "laurel.leading",
                                color: .yellow
                            )
                        }
                        
                        NavigationLink(destination: {
                            
                        }) {
                            LibraryViewCard(
                                title: "Englisch",
                                image: "bubble.left.and.text.bubble.right.fill",
                                color: .green
                            )
                        }
                        .disabled(true)

                        NavigationLink(destination: {
                            
                        }) {
                            LibraryViewCard(
                                title: "Deutsch",
                                image: "theatermasks.fill",
                                color: .red
                            )
                        }
                        .disabled(true)
                        
                        NavigationLink(destination: {
                            
                        }) {
                            LibraryViewCard(
                                title: "Mathe",
                                image: "compass.drawing",
                                color: .blue
                            )
                        }
                        .disabled(true)
                        
                        NavigationLink(destination: {
                            
                        }) {
                            LibraryViewCard(
                                title: "Informatik",
                                image: "hammer.fill",
                                color: .pink
                            )
                        }
                        .disabled(true)
                        
                        NavigationLink(destination: {
                            
                        }) {
                            LibraryViewCard(
                                title: "Chemie",
                                image: "atom",
                                color: .primary
                            )
                        }
                        .disabled(true)
                        
                        NavigationLink(destination: {
                            
                        }) {
                            LibraryViewCard(
                                title: "Physik",
                                image: "paperplane.fill",
                                color: .teal
                            )
                        }
                        .disabled(true)
                        
                        NavigationLink(destination: {
                            
                        }) {
                            LibraryViewCard(
                                title: "Geographie",
                                image: "globe.desk.fill",
                                color: .brown
                            )
                        }
                        .disabled(true)
                        
                        NavigationLink(destination: {
                            
                        }) {
                            LibraryViewCard(
                                title: "Geschichte",
                                image: "clock.fill",
                                color: .orange
                            )
                        }
                        .disabled(true)
                        
                        NavigationLink(destination: {
                            
                        }) {
                            LibraryViewCard(
                                title: "Sozialkunde",
                                image: "person.3.fill",
                                color: .indigo
                            )
                        }
                        .disabled(true)
                        
                    }
                    .padding()
                }
            }
            .navigationTitle("Bibliothek")
        }
    }
}

#Preview {
    LibraryView()
}
