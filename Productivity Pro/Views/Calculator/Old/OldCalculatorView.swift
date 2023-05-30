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

struct OldCalculatorView: View {
    
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
                            .onChange(of: display) { _ in
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
                VStack(spacing: UIDevice.current.userInterfaceIdiom == .phone ? geometry.size.height/80 : 20){ //VStack of HStacks to make a grid of buttons
                    if(geometry.size.height > 375){
                        Spacer(minLength: 0)
                    }
                    if(geometry.size.width < 640){
                        HStack(spacing: 15){
                            MyButton3(symbol: "sin", size: 25){
                                addDigit(digit: " sin ")
                            }
                            .keyboardShortcut("s", modifiers: [])
                            MyButton3(symbol: "cos", size: 25){
                                addDigit(digit: " cos ")
                            }
                            .keyboardShortcut("c", modifiers: [])
                            MyButton3(symbol: "tan", size: 25){
                                addDigit(digit: " tan ")
                            }
                            .keyboardShortcut("t", modifiers: [])
                            MyButton3(symbol: "log", size: 25){
                                addDigit(digit: " log ")
                                logTrue = true
                            }
                            .keyboardShortcut("l", modifiers: [])
                        }
                        HStack(spacing: 15){
                            MyButton4(symbol: "trash.square"){}
                                .simultaneousGesture(
                                    LongPressGesture()
                                        .onEnded { _ in
                                            ClearAll()
                                        })
                                .highPriorityGesture(TapGesture()
                                    .onEnded { _ in
                                        ClearOne()
                                    })
                            MyButton3(symbol: "(", size: 35){
                                logTrue = false
                                addDigit(digit: "(")
                            }
                            .keyboardShortcut("(", modifiers: [])
                            MyButton3(symbol: ")", size: 35){
                                addDigit(digit: ")")
                            }
                            .keyboardShortcut(")", modifiers: [])
                            Button {
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
                            } label: {
                                Text("x\u{1D43}")
                                    .font(.system(size: 30, design: .rounded).bold())
                                    .frame(width: 50, height: 50, alignment: .center)
                                    .foregroundColor(colorScheme == .dark ? .black : .white)
                                    .overlay{
                                        Image.init(systemName: "square")
                                            .resizable()
                                            .frame(width: 50, height: 50, alignment: .center)
                                            .foregroundColor(colorScheme == .dark ? .black : .white)
                                    }
                                
                            }
                            .frame(width: 70, height: 70)
                            .background(powerColor)
                            .cornerRadius(15)
                            .keyboardShortcut("p", modifiers: [])
                        }
                        
                    }
                    HStack(spacing: 15){
                        if(geometry.size.width > 640){
                            MyButton4(symbol: "trash.square"){
                                ClearAll()
                            }
                            .keyboardShortcut(.delete, modifiers: [.option])
                            MyButton4(symbol: "delete.left"){
                                ClearOne()
                            }
                            .keyboardShortcut(.delete, modifiers: [])
                            MyButton3(symbol: "ANS", size: 20){
                                addDigit(digit: " ANS ")
                            }
                            .keyboardShortcut("a", modifiers: [])
                        }
                        MyButton1(symbol: "plus.square") {
                            powerTrue = false
                            addDigit(digit: " + ")
                        }
                        .keyboardShortcut("+", modifiers: [])
                        MyButton2(symbol: "1.square"){
                            addDigit(digit: "1")
                        }
                        .keyboardShortcut("1", modifiers: [])
                        MyButton2(symbol: "2.square"){
                            addDigit(digit: "2")
                        }
                        .keyboardShortcut("2", modifiers: [])
                        MyButton2(symbol: "3.square"){
                            addDigit(digit: "3")
                        }
                        .keyboardShortcut("3", modifiers: [])
                    }
                    .foregroundColor(.white)
                    HStack(spacing: 15){
                        if(geometry.size.width > 640){
                            MyButton3(symbol: "π", size: 35){
                                addDigit(digit: "π")
                            }
                            MyButton3(symbol: "(", size: 35){
                                logTrue = false
                                addDigit(digit: "(")
                            }
                            .keyboardShortcut("(", modifiers: [])
                            MyButton3(symbol: ")", size: 35){
                                addDigit(digit: ")")
                            }
                            .keyboardShortcut(")", modifiers: [])
                        }
                        MyButton1(symbol: "minus.square"){
                            powerTrue = false
                            addDigit(digit: " - ")
                        }
                        .keyboardShortcut("-", modifiers: [])
                        MyButton2(symbol: "4.square"){
                            addDigit(digit: "4")
                        }
                        .keyboardShortcut("4", modifiers: [])
                        MyButton2(symbol: "5.square"){
                            addDigit(digit: "5")
                        }
                        .keyboardShortcut("5", modifiers: [])
                        MyButton2(symbol: "6.square"){
                            addDigit(digit: "6")
                        }
                        .keyboardShortcut("6", modifiers: [])
                        
                    }
                    
                    HStack(spacing: 15){
                        if(geometry.size.width > 640){
                            Button {
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
                            } label: {
                                Text("x\u{1D43}")
                                    .font(.system(size: 30).bold())
                                    .frame(width: 50, height: 50, alignment: .center)
                                    .foregroundColor(colorScheme == .dark ? .black : .white)
                                    .overlay{
                                        Image.init(systemName: "square")
                                            .resizable()
                                            .frame(width: 50, height: 50, alignment: .center)
                                            .foregroundColor(colorScheme == .dark ? .black : .white)
                                    }
                                
                            }
                            .frame(width: 70, height: 70)
                            .background(powerColor)
                            .cornerRadius(15)
                            .keyboardShortcut("p", modifiers: [])
                            .onChange(of: powerTrue, perform: { _ in
                                if(powerTrue){
                                    powerColor = .gray
                                } else {
                                    powerColor = colorScheme == .dark ? .white : .black
                                }
                            })
                            MyButton3(symbol: "sin", size: 25){
                                addDigit(digit: " sin ")
                            }
                            .keyboardShortcut("s", modifiers: [])
                            MyButton3(symbol: "cos", size: 25){
                                addDigit(digit: " cos ")
                            }
                            .keyboardShortcut("c", modifiers: [])
                        }
                        MyButton1(symbol: "multiply.square"){
                            powerTrue = false
                            addDigit(digit: " × ")
                        }
                        .keyboardShortcut("*", modifiers: [])
                        MyButton2(symbol: "7.square"){
                            addDigit(digit: "7")
                        }
                        .keyboardShortcut("7", modifiers: [])
                        MyButton2(symbol: "8.square"){
                            addDigit(digit: "8")
                        }
                        .keyboardShortcut("8", modifiers: [])
                        MyButton2(symbol: "9.square"){
                            addDigit(digit: "9")
                        }
                        .keyboardShortcut("9", modifiers: [])
                        
                    }
                    
                    HStack (spacing: 15){
                        if(geometry.size.width > 640){
                            MyButton3(symbol: "\u{221A}x", size: 25){
                                addDigit(digit: " \u{221A} ")
                            }
                            .keyboardShortcut("p", modifiers: [.option])
                            MyButton3(symbol: "tan", size: 25){
                                addDigit(digit: " tan ")
                            }
                            .keyboardShortcut("t", modifiers: [])
                            MyButton3(symbol: "log", size: 25){
                                addDigit(digit: " log ")
                                logTrue = true
                            }
                            .keyboardShortcut("l", modifiers: [])
                        }
                        MyButton1(symbol: "divide.square"){
                            powerTrue = false
                            addDigit(digit: " / ")
                        }
                        .keyboardShortcut("/", modifiers: [])
                        MyButton2(symbol: "0.square"){
                            addDigit(digit: "0")
                        }
                        .keyboardShortcut("0", modifiers: [])
                        Button {
                            inputString = inputString + (systemLanguage == 0 ? "." : ",")
                            display = inputString
                            print(geometry.size.height)
                        } label: {
                            Text(systemLanguage == 0 ? "." : ",")
                                .font(.system(size: 30, design: .rounded).bold())
                                .frame(width: 50, height: 50, alignment: .center)
                                .foregroundColor(colorScheme == .dark ? .black : .white)
                                .overlay{
                                    Image.init(systemName: "square")
                                        .resizable()
                                        .frame(width: 50, height: 50, alignment: .center)
                                        .foregroundColor(colorScheme == .dark ? .black : .white)
                                }
                        }
                        .keyboardShortcut(systemLanguage == 0 ? "." : ",", modifiers: [])
                        .frame(width: 70, height: 70)
                        .background(getcalcCS(currentCS: colorScheme))
                        .cornerRadius(15)
                        MyButton2(symbol: "equal.square"){
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
        .onChange(of: colorScheme){ newValue in
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
