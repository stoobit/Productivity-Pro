//
//  File.swift
//
//
//  Created by Till Brügmann on 02.11.23.
//

import SwiftUI

struct PPAnglePickerView: View {
    @Environment(ToolManager.self) var toolManager
    
    @State private var buttons: Bool = true
    @State private var angleState: String = "0.0"
    
    @State var degrees: Double = 0
    @Binding var item: Double
    
    var body: some View {
        ZStack {
            if buttons {
                ForEach(0 ... 7, id: \.self) { value in
                    Button(action: {
                        degrees = Double(45 * value)
                        item = Double(45 * value)
                        
                        toolManager.update += 1
                    }) {
                        Rectangle()
                            .foregroundStyle(.clear)
                            .clipShape(Rectangle())
                            .frame(width: 60, height: 20)
                            .overlay {
                                Circle()
                                    .trim(
                                        from: 4/8 + 0.02,
                                        to: 5/8 - 0.02
                                    )
                                    .stroke(
                                        style: StrokeStyle(
                                            lineWidth: 10, lineCap: .round
                                        )
                                    )
                                    .frame(width: 200, height: 200)
                                    .rotationEffect(Angle(degrees: 67.5))
                                    .offset(y: 100)
                                    .allowsHitTesting(false)
                            }
                    }
                    .offset(y: -100)
                    .rotationEffect(Angle(degrees: 45 * Double(value)))
                }
                .transition(.asymmetric(
                    insertion: .scale,
                    removal: .identity
                ))
                
            } else {
                ZStack {
                    Circle()
                        .stroke(
                            style: StrokeStyle(
                                lineWidth: 10, lineCap: .round
                            )
                        )
                        .frame(width: 200, height: 200)
                        .foregroundStyle(Color.accentColor)
                    
                    Circle()
                        .frame(width: 25, height: 25)
                        .foregroundStyle(Color.gray)
                        .shadow(radius: 5)
                        .offset(getOffset())
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { value in
                                    change(location: value.location)
                                }
                                .onEnded { _ in
                                    self.item = self.degrees
                                    toolManager.update += 1
                                }
                        )
                }
                .transition(.asymmetric(
                    insertion: .scale,
                    removal: .identity
                ))
            }
            
            VStack(spacing: 10) {
                Text(angleState)
                    .monospacedDigit()
                    .font(.largeTitle.bold())
                    .foregroundStyle(Color.primary)
                    .onChange(of: degrees, initial: true) {
                        angleState = String(degrees)
                    }
                
                Button(action: { withAnimation(.bouncy) { buttons.toggle() } }) {
                    Image(systemName: "slider.horizontal.2.rectangle.and.arrow.triangle.2.circlepath")
                        .imageScale(.large)
                }
            }
        }
        .onAppear {
            degrees = item
        }
    }
    
    func getOffset() -> CGSize {
        var offset: CGSize = .zero
        
        offset.width = cos(degrees: degrees - 90) * 100
        offset.height = sin(degrees: degrees - 90) * 100
        
        return offset
    }
    
    func sin(degrees: Double) -> Double {
        return __sinpi(degrees/180.0)
    }
    
    func cos(degrees: Double) -> Double {
        return __cospi(degrees/180.0)
    }
    
    private func change(location: CGPoint) {
        let vector = CGVector(dx: location.x, dy: location.y)
        let angle = atan2(vector.dy, vector.dx) + .pi/2.0
        let fixedAngle = angle < 0.0 ? angle + 2.0 * .pi : angle
        let value = fixedAngle/(2.0 * .pi) * 360
        
        if value >= 0 && value <= 360 {
            degrees = fixedAngle * 180 / .pi
            degrees = degrees.rounded(toPlaces: 1)
        }
    }
}
