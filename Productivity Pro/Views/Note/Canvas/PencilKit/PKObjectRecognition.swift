//
//  PKObjectRecognition.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 09.12.23.
//

import PencilKit
import CoreML
import Vision
import ImageIO

extension Coordinator {
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
