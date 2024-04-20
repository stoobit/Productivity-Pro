import SwiftUI

struct AIView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.openWindow) var openWindow

    @StateObject var llamaState = LlamaState()

    @State private var showProgress: Bool = false
    @State private var multiLineText = ""
    @State private var showingHelp = false

    var body: some View {
        if llamaState.downloadedModels.isEmpty {
            AISetupContainer(inProgress: $showProgress) {
                VStack {
                    AIProgressView(
                        llamaState: llamaState,
                        modelName: llamaState.undownloadedModels[ix].name,
                        modelUrl: llamaState.undownloadedModels[ix].url,
                        filename: llamaState.undownloadedModels[ix].filename
                    )
                }
            }
        } else {
            AIChatView(llamaState: llamaState)
        }
    }

    var ix: Int {
        if Locale.current.localizedString(
            forIdentifier: "DE"
        ) ?? "" == "Deutsch" {
            return 1
        } else {
            return 0
        }
    }
}
