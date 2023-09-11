//
//  SchduleView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 11.09.23.
//

import SwiftUI

struct ScheduleView: View {
    
    var size: CGSize
    var width: CGFloat {
        if size.width > size.height {
            return size.width
        } else {
            return size.height
        }
    }
    
    var body: some View {
        Text("\(width)")
    }
}

#Preview {
    ScheduleViewContainer()
}
