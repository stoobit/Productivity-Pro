//
//  Calculator.swift
//  TurtleMaths_3.0
//
//  Created by Lukas Rischer on 29.05.23.
//

//MARK: *IMPORTANT*
/*
 Du kannst einfach mit math(arg: String) einen String reinhauen und kriegst einen Double als Ergebnis zurück
 */

import SwiftUI

@Observable final class Calculator {
    
    private var pass = false
    private var newOperation = ""
    private var operations: [String] = []
    private var answer: Double = 0
    private var answer2: Double = 0
    private var powerTrue = false
    private var logTrue = false
    private var SE = false
    private var calcFuckedUp = false
    private var fdUp = false
    private var inputString = ""
    
    let numbers: [Character] = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    let sctl: [Character] = ["s", "c", "t", "l"]
    let operators: [Character] = ["+", "-", "*", "/", "(", ")", "s", "c", "l", "o", "g", "t", "^", "r"]
    let powers: [Character] = ["\u{2070}", "\u{2074}", "\u{2075}", "\u{2076}", "\u{2077}", "\u{2078}", "\u{2079}", "\u{00B2}", "\u{00B3}", "\u{00B9}"]
    let specialOps: [String] = [",", "×", "sin", "cos", "log","tan","π","\u{221A}","\u{2070}","\u{00B9}","\u{00B2}","\u{00B3}","\u{2074}","\u{2075}","\u{2076}","\u{2077}","\u{2078}","\u{2079}","\u{2080}","\u{2081}","\u{2082}","\u{2083}","\u{2084}","\u{2085}","\u{2086}","\u{2087}","\u{2088}","\u{2089}"]
    let specialOpsRep: [String] = [ ".","*","s","c","l","t","3.14159265358979323","r","0","1","2","3","4","5","6","7","8","9","0","1","2","3","4","5","6","7","8","9"]
    
    public func math(arg : String) -> Double {
        pass = false
        newOperation = ""
        operations = []
        answer = 0
        answer2 = 0
        powerTrue = false
        logTrue = false
        SE = false
        inputString = arg
        removeSpaces()
        specialOperators()
        seperateOperations()
        inputString = ""
        if(!fuckedUp(str: operations.joined())){
            return calculate(operations: operations)
        } else {
            return 9999999999
        }
    }
    
    //MARK: removeSpaces()
    private func removeSpaces(){
        while(inputString.contains(" ")){
            inputString.remove(at: inputString.firstIndex(of: " ")!)
        } //removes the spaces
    }
    //MARK: seperateOperations()
    private func seperateOperations(){
        while(inputString != ""){
            newOperation = ""
            if(operators.contains(inputString.first!)){
                if(((inputString.first == "+" || inputString.first == "-") && (operations.last == "+"||operations.last == "-"||operations.last == "*"||operations.last == "/")) || ((inputString.first == "+" || inputString.first == "-") && (operations == []))){ //makes sure you can calculate with negative numbers
                    newOperation.append(inputString.remove(at: inputString.startIndex))
                    while(!operators.contains(inputString.first ?? "+")){
                        newOperation.append(inputString.remove(at: inputString.startIndex))
                    }
                } else {
                    newOperation.append(inputString.remove(at: inputString.startIndex))
                }
                if((operations.last == "s" || operations.last == "c" || operations.last == "t") && (newOperation == "-" || newOperation == "+")){
                    if(numbers.contains(inputString.first ?? "+")){
                        newOperation.append(inputString.remove(at: inputString.startIndex))
                        while(!operators.contains(inputString.first ?? "+")){
                            newOperation.append(inputString.remove(at: inputString.startIndex))
                        }
                    } else {
                        fdUp = true
                    }
                    
                }
            } else if(!operators.contains(inputString.first!)){
                while(!operators.contains(inputString.first ?? "+")){
                    newOperation.append(inputString.remove(at: inputString.startIndex))
                }
            }
            operations.append(newOperation) // adds new operation to array of all operations
        }
        var i = 1 //just making sure you can´t fuck up (is easier to implement here rather that at fuckedUp())
        while(i < operations.count-1){
            if((operations[i]=="+"||operations[i]=="-"||operations[i]=="/"||operations[i]=="*")&&(operations[i-1]=="+"||operations[i-1]=="-"||operations[i-1]=="/"||operations[i-1]=="*")){
                fdUp = true
            }
            i += 1
        }
    }
    //MARK: specialOperators()
    private func specialOperators(){
        var i = 0
        var trigger = false
        var index2 = " "
        for index in inputString{ //turns potentials into a^b
            if (isPower(set: String(index)) && !isPower(set: index2)){
                inputString.insert(contentsOf: "^", at: inputString.index(inputString.startIndex, offsetBy: i))
                i += 1
            } //while loops replace the <sup> characters with normal chars
            index2 = String(index)
            i += 1
        }
        i = 0
        while(i < inputString.count){
            if(inputString[inputString.index(inputString.startIndex, offsetBy: i)] == "g"){
                trigger = true
            }
            if(trigger && inputString[inputString.index(inputString.startIndex, offsetBy: i)] == "("){
                inputString.replaceSubrange(inputString.index(inputString.startIndex, offsetBy: i)...inputString.index(inputString.startIndex, offsetBy: i), with: "o")
            }
            if(trigger && inputString[inputString.index(inputString.startIndex, offsetBy: i)] == ")"){
                inputString.replaceSubrange(inputString.index(inputString.startIndex, offsetBy: i)...inputString.index(inputString.startIndex, offsetBy: i), with: "g")
            }
            i += 1
        }
        i = 0
        while(inputString.contains("ANS")){
            inputString.replace("ANS", with: String(answer2))
        }
        if(inputString == ""){
            inputString = "0"
        }
        while(inputString.contains("()")){
            inputString.replace("()", with: "(0)")
        }
        for name in specialOps {
            inputString = removeFromStr(str: inputString, op: name, newOp: specialOpsRep[i])
            i += 1
        }
    }
    //MARK: autoAdd()
    private func autoAdd(str: String) -> String {
        var str = str
        @AppStorage("autoClosePar") var autoclosePar = true
        
        if(autoclosePar){
            while(str.components(separatedBy: "(").count != str.components(separatedBy: ")").count){
                str.insert(str.components(separatedBy: "(").count > str.components(separatedBy: ")").count ? ")" : "(", at: str.components(separatedBy: "(").count > str.components(separatedBy: ")").count ? str.endIndex : str.startIndex)
            }
        }
        return str
    }
    //MARK: fuckedUp()
    private func fuckedUp(str: String) -> Bool{ //checks if there are SE
        SE = false
        var i = 0
        var counter = 0
        var trigger = false
        var triggerLog = false
        while(i < str.count){
            if(str[str.index(str.startIndex, offsetBy: i)] == "("){
                counter += 1
            }
            if(str[str.index(str.startIndex, offsetBy: i)] == ")"){
                counter -= 1
            }
            if(counter < 0){
                trigger = true
            }
            if(str[str.index(str.startIndex, offsetBy: i)] == "l"){
                triggerLog = true
            }
            if(str.count > i+1){
                if(numbers.contains(str[str.index(str.startIndex, offsetBy: i)]) && triggerLog){
                    if(str[str.index(str.startIndex, offsetBy: i+1)] == "o"){
                        triggerLog = false
                    }
                }
            }
            i += 1
        }
        if((trigger && counter == 0) || triggerLog){
            SE = true
            calcFuckedUp = true
            trigger = false
            triggerLog = false
        }
        i = 1
        
        while(i < str.count){
            if(str[str.index(str.startIndex, offsetBy: i - 1)] == "."){
                trigger = true
            }
            if(str[str.index(str.startIndex, offsetBy: i)] == "." && trigger){
                SE = true
                calcFuckedUp = true
                trigger = false
            }
            if(trigger && !numbers.contains(str[str.index(str.startIndex, offsetBy: i - 1)]) && str[str.index(str.startIndex, offsetBy: i - 1)] != "."){
                trigger = false
            }
            i += 1
        }
        trigger = false
        while(i < str.count){
            if(!numbers.contains(str[str.index(str.startIndex, offsetBy: i)]) && str.count > i + 1) {
                if(sctl.contains(str[str.index(str.startIndex, offsetBy: i)]) && sctl.contains(str[str.index(str.startIndex, offsetBy: i - 1)])){
                    SE = true
                    calcFuckedUp = true
                }
                if(i > 1){
                    if(str[str.index(str.startIndex, offsetBy: i - 2)] == "(" && sctl.contains(str[str.index(str.startIndex, offsetBy: i - 1)])){
                        SE = true
                        calcFuckedUp = true
                    }
                }
            }
            i += 1
        }
        
        if(str.contains("*/")||str.contains("**")||str.contains("//")||str.contains("/*")||str.first == "*"||str.first == "/"||str.last == "l"||str.last == "s"||str.last == "c"||str.last == "t"||str.components(separatedBy: "(").count != str.components(separatedBy: ")").count||str.last == "r"||str.contains("s^")||str.contains("c^")||str.contains("t^")||str.contains("l^") || str.contains("r^")||str.contains("r-")||str.contains("r(-")||str.contains("(^")||str.contains("s.")||str.contains("c.")||str.contains("t.")||str.contains("l.")||str.contains(".)")||str.contains(".s")||str.contains(".c")||str.contains(".t")||str.contains(".l")||str.contains("s)")||str.contains("t)")||str.contains("c)")||str.contains("l)")||str == "()"){
            SE = true
            calcFuckedUp = true
        }
        if(str.contains("s*")||str.contains("s/")||str.contains("c*")||str.contains("c/")||str.contains("t*")||str.contains("t/")||str.contains("l+")||str.contains("l-")||str.contains("l/")||str.contains("l*")||str.contains("+)")||str.contains("-)")||str.contains("*)")||str.contains("(*")||str.contains("(/")||str.contains("/)")||str.last == "+"||str.last == "-"||str.last == "*"||str.last == "/"||str.first == "*"||str.first == "/"||str.first == "."||str.first == "^"||str.last == "."||str.contains("^()")||str.contains("=")){
            SE = true
            calcFuckedUp = true
        }
        
        if(SE||fdUp == true){
            calcFuckedUp = true
            fdUp = false
            return true
        } else{
            return false
        }
    }
    //MARK: calculate()
    var test = false //tess if while loop was performed
    private func calculate(operations: [String]) -> Double{
        @AppStorage("angles") var angles = "deg"
        var operations = operations
        var calculation2:[String] = []
        while((operations.contains("+") || operations.contains("-") || operations.contains("*") || operations.contains("/") || operations.contains("s") || operations.contains("c") || operations.contains("l") || operations.contains("r") || operations.contains("t") || operations.contains("^")) && !fuckedUp(str: operations.joined())){
            pass = true
            test = true
            var operations2: [String] = [] // IMPORTANT set operations2 to nil again, so nothing breaks if the while loop is repeated
            var index = operations.lastIndex(of: "(") //gets last opening paranthesis (to follow order)
            if(operations.contains("(")){
                while(operations[index!] != ")"){    //gets the next calculation without the opening paranthesis, but with the closing paranthesis
                    index! += 1
                    operations2.append(operations[index!])
                }
                operations2.removeLast() // removes closing paranthesis
            } else{
                operations2 = operations //no parantheses -> straight forward calculation
            }
            while(operations2.contains("l")){ //logarithms
                index = operations2.firstIndex(of: "l")!
                var calculation: [String] = []
                calculation.append(operations2.remove(at: index!))
                calculation.append(operations2.remove(at: index!))
                calculation.append(operations2.remove(at: index!))
                while(operations2[index!] != "g"){
                    calculation2.append(operations2.remove(at: index!))
                }
                calculation.append(String(calculate(operations: calculation2)))
                calculation.append(operations2.remove(at: index!))
                
                answer = log(Double(calculation[3])!)/log(Double(calculation[1])!)
                operations2.insert(String(answer), at: index!)
            }
            while(operations2.contains("^")){ //potentials
                index = operations2.firstIndex(of: "^")!
                var calculation: [String] = []
                calculation.append(operations2.remove(at: (index!) - 1))
                calculation.append(operations2.remove(at: (index!) - 1))
                calculation.append(operations2.remove(at: (index!) - 1))
                
                answer = pow(Double(calculation[0])!, Double(calculation[2])!)
                operations2.insert(String(answer), at: operations2.index(before: Int(index!)))
            }
            while(operations2.contains("r") && !SE){ //root
                index = operations2.firstIndex(of: "r")!
                var calculation: [String] = []
                calculation.append(operations2.remove(at: (index!)))
                calculation.append(operations2.remove(at: (index!)))
                if(Double(calculation.joined().dropFirst()) ?? -1 > 0){
                    answer = (Double(calculation[1])!).squareRoot()
                    operations2.insert(String(answer), at: index!)
                } else {
                    SE = true
                }
            }
            while(operations2.contains("s") && !SE){
                index = operations2.firstIndex(of: "s")!
                var calculation: [String] = []
                calculation.append(operations2.remove(at: (index!)))
                calculation.append(operations2.remove(at: (index!)))
                if(angles == "deg"){
                    answer = sin(Double(calculation[1])! * Double.pi / 180)
                } else {
                    answer = sin(Double(calculation[1])!)
                }
                operations2.insert(String(answer), at: index!)
            } //sine
            while(operations2.contains("t")){
                index = operations2.firstIndex(of: "t")!
                var calculation: [String] = []
                calculation.append(operations2.remove(at: (index!)))
                calculation.append(operations2.remove(at: (index!)))
                if(angles == "deg"){
                    answer = tan(Double(calculation[1])! * Double.pi / 180)
                } else {
                    answer = tan(Double(calculation[1])!)
                }
                operations2.insert(String(answer), at: index!)
            } //tangent
            while(operations2.contains("c")){
                index = operations2.firstIndex(of: "c")!
                var calculation: [String] = []
                calculation.append(operations2.remove(at: (index!)))
                calculation.append(operations2.remove(at: (index!)))
                if(angles == "deg"){
                    answer = cos(Double(calculation[1])! * Double.pi / 180)
                } else {
                    answer = cos(Double(calculation[1])!)
                }
                operations2.insert(String(answer), at: index!)
            } //cosine
            while(operations2.contains("/")){
                index = operations2.firstIndex(of: "/")!
                var calculation: [String] = []
                calculation.append(operations2.remove(at: (index!) - 1))
                calculation.append(operations2.remove(at: (index!) - 1))
                calculation.append(operations2.remove(at: (index!) - 1))
                
                answer = Double(calculation[0])! / Double(calculation[2])!
                operations2.insert(String(answer), at: operations2.index(before: Int(index!)))
            } //division
            while(operations2.contains("*")){
                index = operations2.firstIndex(of: "*")!
                var calculation: [String] = []
                calculation.append(operations2.remove(at: (index!) - 1))
                calculation.append(operations2.remove(at: (index!) - 1))
                calculation.append(operations2.remove(at: (index!) - 1))
                
                answer = Double(calculation[0])! * Double(calculation[2])!
                operations2.insert(String(answer), at: operations2.index(before: Int(index!)))
            } //multiplication
            while(operations2.contains("-")){
                index = operations2.firstIndex(of: "-")!
                var calculation: [String] = []
                let helper = operations2.index(before: index!)
                if(helper == -1){
                    calculation.append("0")
                    calculation.append(operations2.remove(at: index!))
                    calculation.append(operations2.remove(at: index!))
                } else {
                    calculation.append(operations2.remove(at: (index!) - 1))
                    calculation.append(operations2.remove(at: (index!) - 1))
                    calculation.append(operations2.remove(at: (index!) - 1))
                }
                
                answer = Double(calculation[0])! - Double(calculation[2])!
                operations2.insert(String(answer), at: helper != -1 ? operations2.index(before: Int(index!)) : operations2.index(index!, offsetBy: 0))
            } //minus
            while(operations2.contains("+")){
                index = operations2.firstIndex(of: "+")!
                var calculation: [String] = []
                let helper = operations2.index(before: index!)
                if(helper == -1){
                    calculation.append("0")
                    calculation.append(operations2.remove(at: index!))
                    calculation.append(operations2.remove(at: index!))
                } else {
                    calculation.append(operations2.remove(at: (index!) - 1))
                    calculation.append(operations2.remove(at: (index!) - 1))
                    calculation.append(operations2.remove(at: (index!) - 1))
                }
                
                answer = Double(calculation[0])! + Double(calculation[2])!
                operations2.insert(String(answer), at: helper != -1 ? operations2.index(before: Int(index!)) : operations2.index(index!, offsetBy: 0))
            } //plus  //the while loops above do all the calculation in PEMDAS order
            index = operations.lastIndex(of: "(") ?? 0
            pass = true
            if(operations.contains("(")){ // removes the calculated subrange of operations from operations
                while(operations[index!] != ")"){
                    operations.remove(at: index!)
                }
                operations.remove(at: index!) // removes last paranthesis (not covered by while loop)
                operations.insert(contentsOf: operations2, at: index ?? 0) //inserts the calculated part (operations2) into operations
            } else{
                operations = operations2 //finished with all the calculations
            }
        }
        if(operations == []){
            operations.append("0")
        }
        while(operations.contains("(")){
            operations.removeFirst()
            operations.removeLast()
        }
        return round(Double(operations[0])! * 100000000000000.0) / 100000000000000.0
    }
    //MARK: isPower()
    private func isPower(set: String) -> Bool { // checks if string contains a power
        var isPower = false
        for name in powers{
            if set.contains(name){
                isPower = true
            }
        }
        return isPower
    }
    //MARK: removeFromStr()
    private func removeFromStr(str: String, op: String, newOp: String) -> String {
        var str = str
        while(str.contains(op)){
            str.replace(op, with: newOp)
        }
        return str
    }
}
