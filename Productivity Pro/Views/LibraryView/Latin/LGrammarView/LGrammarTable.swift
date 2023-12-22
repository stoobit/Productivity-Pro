//
//  GrammarTable.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 22.12.23.
//

import SwiftUI

struct LGrammarTable: View {
    var top: [String]
    var leading: [String]
    
    var contents: [[String]]
    
    var body: some View {
        VStack(spacing: 15) {
            HStack(spacing: 15) {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.clear)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                
                ForEach(top, id: \.self) { string in
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Color.accentColor)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .overlay {
                            Text(string)
                                .font(.headline)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading)
                        }
                }
            }
            
            ForEach(0...leading.count - 1, id: \.self) { index in
                let string = leading[index]
                
                HStack(spacing: 15) {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundStyle(Color.accentColor)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .overlay {
                            Text(string)
                                .font(.headline)
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading)
                        }
                    
                    ForEach(0...top.count - 1, id: \.self) { subindex in
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(.background)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .overlay {
                                Text(contents[index][subindex])
                                    .font(.body)
                                    .foregroundStyle(Color.primary)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading)
                            }
                    }
                }
            }
        }
    }
}
