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
    
    let calc : Calculator = Calculator()
    @State var powerTrue = false
    @State var logTrue = false
    @AppStorage("systemLanguage") var systemLanguage = 0 //0 ist EN, 1 ist DE, beeinflusst Punkt bzw. Komma, auch shortcut
    @AppStorage("input") var inputString = ""
    @AppStorage("display") var display = "0"
    @AppStorage("display2") var display2 = ""
    @AppStorage("calcContinue") var calcContinue = true
    @AppStorage("savedCalc") public var savedCalc: [String] = []
    @AppStorage("link") var link = false
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
        answerString = "= " + answerString
        return answerString
//        if(calcFuckedUp){
//            answerString = "Syntax Error"
//        }
    }
    //MARK: autoAdd()
    func autoAdd(str: String) -> String {
        var str = str
        @AppStorage("autoClosePar") var autoclosePar = true
        
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
                Spacer(minLength: 15) //use UITextField instead of Scrollview -> cursor possible, ask Dill
                HStack{
                    ScrollView(.horizontal, showsIndicators: false){ //allows me to scroll through longer inputs/outputs
                        HStack{
                            Text(display2)
                        }
                    }
                    .padding(.top, geometry.size.height > 605 ? 100 : 15)
                    .font(.system(size: geometry.size.width > 375 ? 30 : 25, design: .default))
                    .frame(width: geometry.size.width > 640 ? 560 : 270, height: UIDevice.current.userInterfaceIdiom == .phone ? geometry.size.width > 375 ? 33 : 40 : 70, alignment: .leading)
                    .onTapGesture{
                        if display2 != "" {
                            inputString = display2
                            display = inputString
                            display2 = ""
                        }
                    }
                    Rectangle()
                        .opacity(0)
                        .frame(width: 37, height: 20)
                }
                HStack{
                    ScrollViewReader{ scr in
                        ScrollView(.horizontal, showsIndicators: true){ //allows me to scroll through longer inputs/outputs
                            HStack{
                                Text("")
                                    .id(1)
                                
                                Text(display)
                                
                                Text("")
                                    .id(0)
                            }
                            .onChange(of: display) {
                                if(!display.contains("=")) {
                                    if(display.widthOfString(usingFont: UIFont.systemFont(ofSize: geometry.size.width > 640 ? 75 : 60)) > (geometry.size.width > 640 ? 560 : 270)) {
                                        withAnimation(){
                                            scr.scrollTo(0, anchor: .leading)
                                        }
                                    } else {
                                        scr.scrollTo(1, anchor: .bottom)
                                    }
                                } else {
                                    scr.scrollTo(1, anchor: .bottom)
                                }
                            }
                        }
                        .font(.system(size: display == "Syntax Error" || feedback1_de.contains(display) || feedback1_en.contains(display) || feedback0_de.contains(display) || feedback0_en.contains(display) ? 40 : geometry.size.width > 375 ? 75 : 50, weight: .semibold, design: .default))
                        .foregroundColor(display == "Syntax Error" || feedback1_de.contains(display) || feedback1_en.contains(display) || feedback0_de.contains(display) || feedback0_en.contains(display) ? .red : .primary)
                        .frame(width: geometry.size.width > 640 ? 560 : 270, height: geometry.size.width > 375 ? 80 : 55, alignment: .leading)
                        .padding(.top, geometry.size.height > 605 ? 35 : 0)
                    }
                    
                    if display2 != "" {
                        Button(action:{
                            pasteboard.string = "\(display2) \(display)"
                        }, label: {
                            Image(systemName: copyImage)
                                .font(.system(size: geometry.size.width > 375 ? 25 : 22))
                        })
                    }
                }
                //MARK: Buttons for entry
                VStack(spacing: 30){
                    
                    if(geometry.size.width < 640){
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
                        HStack(spacing: 15){
                            CalculatorButton(size: geometry.size, text: "DEL", color: .green) {
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
                    HStack(spacing: 15){
                        if(geometry.size.width > 640){
                            CalculatorButton(size: geometry.size, text: "(", color: .green) {
                                ClearAll()
                            }
                            .keyboardShortcut(.delete, modifiers: [.option])
                            CalculatorButton(size: geometry.size, text: "(", color: .green) {
                                ClearOne()
                            }
                            .keyboardShortcut(.delete, modifiers: [])
                            CalculatorButton(size: geometry.size, text: "(", color: .green) {
                                addDigit(digit: " ANS ")
                            }
                            .keyboardShortcut("a", modifiers: [])
                        }
                        CalculatorButton(size: geometry.size, text: "(", color: .green) {
                            powerTrue = false
                            addDigit(digit: " + ")
                        }
                        .keyboardShortcut("+", modifiers: [])
                        CalculatorButton(size: geometry.size, text: "(", color: .green) {
                            addDigit(digit: "1")
                        }
                        .keyboardShortcut("1", modifiers: [])
                        CalculatorButton(size: geometry.size, text: "(", color: .green) {
                            addDigit(digit: "2")
                        }
                        .keyboardShortcut("2", modifiers: [])
                        CalculatorButton(size: geometry.size, text: "(", color: .green) {
                            addDigit(digit: "3")
                        }
                        .keyboardShortcut("3", modifiers: [])
                    }
                    .foregroundColor(.white)
                    HStack(spacing: 15){
                        if(geometry.size.width > 640){
                            CalculatorButton(size: geometry.size, text: "(", color: .green) {
                                addDigit(digit: "π")
                            }
                            CalculatorButton(size: geometry.size, text: "(", color: .green) {
                                logTrue = false
                                addDigit(digit: "(")
                            }

                            CalculatorButton(size: geometry.size, text: "(", color: .green) {
                                addDigit(digit: ")")
                            }
                        }
                        CalculatorButton(size: geometry.size, text: "(", color: .green) {                            powerTrue = false
                            addDigit(digit: " - ")
                        }
                        CalculatorButton(size: geometry.size, text: "(", color: .green) {
                            addDigit(digit: "4")
                        }
                        CalculatorButton(size: geometry.size, text: "(", color: .green) {
                            addDigit(digit: "5")
                        }
                        CalculatorButton(size: geometry.size, text: "(", color: .green) {
                            addDigit(digit: "6")
                        }
                        
                    }
                    
                    HStack(spacing: 15){
                        if(geometry.size.width > 640){
                            CalculatorButton(size: geometry.size, text: "(", color: .green) {
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
                            .onChange(of: powerTrue) {
                                if(powerTrue){
                                    powerColor = .gray
                                } else {
                                    powerColor = colorScheme == .dark ? .white : .black
                                }
                            }
                            CalculatorButton(size: geometry.size, text: "(", color: .green) {
                                addDigit(digit: " sin ")
                            }
                            
                            CalculatorButton(size: geometry.size, text: "(", color: .green) {
                                addDigit(digit: " cos ")
                            }
                            
                        }
                        CalculatorButton(size: geometry.size, text: "(", color: .green) {
                            powerTrue = false
                            addDigit(digit: " × ")
                        }
                        .keyboardShortcut("*", modifiers: [])
                        CalculatorButton(size: geometry.size, text: "(", color: .green) {
                            addDigit(digit: "7")
                        }
                        .keyboardShortcut("7", modifiers: [])
                        CalculatorButton(size: geometry.size, text: "(", color: .green) {
                            addDigit(digit: "8")
                        }
                        .keyboardShortcut("8", modifiers: [])
                        CalculatorButton(size: geometry.size, text: "(", color: .green) {
                            addDigit(digit: "9")
                        }
                        .keyboardShortcut("9", modifiers: [])
                        
                    }
                    
                    HStack (spacing: 15){
                        if(geometry.size.width > 640){
                            CalculatorButton(size: geometry.size, text: "(", color: .green) {
                                addDigit(digit: " \u{221A} ")
                            }
                            .keyboardShortcut("p", modifiers: [.option])
                            CalculatorButton(size: geometry.size, text: "(", color: .green) {
                                addDigit(digit: " tan ")
                            }
                            .keyboardShortcut("t", modifiers: [])
                            CalculatorButton(size: geometry.size, text: "(", color: .green) {
                                addDigit(digit: " log ")
                                logTrue = true
                            }
                            .keyboardShortcut("l", modifiers: [])
                        }
                        CalculatorButton(size: geometry.size, text: "(", color: .green) {
                            powerTrue = false
                            addDigit(digit: " / ")
                        }
                        .keyboardShortcut("/", modifiers: [])
                        CalculatorButton(size: geometry.size, text: "(", color: .green) {
                            addDigit(digit: "0")
                        }
                        .keyboardShortcut("0", modifiers: [])
                        CalculatorButton(size: geometry.size, text: "(", color: .green) {
                            inputString = inputString + (systemLanguage == 0 ? "." : ",")
                            display = inputString
                            print(geometry.size.height)
                        }
                        
                        CalculatorButton(size: geometry.size, text: "(", color: .green) {
                            if(display != "Syntax Error"){
                                powerColor = colorScheme == .dark ? .white : .black
                                inputString = autoAdd(str: UserDefaults.standard.string(forKey: "input")!) //IMPORTANT
                                display = inputString
                                display2 = display
                                display = format(arg: String(calc.math(arg: inputString)))
                                inputString = ""
                                powerTrue = false
                            }
                        }
                        .keyboardShortcut(.return, modifiers: [])
                    }
                }
                
                Spacer(minLength: 20)
                
            }
            .padding(.top, 30)
            .padding(.bottom, UIDevice.current.userInterfaceIdiom == .pad ? 80 : 40 + (geometry.size.height - 598) / 4)
            .edgesIgnoringSafeArea(.all)
            .navigationTitle("")
            .position(x: geometry.size.width/2, y: geometry.size.height/2)
            //.sheet(isPresented: $welcome, content: {WelcomeView()})
        }
        .onChange(of: colorScheme) {
            powerColor = getColor()
        }
        .onAppear(){
//            if(opened){
//                ClearAll()
//                opened = false
//            }
            powerColor = colorScheme == .dark ? .white : .black
        }
        
    }
}
