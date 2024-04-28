import SwiftUI

struct AIView: View {
    @StateObject var llamaState = LlamaState()

    var body: some View {
        if llamaState.downloadedModels.isEmpty {
            ZStack {
                Color(UIColor.systemGroupedBackground)
                    .ignoresSafeArea(.all)
                
                AISetupView(llamaState: llamaState)
            }
        } else {
            AIChatView(llamaState: llamaState)
        }
    }
}
