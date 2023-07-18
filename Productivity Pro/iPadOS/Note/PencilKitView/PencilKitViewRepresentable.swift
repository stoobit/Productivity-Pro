//
//  DrawingViewRepresentable.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 16.04.23.
//

import SwiftUI
import PencilKit
import CoreML
import Vision
import ImageIO

struct DrawingViewRepresentable: UIViewRepresentable {
    
    var size: CGSize
    
    @Binding var page: Page
    @StateObject var toolManager: ToolManager
    @StateObject var subviewManager: SubviewManager
    
    @Binding var canvasView: PKCanvasView
    @Binding var toolPicker: PKToolPicker
    
    @Binding var drawingChanged: Bool
    @Binding var strokeCount: Int
    
    func makeUIView(context: Context) -> PKCanvasView {
        
        canvasView.delegate = context.coordinator
        
        canvasView.backgroundColor = .clear
        canvasView.bouncesZoom = false
        canvasView.isScrollEnabled = false
        
        canvasView.showsVerticalScrollIndicator = false
        canvasView.showsHorizontalScrollIndicator = false
        
        toolPicker.showsDrawingPolicyControls = false
        canvasView.drawingPolicy = .pencilOnly

        adoptScale()
        
        try? canvasView.drawing = PKDrawing(data: page.canvas)
        
        canvasView.overrideUserInterfaceStyle = colorScheme()
        toolPicker.colorUserInterfaceStyle = colorScheme()
        
        toolManager.zoomScale = 1
        canvasView.bounds.size = CGSize(
            width: getFrame().width * toolManager.zoomScale,
            height: getFrame().height * toolManager.zoomScale
        )
        
        strokeCount = canvasView.drawing.strokes.count
        return canvasView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        
        if toolManager.isEditorVisible == false {
            toolPicker.isRulerActive = false
            canvasView.isRulerActive = false
        }
        
        if canvasView.zoomScale != toolManager.zoomScale {
            canvasView.setZoomScale(toolManager.zoomScale, animated: false)
        }
        
        if toolManager.isLocked {
            uiView.pinchGestureRecognizer?.isEnabled = false
        } else {
            uiView.pinchGestureRecognizer?.isEnabled = true
        }
        
        canvasView.overrideUserInterfaceStyle = colorScheme()
        toolPicker.colorUserInterfaceStyle = colorScheme()
        
        adoptScale()
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(
            drawingChanged: $drawingChanged,
            toolPicker: $toolPicker,
            objectRecognitionEnabled: $toolManager.objectRecognitionEnabled,
            strokeCount: $strokeCount
        )
    }
    
    class Coordinator: NSObject, PKCanvasViewDelegate {
        var update: Bool = true
        
        @Binding var drawingChanged: Bool
        @Binding var toolPicker: PKToolPicker
        
        @Binding var objectRecognitionEnabled: Bool
        @Binding var strokeCount: Int
        
        init(
            drawingChanged: Binding<Bool>,
            toolPicker: Binding<PKToolPicker>,
            objectRecognitionEnabled: Binding<Bool>,
            strokeCount: Binding<Int>
        ) {
            _drawingChanged = drawingChanged
            _toolPicker = toolPicker
            _objectRecognitionEnabled = objectRecognitionEnabled
            _strokeCount = strokeCount
        }
        
        func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
            if update {
                update = false
                drawingChanged = true
                
                if objectRecognitionEnabled && strokeCount < canvasView.drawing.strokes.count {
                    recognizeObject(canvasView)
                }
                
                strokeCount = canvasView.drawing.strokes.count
                update = true
            }
        }
        
        @objc func recognizeObject(_ gestureRecognizer: UIGestureRecognizer) {
            print("recognition")
        }
        
        func recognizeObject(_ canvasView: PKCanvasView) {
            do {
                
                guard let bounds = canvasView.drawing.strokes.last?.renderBounds else {
                    return
                }
                
                let canvasCopy = PKCanvasView()
                canvasCopy.drawing.strokes = [canvasView.drawing.strokes.last!]
                
                let uiImage = canvasCopy.drawing.image(from: bounds, scale: 1)
                guard let cgImage = uiImage.cgImage else { return }
                
                let model = try VNCoreMLModel(
                    for: ObjectRecognition(configuration: MLModelConfiguration()).model
                )
                
                let request = VNCoreMLRequest(model: model)
                let handler = VNImageRequestHandler(cgImage: cgImage)
                
                try handler.perform([request])
                guard let results = request.results else { return }
                
                let detections = results as! [VNClassificationObservation]
                if let shape = detections.first?.identifier {
                    print("ML: \(shape)")
                    replace(shape, in: canvasView)
                }
                
            } catch {
                print("ML: There was an error.")
            }
        }
        
        func replace(_ shape: String, in canvasView: PKCanvasView) {
            guard let userDrawing = canvasView.drawing.strokes.last else { return }
            
            if shape == "rect" {
                var newStroke = userDrawing
                newStroke.ink = userDrawing.ink
               
                var points: [PKStrokePoint] = [
                    PKStrokePoint(
                        location: CGPoint(
                            x: userDrawing.renderBounds.minX,
                            y: userDrawing.renderBounds.minY
                        ),
                        timeOffset: 0,
                        size: CGSize(width: 5, height: 5),
                        opacity: 1,
                        force: 1,
                        azimuth: 0,
                        altitude: 0
                    ),
                    PKStrokePoint(
                        location: CGPoint(
                            x: userDrawing.renderBounds.minX,
                            y: userDrawing.renderBounds.maxY
                        ),
                        timeOffset: 0,
                        size: CGSize(width: 5, height: 5),
                        opacity: 1,
                        force: 1,
                        azimuth: 0,
                        altitude: 0
                    ),
                ]
                
                newStroke.path = PKStrokePath(controlPoints: points, creationDate: Date())
                canvasView.drawing.strokes.append(newStroke)
                
               points = [
                    PKStrokePoint(
                        location: CGPoint(
                            x: userDrawing.renderBounds.minX,
                            y: userDrawing.renderBounds.maxY
                        ),
                        timeOffset: 0,
                        size: CGSize(width: 5, height: 5),
                        opacity: 1,
                        force: 1,
                        azimuth: 0,
                        altitude: 0
                    ),
                    PKStrokePoint(
                        location: CGPoint(
                            x: userDrawing.renderBounds.maxX,
                            y: userDrawing.renderBounds.maxY
                        ),
                        timeOffset: 0,
                        size: CGSize(width: 5, height: 5),
                        opacity: 1,
                        force: 1,
                        azimuth: 0,
                        altitude: 0
                    ),
                ]
                
                newStroke.path = PKStrokePath(controlPoints: points, creationDate: Date())
                canvasView.drawing.strokes.append(newStroke)
                
                points = [
                    PKStrokePoint(
                        location: CGPoint(
                            x: userDrawing.renderBounds.maxX,
                            y: userDrawing.renderBounds.maxY
                        ),
                        timeOffset: 0,
                        size: CGSize(width: 5, height: 5),
                        opacity: 1,
                        force: 1,
                        azimuth: 0,
                        altitude: 0
                    ),
                    PKStrokePoint(
                        location: CGPoint(
                            x: userDrawing.renderBounds.maxX,
                            y: userDrawing.renderBounds.minY
                        ),
                        timeOffset: 0,
                        size: CGSize(width: 5, height: 5),
                        opacity: 1,
                        force: 1,
                        azimuth: 0,
                        altitude: 0
                    ),
                ]
                
                newStroke.path = PKStrokePath(controlPoints: points, creationDate: Date())
                canvasView.drawing.strokes.append(newStroke)
                
                points = [
                    PKStrokePoint(
                        location: CGPoint(
                            x: userDrawing.renderBounds.maxX,
                            y: userDrawing.renderBounds.minY
                        ),
                        timeOffset: 0,
                        size: CGSize(width: 5, height: 5),
                        opacity: 1,
                        force: 1,
                        azimuth: 0,
                        altitude: 0
                    ),
                    PKStrokePoint(
                        location: CGPoint(
                            x: userDrawing.renderBounds.minX,
                            y: userDrawing.renderBounds.minY
                        ),
                        timeOffset: 0,
                        size: CGSize(width: 5, height: 5),
                        opacity: 1,
                        force: 1,
                        azimuth: 0,
                        altitude: 0
                    ),
                ]
                
                newStroke.path = PKStrokePath(controlPoints: points, creationDate: Date())
                canvasView.drawing.strokes.append(newStroke)
                
                canvasView.drawing.strokes.remove(at: canvasView.drawing.strokes.count - 5)
            }
            
        }
        
    }
    
    func getFrame() -> CGSize {
        var frame: CGSize = .zero
        
        if page.isPortrait {
            frame = CGSize(
                width: shortSide,
                height: longSide
            )
        } else {
            frame = CGSize(width: longSide, height: shortSide)
        }
        
        return frame
    }
    
    func colorScheme() -> UIUserInterfaceStyle {
        var cs: UIUserInterfaceStyle = .dark
        
        if  page.backgroundColor == "pagewhite" ||  page.backgroundColor == "white" ||  page.backgroundColor == "pageyellow" ||  page.backgroundColor == "yellow"{
            cs = .light
        }
        
        return cs
    }
    
    func adoptScale() {
        canvasView.minimumZoomScale = toolManager.zoomScale
        canvasView.maximumZoomScale = toolManager.zoomScale
        
        canvasView.setZoomScale(toolManager.zoomScale, animated: false)
    }
    
}
