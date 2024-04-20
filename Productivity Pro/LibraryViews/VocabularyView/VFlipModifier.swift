//
//  FlipModifier.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 22.12.23.
//

import SwiftUI

struct FlipOpacity: AnimatableModifier {
   var percentage: CGFloat = 0
   
   var animatableData: CGFloat {
      get { percentage }
      set { percentage = newValue }
   }
   
   func body(content: Content) -> some View {
      content
           .opacity(Double(percentage.rounded()))
   }
}
