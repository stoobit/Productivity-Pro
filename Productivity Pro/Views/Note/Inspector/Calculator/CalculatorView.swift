//
//  CalculatorView.swift
//  TurtleMaths_3.0
//
//  Created by Lukas Rischer on 29.05.23.
//

import SwiftUI

extension String {
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}

struct CalculatorView: View {
    
    @State var calc : Calculator = Calculator()
    @State var powerTrue = false
    @State var logTrue = false
    @State var systemLanguage = 0 //0 ist EN, 1 ist DE, beeinflusst Punkt bzw. Komma, auch shortcut
    @State var inputString = ""
    @State var display = "0"
    @State var display2 = ""
    @State var calcContinue = true
    @State public var savedCalc: [String] = []
    @State var link = false
    @Environment(\.colorScheme) var colorScheme
    @State var powerColor: Color = .black
    @State var boxImage = "archivebox"
    @State var copyImage = "doc.on.clipboard"
    let pasteboard = UIPasteboard.general
    
    let powers: [Character] = ["\u{2070}", "\u{2074}", "\u{2075}", "\u{2076}", "\u{2077}", "\u{2078}", "\u{2079}", "\u{00B2}", "\u{00B3}", "\u{00B9}"]
    let numbers: [Character] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    private var feedback0_de: [String] = ["Schade, das wird schon wieder", "Fast!", "Knapp", "Sorry, ich bin verwirrt", "Ich kann dir nicht helfen", "Da ist ein Fehler drin", ":("]
    private var feedback1_de: [String] = ["Ach komm, kannst du besser", "NEIN!", "Kein Bock mehr!", "??? WAS ???", "You a failure", "Nicht schon wieder", "Ich bin enttäuscht von dir"]
    private var feedback0_en: [String] = ["So close!", "I'm sory...", "I can't help you with this one", "WOW, you invented new math", "I'm not smart enough to do that", ":(", "you got this!"]
    private var feedback1_en: [String] = ["Come on!", "You serious?!", "You must be joking", "I am disappointed in you", "Just... NO!!!", "WTH?!", "Im not gonna comment...", "Seriously???", "You a faaailure"]
    
    private func getColor() -> Color{
        powerColor = colorScheme == .dark ? .black : .white
        return powerColor
        
    }
    
    //MARK: format()
    func format(arg: String) -> String {
        var answerString = arg
        while((answerString.last == "0" && answerString.contains(".")) || answerString.last == "."){
            answerString.removeLast()
        }
        if(answerString.contains(".") && systemLanguage == 1){
            answerString.replace(".", with: ",")
        }
        return answerString
    }
    //MARK: autoAdd()
    func autoAdd(str: String) -> String {
        var str = str
        let autoclosePar = true
        
        if(autoclosePar){
            while(str.components(separatedBy: "(").count != str.components(separatedBy: ")").count){
                str.insert(str.components(separatedBy: "(").count > str.components(separatedBy: ")").count ? ")" : "(", at: str.components(separatedBy: "(").count > str.components(separatedBy: ")").count ? str.endIndex : str.startIndex)
            }
        }
        return str
    }
    //MARK: addDigit()
    private func addDigit(digit: String){
        if(display.contains("=")){
            if(calcContinue && (digit == " + " || digit == " - " || digit == " / " || digit == " × " || digit == " sin " || digit == " cos " || digit == " tan " || digit == " log " || digit == "π" || digit == "(" || powerTrue)){
                display.removeFirst(2)
                powerColor = colorScheme == .dark ? .white : .black
                display2 = ""
                inputString = display
            } else {
                ClearAll()
            }
        }
        if((numbers.contains(inputString.last ?? "+") || inputString.last == ")" || inputString.dropLast().last == "S" || inputString.last == "π") && (digit == "(" || digit == " sin " || digit == " cos " || digit == " tan " || digit == " log " || digit == "π" || digit == " ANS ") && !powerTrue){
            inputString += " × "
        }
        if((digit == " * " || digit == " / " || digit == " + " || digit == " - " || digit == " s " || digit == " c ")
           && ((inputString.dropLast()).last == "/" || (inputString.dropLast()).last == "*" || (inputString.dropLast()).last == "+" || (inputString.dropLast()).last == "-")
           && ((inputString.dropLast(4)).last == "/" || (inputString.dropLast(4)).last == "*")){
        } else if(
            (digit == " * " || digit == " / ")
            && ((inputString.dropLast()).last == "-" || (inputString.dropLast()).last == "+" || (inputString.dropLast()).last == "*" || (inputString.dropLast()).last == "/")
        ){} else if(powerTrue) {
            switch(digit){
            case "(":
                if(!powers.contains(inputString.last ?? "\u{2070}")){
                    inputString += "^ ("
                    powerTrue = false
                    powerColor = colorScheme == .dark ? .white : .black
                } else {
                    inputString += "("
                    powerColor = colorScheme == .dark ? .white : .black
                }
            case "0":
                inputString += "\u{2070}"
            case "1":
                inputString += "\u{00B9}"
            case "2":
                inputString += "\u{00B2}"
            case "3":
                inputString += "\u{00B3}"
            case "4":
                inputString += "\u{2074}"
            case "5":
                inputString += "\u{2075}"
            case "6":
                inputString += "\u{2076}"
            case "7":
                inputString += "\u{2077}"
            case "8":
                inputString += "\u{2078}"
            case "9":
                inputString += "\u{2079}"
            default:
                inputString += ""
            }
        } else if(logTrue) {
            switch(digit){
            case "0":
                inputString += "\u{2080}"
            case "1":
                inputString += "\u{2081}"
            case "2":
                inputString += "\u{2082}"
            case "3":
                inputString += "\u{2083}"
            case "4":
                inputString += "\u{2084}"
            case "5":
                inputString += "\u{2085}"
            case "6":
                inputString += "\u{2086}"
            case "7":
                inputString += "\u{2087}"
            case "8":
                inputString += "\u{2088}"
            case "9":
                inputString += "\u{2089}"
            default:
                inputString += ""
            }
        } else {
            inputString = inputString + digit
        }
        
        display = inputString
    }
    //MARK: ClearAll()
    private func ClearAll(){    //resets all variables
        display = "0"
        display2 = ""
        powerColor = colorScheme == .dark ? .white : .black
        inputString = ""
    }
    //MARK: ClearOne()
    private func ClearOne(){ //deletes last input
        if (inputString.dropLast().last == "g" || inputString.dropLast().last == "S" || inputString.dropLast().last == "n" || inputString.dropLast().last == "s"){
            inputString.removeLast(5) //operators have spaces before and after them -> delete 3 chars
            display = inputString
        } else if (inputString.dropLast().last == "+" || inputString.dropLast().last == "-" || inputString.dropLast().last == "×" || inputString.dropLast().last == "/" || inputString.dropLast().last == "\u{221A}" || inputString.dropLast().last == "^"){
            inputString.removeLast(3) //operators have spaces before and after them -> delete 1 chars
            display = inputString
        } else {
            if(inputString != ""){
                inputString.removeLast()
            }
            display = inputString
        }
        if(inputString == ""){
            display = "0"
            ClearAll()
        }
    }
    
    var body: some View {
        GeometryReader{ geometry in
            VStack(spacing: 0){
               
                ScrollView(.horizontal, showsIndicators: false){
                    Text(display2.isEmpty ? " " : display2)
                        .font(.subheadline)
                        .foregroundStyle(Color.secondary)
                        .padding(.horizontal, 25)
                }
                .onTapGesture{
                    if display2 != "" {
                        inputString = display2
                        display = inputString
                        display2 = ""
                    }
                }
                
                HStack{
                    ScrollViewReader{ scr in
                        ScrollView(.horizontal, showsIndicators: true){
                            HStack{
                                Text(display)
                                
                                Text("")
                                    .id(0)
                            }
                            .font(.title3.bold())
                            .padding(.horizontal, 25)
                            .onChange(of: display) {
                                withAnimation(){
                                    scr.scrollTo(0)
                                }
                            }
                        }
                       
                    }
                }
                .padding(.top, 10)
                
                Spacer()
                    
                ViewThatFits(in: .vertical) {
                    VStack(spacing: 10){
                        Row1(geometry: geometry)
                        Row2(geometry: geometry)
                        Row3(geometry: geometry)
                        Row4(geometry: geometry)
                        Row5(geometry: geometry)
                        Row6(geometry: geometry)
                    }
                    
                    ViewThatFits(in: .vertical) {
                        VStack(spacing: 10){
                            Row1(geometry: geometry)
                            Row3(geometry: geometry)
                            Row4(geometry: geometry)
                            Row5(geometry: geometry)
                            Row6(geometry: geometry)
                        }
                        
                        VStack(spacing: 10){
                            Row3(geometry: geometry)
                            Row4(geometry: geometry)
                            Row5(geometry: geometry)
                            Row6(geometry: geometry)
                        }
                    }
                    
                }
                .padding(.bottom, 12)
            }
            .position(x: geometry.size.width/2, y: geometry.size.height/2)
        }
        
    }
    
    @ViewBuilder func Row1(geometry: GeometryProxy) -> some View {
        HStack(spacing: 15){
            CalculatorButton(size: geometry.size, text: "DEL", color: .gray) {
                ClearOne()
            }
            
            CalculatorButton(size: geometry.size, text: "(", color: .green) {
                logTrue = false
                addDigit(digit: "(")
            }
            
            CalculatorButton(size: geometry.size, text: ")", color: .green) {
                addDigit(digit: ")")
            }
            
            CalculatorButton(size: geometry.size, text: "a\u{207F}", color: .green) {
                if(powerTrue){
                    powerTrue = false
                    powerColor = colorScheme == .dark ? .white : .black
                } else {
                    powerTrue = true
                    powerColor = .gray
                }
                if(colorScheme == .dark){
                    powerColor = powerTrue ? .gray : .white
                } else {
                    powerColor = powerTrue ? .gray : .black
                }
            }
        }
    }
    
    @ViewBuilder func Row2(geometry: GeometryProxy) -> some View {
        HStack(spacing: 15){
            CalculatorButton(size: geometry.size, text: "sin", color: .green) {
                addDigit(digit: " sin ")
            }
            
            CalculatorButton(size: geometry.size, text: "cos", color: .green) {
                addDigit(digit: " cos ")
            }
            
            CalculatorButton(size: geometry.size, text: "tan", color: .green) {
                addDigit(digit: " tan ")
            }
            
            CalculatorButton(size: geometry.size, text: "log", color: .green) {
                addDigit(digit: " log ")
                logTrue = true
            }
        }
    }
    
    @ViewBuilder func Row3(geometry: GeometryProxy) -> some View {
        HStack(spacing: 15){
            CalculatorButton(size: geometry.size, text: "+", color: .green) {
                powerTrue = false
                addDigit(digit: " + ")
            }
            
            CalculatorButton(size: geometry.size, text: "1", color: .accentColor) {
                addDigit(digit: "1")
            }
            
            CalculatorButton(size: geometry.size, text: "2", color: .accentColor) {
                addDigit(digit: "2")
            }
            
            CalculatorButton(size: geometry.size, text: "3", color: .accentColor) {
                addDigit(digit: "3")
            }
        }
    }
    
    @ViewBuilder func Row4(geometry: GeometryProxy) -> some View {
        HStack(spacing: 15){
            CalculatorButton(size: geometry.size, text: "-", color: .green) {
                powerTrue = false
                addDigit(digit: " - ")
            }
            CalculatorButton(size: geometry.size, text: "4", color: .accentColor) {
                addDigit(digit: "4")
            }
            CalculatorButton(size: geometry.size, text: "5", color: .accentColor) {
                addDigit(digit: "5")
            }
            CalculatorButton(size: geometry.size, text: "6", color: .accentColor) {
                addDigit(digit: "6")
            }
            
        }
    }
    
    @ViewBuilder func Row5(geometry: GeometryProxy) -> some View {
        HStack(spacing: 15){
            CalculatorButton(size: geometry.size, text: "×", color: .green) {
                powerTrue = false
                addDigit(digit: " × ")
            }
            
            CalculatorButton(size: geometry.size, text: "7", color: .accentColor) {
                addDigit(digit: "7")
            }
            
            CalculatorButton(size: geometry.size, text: "8", color: .accentColor) {
                addDigit(digit: "8")
            }
            
            CalculatorButton(size: geometry.size, text: "9", color: .accentColor) {
                addDigit(digit: "9")
            }
        }
    }
    
    @ViewBuilder func Row6(geometry: GeometryProxy) -> some View {
        HStack(spacing: 15){
            CalculatorButton(size: geometry.size, text: "/", color: .green) {
                powerTrue = false
                addDigit(digit: " / ")
            }
            
            CalculatorButton(size: geometry.size, text: ".", color: .green) {
                inputString.append(".")
                display = inputString
                print(geometry.size.height)
            }
            
            CalculatorButton(size: geometry.size, text: "0", color: .accentColor) {
                addDigit(digit: "0")
            }
            
            CalculatorButton(size: geometry.size, text: "=", color: .gray) {
                if(display != "Syntax Error"){
                    powerColor = colorScheme == .dark ? .white : .black
                    inputString = autoAdd(str: inputString)
                    display = inputString
                    display2 = display
                    display = format(arg: String(calc.math(arg: inputString)))
                    inputString = ""
                    powerTrue = false
                }
            }
            
        }
    }
    
}
