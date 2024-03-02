//
//  File.swift
//  
//
//  Created by Till Brügmann on 05.11.23.
//

import SwiftUI

struct DKView: View {
    @Binding var value: Double
    @State var string: String = ""
    
    var body: some View {
        VStack {
            Text(display)
                .contentTransition(.numericText())
                .animation(.bouncy, value: display)
                .frame(width: 201, alignment: .trailing)
                .font(.title.bold())
            
            Spacer()
            
            HStack {
                DKButton(title: "7", position: .topLeading) {
                    add("7")
                }
                DKButton(title: "8", position: .center) {
                    add("8")
                }
                DKButton(title: "9", position: .topTrailing) {
                    add("9")
                }
            }
            
            HStack {
                DKButton(title: "4", position: .center) {
                    add("4")
                }
                
                DKButton(title: "5", position: .center) {
                    add("5")
                }
                
                DKButton(title: "6", position: .center) {
                    add("6")
                }
            }
            
            HStack {
                DKButton(title: "1", position: .center) {
                    add("1")
                }
                
                DKButton(title: "2", position: .center) {
                    add("2")
                }
                
                DKButton(title: "3", position: .center) {
                    add("3")
                }
            }
            
            HStack {
                DKButton(title: ".", position: .bottomLeading) {
                    if string.contains(".") == false {
                        add(".")
                    }
                }
                
                DKButton(title: "0", position: .center) {
                    add("0")
                }
                
                DKButton(title: "delete.left.fill", position: .bottomTrailing) {
                    string = String(string.dropLast())
                    value = Double(string) ?? 0
                }
            }
        }
        .onAppear {
            value = value.rounded(toPlaces: 1)
            
            if value.fraction == 0 {
                string = String(Int(value))
            } else {
                string = String(value)
            }
        }
        
    }
    
    func add(_ number: String) {
        if string == "0.0" {
            string = ""
        }
        
        var tString = string
        tString.append(number)
        
        let tValue = Double(tString) ?? 0
        
        if display.contains(".") && display.last == "0" && display.count != 1 {
            return
        }
        
        if value.fraction == 0 && value <= 10000 {
            string = tString
            value = tValue
        }
    }
    
    var display: String {
        var disp = if (value.fraction == 0 && string.last != "0") || value == 0 {
            String(Int(value))
        } else if value.fraction == 0 && string.last == "0" && string.contains(".") == false {
            String(Int(value))
        } else {
            String(value)
        }
        
        if string.last == "." {
            disp = disp + "."
        }
        
        return disp
    }
}
