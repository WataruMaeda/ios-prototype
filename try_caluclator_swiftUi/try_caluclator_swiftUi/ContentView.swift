//
//  ContentView.swift
//  try_caluclator_swiftUi
//
//  Created by Wataru Maeda on 2020/06/06.
//  Copyright © 2020 Wataru Maeda. All rights reserved.
//

import SwiftUI

enum CalculatorButton: String {
  case zero ,one, two, three, four, five, six, seven, eight, nine
  case equals, plus, minus, multiply, devide, dot
  case ac, plusMinus, percent

  var title: String {
    switch self {
      case .zero: return "0"
      case .one: return "1"
      case .two: return "2"
      case .three: return "3"
      case .four: return "4"
      case .five: return "5"
      case .six: return "6"
      case .seven: return "7"
      case .eight: return "8"
      case .nine: return "9"
      case .equals: return "="
      case .plus: return "+"
      case .minus: return "-"
      case .multiply: return "x"
      case .devide: return "÷"
      case .ac: return "AC"
      case .plusMinus: return "±"
      default: return "%"
    }
  }
  
  var backgroundColor: Color {
    switch self {
      case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine:
        return Color(.darkGray)
      case .ac, .plusMinus, .percent, .dot:
        return Color(.lightGray)
      default:
        return Color(.orange)
    }
  }
}

struct ContentView: View {
  
  let buttons: [[CalculatorButton]] = [
    [.ac, .plusMinus, .percent, .devide],
    [.seven, .eight, .nine, .multiply],
    [.four, .five, .six, .minus],
    [.one, .two, .three, .plus],
    [.zero, .zero, .dot, .plus],
  ]
  
  var body: some View {
    ZStack(alignment: .bottom) {
      
      Color.black.edgesIgnoringSafeArea(.all)
      
      VStack(spacing: 12) {
        HStack {
          Spacer()
          Text("42").font(.system(size: 64)).foregroundColor(.white)
        }.padding()
        
        ForEach(buttons, id: \.self) { row in
          HStack(spacing: 12) {
            ForEach(row, id: \.self) { button in
              
              Button(action: {
                // actions
              }) {
                Text(button.title).font(.system(size: 32))
                  .frame(width: self.buttonWidth(), height: self.buttonWidth())
                  .foregroundColor(.white)
                  .background(button.backgroundColor)
                  .cornerRadius(self.buttonWidth() / 2)
                
              }
              
            }
          }
        }
      }.padding(.bottom)
    }
  }
  
  func buttonWidth() -> CGFloat {
    return (UIScreen.main.bounds.width - 5 * 12) / 4
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
