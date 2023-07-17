//
//  TouchType.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 02.10.22.
//

import SwiftUI

extension UITouch.TouchType: CustomStringConvertible {
    public var description: String { self == .direct ? "Touch" : "Pencil" }
}

class TouchType: UITapGestureRecognizer {
    let touchType: Binding<UITouch.TouchType>
    init(_ touchType: Binding<UITouch.TouchType>) {
        self.touchType = touchType
        super.init(target: (), action: nil)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        touchType.wrappedValue = touches.first?.type ?? .direct
    }
}

struct TouchTypeWrapper: UIViewRepresentable {
    let view: UIView
    func makeUIView(context: Context) -> some UIView { view }
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}

struct TouchTypeModifier: ViewModifier {
    @Binding var touchType: UITouch.TouchType

    func body(content: Content) -> some View {

        guard let view = UIHostingController(rootView: content).view else { return AnyView(content) }
        view.addGestureRecognizer(TouchType($touchType))
        return AnyView(TouchTypeWrapper(view: view))

    }
}
