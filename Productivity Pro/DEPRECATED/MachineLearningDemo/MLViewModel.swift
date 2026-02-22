//
//  MLViewModel.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 12.01.26.
//

import PencilKit
import Vision
import CoreML
import CoreImage

@Observable final class MLViewModel {
    var canvas: PKCanvasView = PKCanvasView()
    var isReplacing: Bool = false
    
    func reset() {
        self.canvas.drawing = PKDrawing()
    }
    
    func predict(for canvas: PKCanvasView) {
        guard let image = render(canvas: canvas), let result = process(image) else {
            return
        }
        
        replace(shape: result, in: canvas)
    }
    
    private func replace(shape: String, in canvas: PKCanvasView) {
        isReplacing = true
    
        print("Shape: \(shape)")
        
        switch shape {
        case "circle":
            canvas.replaceLastStrokeWithCircle()
        case "triangle":
            canvas.replaceLastStrokeWithTriangle()
        case "rectangle":
            canvas.replaceLastStrokeWithSquare()
        default:
            print("error")
        }
        
        isReplacing = false
    }
    
    private func render(canvas: PKCanvasView) -> UIImage?  {
        guard let lastStroke = canvas.drawing.strokes.last else {
            return nil
        }
        
        let bounds = lastStroke.renderBounds
        let maxSide = max(bounds.width, bounds.height)
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        
        let squareBounds = CGRect(
            x: center.x - maxSide / 2,
            y: center.y - maxSide / 2,
            width: maxSide,
            height: maxSide
        )
        
        let copy = PKCanvasView()
        copy.drawing.strokes = [lastStroke]
        
        let image = copy.drawing.image(from: squareBounds, scale: 2)
        
        if getSystemAppearance() == .light {
            if let inverted = image.inverted {
                return inverted
            }
        }
        
        return image
    }

    
    private func process(_ uiImage: UIImage) -> String? {
//        guard let cgImage = uiImage.cgImage else { return nil }
//        let ciImage = CIImage(cgImage: cgImage)
//        
//        let configuartion = MLModelConfiguration()
//        
//        guard let model = try? VNCoreMLModel(
//            for: shapes(configuration: configuartion).model
//        ) else { return nil }
//        
//        let request = VNCoreMLRequest(model: model)
//        let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
//        
//        try? handler.perform([request])
//        
//        guard let results = request.results as? [
//            VNClassificationObservation
//        ] else { return nil }
//        
//        guard let result = results.first else { return nil }
        return nil
    }
    
    private func getSystemAppearance() -> UIUserInterfaceStyle {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return .unspecified
        }
        
        return window.traitCollection.userInterfaceStyle
    }
}

extension PKCanvasView {
    func replaceLastStrokeWithTriangle() {
        guard let lastStroke = self.drawing.strokes.last else { return }
        
        let bounds = lastStroke.renderBounds
        let maxSide = max(bounds.width, bounds.height)
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let targetSize = lastStroke.path.first?.size ?? CGSize(width: 5, height: 5)
        
        // --- GEOMETRY CHANGE START ---
        // Fit Height: We fix the height to maxSide, and calculate the width to maintain equilateral shape.
        let triangleHeight = maxSide
        let triangleBase = triangleHeight * (2.0 / sqrt(3.0))
        
        let halfBase = triangleBase / 2.0
        let halfHeight = triangleHeight / 2.0
        
        let p1 = CGPoint(x: center.x, y: center.y - halfHeight)            // Top
        let p2 = CGPoint(x: center.x + halfBase, y: center.y + halfHeight) // Bottom Right
        let p3 = CGPoint(x: center.x - halfBase, y: center.y + halfHeight) // Bottom Left
        // --- GEOMETRY CHANGE END ---
        
        var allPoints = [PKStrokePoint]()
        var accumulatedTime: TimeInterval = 0.0
        let stepSize: CGFloat = 2.0
        
        func addLine(from: CGPoint, to: CGPoint) {
            let distance = hypot(to.x - from.x, to.y - from.y)
            let steps = Int(distance / stepSize)
            
            for i in 0...steps {
                let t = CGFloat(i) / CGFloat(steps)
                let x = from.x + (to.x - from.x) * t
                let y = from.y + (to.y - from.y) * t
                
                accumulatedTime += 0.005
                
                let strokePoint = PKStrokePoint(
                    location: CGPoint(x: x, y: y),
                    timeOffset: accumulatedTime,
                    size: targetSize,
                    opacity: 1.0, force: 1.0, azimuth: 0, altitude: 0
                )
                allPoints.append(strokePoint)
            }
        }
        
        addLine(from: p1, to: p2)
        addLine(from: p2, to: p3)
        addLine(from: p3, to: p1)
        
        let strokePath = PKStrokePath(controlPoints: allPoints, creationDate: Date())
        let newTriangleStroke = PKStroke(ink: lastStroke.ink, path: strokePath)
        
        var currentStrokes = self.drawing.strokes
        currentStrokes.removeLast()
        currentStrokes.append(newTriangleStroke)
        
        self.drawing = PKDrawing(strokes: currentStrokes)
    }
    
    func replaceLastStrokeWithSquare() {
        guard let lastStroke = self.drawing.strokes.last else { return }
        
        // 1. Calculate Bounds
        let bounds = lastStroke.renderBounds
        let maxSide = max(bounds.width, bounds.height)
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let targetSize = lastStroke.path.first?.size ?? CGSize(width: 5, height: 5)
        
        // 2. Define Vertices (Square centered on the stroke)
        let halfSide = maxSide / 2.0
        let p1 = CGPoint(x: center.x - halfSide, y: center.y - halfSide) // Top Left
        let p2 = CGPoint(x: center.x + halfSide, y: center.y - halfSide) // Top Right
        let p3 = CGPoint(x: center.x + halfSide, y: center.y + halfSide) // Bottom Right
        let p4 = CGPoint(x: center.x - halfSide, y: center.y + halfSide) // Bottom Left
        
        // 3. Interpolation Logic
        var allPoints = [PKStrokePoint]()
        var accumulatedTime: TimeInterval = 0.0
        let stepSize: CGFloat = 2.0
        
        func addLine(from: CGPoint, to: CGPoint) {
            let distance = hypot(to.x - from.x, to.y - from.y)
            let steps = Int(distance / stepSize)
            
            for i in 0...steps {
                let t = CGFloat(i) / CGFloat(steps)
                let x = from.x + (to.x - from.x) * t
                let y = from.y + (to.y - from.y) * t
                
                accumulatedTime += 0.005
                
                let strokePoint = PKStrokePoint(
                    location: CGPoint(x: x, y: y),
                    timeOffset: accumulatedTime,
                    size: targetSize,
                    opacity: 1.0, force: 1.0, azimuth: 0, altitude: 0
                )
                allPoints.append(strokePoint)
            }
        }
        
        // 4. Build Path
        addLine(from: p1, to: p2)
        addLine(from: p2, to: p3)
        addLine(from: p3, to: p4)
        addLine(from: p4, to: p1) // Close the loop
        
        // 5. Create Stroke & Update
        let strokePath = PKStrokePath(controlPoints: allPoints, creationDate: Date())
        let newSquareStroke = PKStroke(ink: lastStroke.ink, path: strokePath)
        
        var currentStrokes = self.drawing.strokes
        currentStrokes.removeLast()
        currentStrokes.append(newSquareStroke)
        
        self.drawing = PKDrawing(strokes: currentStrokes)
    }
    
    func replaceLastStrokeWithCircle() {
        guard let lastStroke = self.drawing.strokes.last else { return }
        
        // 1. Calculate Bounds
        let bounds = lastStroke.renderBounds
        let maxSide = max(bounds.width, bounds.height)
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let targetSize = lastStroke.path.first?.size ?? CGSize(width: 5, height: 5)
        
        // 2. Define Geometry
        let radius = maxSide / 2.0
        
        // 3. Interpolation Logic
        var allPoints = [PKStrokePoint]()
        var accumulatedTime: TimeInterval = 0.0
        
        // Calculate how many points we need to keep the 2px density
        let circumference = 2 * CGFloat.pi * radius
        let stepCount = Int(circumference / 2.0) // Maintain 2px density
        let angleStep = (2 * CGFloat.pi) / CGFloat(stepCount)
        
        // 4. Build Path (Loop through 360 degrees)
        for i in 0...stepCount {
            // Start from -PI/2 (top of circle) so it draws naturally
            let angle = CGFloat(i) * angleStep - (CGFloat.pi / 2)
            
            let x = center.x + radius * cos(angle)
            let y = center.y + radius * sin(angle)
            
            accumulatedTime += 0.005
            
            let strokePoint = PKStrokePoint(
                location: CGPoint(x: x, y: y),
                timeOffset: accumulatedTime,
                size: targetSize,
                opacity: 1.0, force: 1.0, azimuth: 0, altitude: 0
            )
            allPoints.append(strokePoint)
        }
        
        // 5. Create Stroke & Update
        let strokePath = PKStrokePath(controlPoints: allPoints, creationDate: Date())
        let newCircleStroke = PKStroke(ink: lastStroke.ink, path: strokePath)
        
        var currentStrokes = self.drawing.strokes
        currentStrokes.removeLast()
        currentStrokes.append(newCircleStroke)
        
        self.drawing = PKDrawing(strokes: currentStrokes)
    }
}

extension UIImage {
    var inverted: UIImage? {
        // 1. Convert to CIImage
        // We use 'CIImage(image:)' or 'ciImage' property if it already exists
        guard let ciImage = CIImage(image: self) ?? self.ciImage else { return nil }
        
        // 2. Create the specific filter
        guard let filter = CIFilter(name: "CIColorInvert") else { return nil }
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        
        // 3. Get the output image
        guard let outputImage = filter.outputImage else { return nil }
        
        // 4. Render the image back to UIImage
        // Note: We create a temporary CIContext to render the final image.
        // For heavy usage, create a shared CIContext to improve performance.
        let context = CIContext()
        
        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            return UIImage(cgImage: cgImage)
        }
        
        return nil
    }
}
