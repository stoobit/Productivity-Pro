struct ZoomableScrollView<Content: View>: UIViewRepresentable {

    @Binding var didZoom: Bool

    private var content: Content

    init(didZoom: Binding<Bool>, @ViewBuilder content: () -> Content) {
        _didZoom = didZoom
        self.content = content()
    }

    func makeUIView(context: Context) -> UIScrollView {

        // set up the UIScrollView
        let scrollView = UIScrollView()
        scrollView.delegate = context.coordinator  // for viewForZooming(in:)
        scrollView.maximumZoomScale = 20
        scrollView.minimumZoomScale = 1
        scrollView.bouncesZoom = true

        // create a UIHostingController to hold our SwiftUI content
        let hostedView = context.coordinator.hostingController.view!
        hostedView.translatesAutoresizingMaskIntoConstraints = true
        hostedView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        hostedView.frame = scrollView.bounds
        hostedView.backgroundColor = .black
        scrollView.addSubview(hostedView)

        return scrollView
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(hostingController: UIHostingController(rootView: self.content), didZoom: $didZoom)
    }

    func updateUIView(_ uiView: UIScrollView, context: Context) {
        // update the hosting controller's SwiftUI content
        context.coordinator.hostingController.rootView = self.content
        assert(context.coordinator.hostingController.view.superview == uiView)
    }

    // MARK: - Coordinator

    class Coordinator: NSObject, UIScrollViewDelegate {

        var hostingController: UIHostingController<Content>
        @Binding var didZoom: Bool

        init(hostingController: UIHostingController<Content>, didZoom: Binding<Bool>) {
            self.hostingController = hostingController
            _didZoom = didZoom
        }

        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            return hostingController.view
        }

        func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
            didZoom = !(scrollView.zoomScale == scrollView.minimumZoomScale)
        }
    }
}

---------------------------------------------------------------------------------

import SwiftUI
import PencilKit

struct PKCanvasViewUI: UIViewRepresentable {
    
    @Binding var document: Productivity_ProDocument
    
    @State var canvasView = PKCanvasView()
    @State var toolPicker = PKToolPicker()
    
    @StateObject var toolManager: ToolManager
    @StateObject var subviewManager: SubviewManager
    
    var image: UIImage
    var size: CGSize
    
    func makeUIView(context: Context) -> PKCanvasView {
        
        canvasView.delegate = context.coordinator
        
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        toolPicker.addObserver(canvasView)
        canvasView.becomeFirstResponder()
        
        canvasView.isScrollEnabled = true
        canvasView.minimumZoomScale = getScale()
        canvasView.maximumZoomScale = 5
        
        canvasView.backgroundColor = .clear
        canvasView.bouncesZoom = false
        
        canvasView.showsHorizontalScrollIndicator = false
        canvasView.showsVerticalScrollIndicator = false
        
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        let contentView = canvasView.subviews[0]

        contentView.frame = CGRect(
            x: 0,
            y: 0,
            width: getFrame().width,
            height: getFrame().height
        )
        
        contentView.addSubview(imageView)
        contentView.sendSubviewToBack(imageView)
        
        canvasView.contentSize = CGSize(
            width: getFrame().width,
            height: getFrame().height
        )
        
        canvasView.drawing = PKDrawing.decode(
            data: document.document.note.pages[ toolManager.selectedPage].canvas
        ) ?? PKDrawing()
         
        if toolManager.zoomScale < canvasView.minimumZoomScale {
            canvasView.setZoomScale(canvasView.minimumZoomScale, animated: false)
        } else {
            canvasView.setZoomScale(toolManager.zoomScale, animated: false)
        }
        
        canvasView.setContentOffset(toolManager.scrollOffset, animated: false)
        
        return canvasView
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        
        if uiView.minimumZoomScale != getScale() {
            uiView.minimumZoomScale = getScale()
            uiView.setZoomScale(getScale(), animated: true)
        }
        
        toolPicker.setVisible(
            subviewManager.showPKCanvas, forFirstResponder: canvasView
        )
        
        toolPicker.setVisible(
            !subviewManager.isSettingsSheet, forFirstResponder: canvasView
        )
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(
            canvasView: $canvasView,
            didZoom: $toolManager.didZoom,
            scale: $toolManager.zoomScale,
            offset: $toolManager.scrollOffset
        ) {
                
            document.document.note.pages[toolManager.selectedPage].canvas = canvasView.drawing.encode() ?? Data()
                
        }
    }
    
    class Coordinator: NSObject, PKCanvasViewDelegate {
        
        @Binding var canvasView: PKCanvasView
        
        @Binding var didZoom: Bool
        @Binding var scale: CGFloat
        @Binding var offset: CGPoint
        
        let onSaved: () -> Void
        
        init(
            canvasView: Binding<PKCanvasView>,
            didZoom: Binding<Bool>,
            scale: Binding<CGFloat>,
            offset: Binding<CGPoint>,
            onSaved: @escaping () -> Void
        ) {
            
            _canvasView = canvasView
            _didZoom = didZoom
            _scale = scale
            _offset = offset
            self.onSaved = onSaved
            
        }
        
        func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
            onSaved()
        }
        
        func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
            didZoom = !(scrollView.zoomScale == scrollView.minimumZoomScale)
            self.scale = scrollView.zoomScale
            self.offset = scrollView.contentOffset
        }
        
        func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            self.offset = scrollView.contentOffset
        }
        
        func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
            self.offset = scrollView.contentOffset
        }
        
    }
    
    func getFrame() -> CGSize {
        var frame: CGSize = .zero
        
        if document.document.note.pages[toolManager.selectedPage].isPortrait {
            frame = CGSize(width: shortSide, height: longSide)
        } else {
            frame = CGSize(width: longSide, height: shortSide)
        }
        
        return frame
    }
    
    func getScale() -> CGFloat {
        var scale: CGFloat = 0
        
        if document.document.note.pages[toolManager.selectedPage].isPortrait {
            scale = size.width / shortSide
        } else {
            scale = size.width / longSide
        }
        
        return scale
    }
    
}

