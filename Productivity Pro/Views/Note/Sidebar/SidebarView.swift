//
//  SidebarView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 29.10.23.
//

import SwiftUI

struct SidebarView: View {
    var axis: Axis
    
    var body: some View {
        let layout = axis == .vertical ? AnyLayout(HStackLayout())
                                     : AnyLayout(VStackLayout())
        
        layout {
            Button(action: {}) {
                Image(systemName: "square.and.arrow.up")
                    .font(.title3)
                    .frame(width: 50, height: 50)
                    .background {
                        RoundedRectangle(cornerRadius: 9)
                            .foregroundStyle(.background)
                    }
                    .frame(
                        width: 57.5,
                        height: 65,
                        alignment: .trailing
                    )
            }
            
            Button(action: {}) {
                Image(systemName: "square.and.arrow.down")
                    .font(.title3)
                    .frame(width: 50, height: 50)
                    .background {
                        RoundedRectangle(cornerRadius: 9)
                            .foregroundStyle(.background)
                    }
                    .frame(width: 50, height: 65)
            }
            
            Spacer()
            Divider()
                .padding(.vertical, 15)
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "square.and.arrow.down")
                    .font(.title3)
                    .frame(width: 50, height: 50)
                    .background {
                        RoundedRectangle(cornerRadius: 9)
                            .foregroundStyle(.background)
                    }
                    .frame(
                        width: 50,
                        height: 65
                    )
            }
            
            Button(action: {}) {
                Image(systemName: "square.and.arrow.down")
                    .font(.title3)
                    .frame(width: 50, height: 50)
                    .background {
                        RoundedRectangle(cornerRadius: 9)
                            .foregroundStyle(.background)
                    }
                    .frame(
                        width: 50,
                        height: 65
                    )
            }
            
            Button(action: {}) {
                Image(systemName: "square.and.arrow.down")
                    .font(.title3)
                    .frame(width: 50, height: 50)
                    .background {
                        RoundedRectangle(cornerRadius: 9)
                            .foregroundStyle(.background)
                    }
                    .frame(
                        width: 50,
                        height: 65
                    )
            }
            
            Spacer()
            Divider()
                .padding(.vertical, 15)
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "square.and.arrow.down")
                    .font(.title3)
                    .frame(width: 50, height: 50)
                    .background {
                        RoundedRectangle(cornerRadius: 9)
                            .foregroundStyle(.background)
                    }
                    .frame(
                        width: 50,
                        height: 65
                    )
            }
            
            Button(action: {}) {
                Image(systemName: "square.and.arrow.down")
                    .font(.title3)
                    .frame(width: 50, height: 50)
                    .background {
                        RoundedRectangle(cornerRadius: 9)
                            .foregroundStyle(.background)
                    }
                    .frame(
                        width: 50,
                        height: 65
                    )
            }
            
            Button(action: {}) {
                Image(systemName: "square.and.arrow.down")
                    .font(.title3)
                    .frame(width: 50, height: 50)
                    .background {
                        RoundedRectangle(cornerRadius: 9)
                            .foregroundStyle(.background)
                    }
                    .frame(
                        width: 50,
                        height: 65
                    )
            }
            
            Spacer()
            Divider()
                .padding(.vertical, 15)
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "square.and.arrow.down")
                    .font(.title3)
                    .frame(width: 50, height: 50)
                    .background {
                        RoundedRectangle(cornerRadius: 9)
                            .foregroundStyle(.background)
                    }
                    .frame(
                        width: 50,
                        height: 65
                    )
            }
            
            Button(action: {}) {
                Image(systemName: "square.and.arrow.down")
                    .font(.title3)
                    .frame(width: 50, height: 50)
                    .background {
                        RoundedRectangle(cornerRadius: 9)
                            .foregroundStyle(.background)
                    }
                    .frame(
                        width: 50,
                        height: 65
                    )
            }
            
            Button(action: {}) {
                Image(systemName: "square.and.arrow.up")
                    .font(.title3)
                    .frame(width: 50, height: 50)
                    .background {
                        RoundedRectangle(cornerRadius: 9)
                            .foregroundStyle(.background)
                    }
                    .frame(
                        width: 57.5,
                        height: 65,
                        alignment: .leading
                    )
            }
        }
        .frame(maxWidth: axis == .horizontal ? 65 : .infinity)
        .frame(maxHeight: axis == .vertical ? 65 : .infinity)
        .background {
            RoundedRectangle(cornerRadius: 13)
                .foregroundStyle(.ultraThinMaterial)
        }
    }
}

#Preview {
    SidebarView(axis: .vertical)
        .padding()
}
