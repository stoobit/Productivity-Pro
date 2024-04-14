import SwiftUI

struct AIView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var llamaState = LlamaState()
    
    @State private var showProgress: Bool = false
    @State private var multiLineText = ""
    @State private var showingHelp = false
    

    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .foregroundStyle(.windowBackground)
                    .ignoresSafeArea()
                    .overlay {
                        HStack {
                            Spacer()
                            Rectangle()
                                .frame(width: 50)
                                .foregroundStyle(.blue)
                            Spacer()
                            Spacer()
                            Rectangle()
                                .frame(width: 50, height: 1000)
                                .foregroundStyle(.purple)
                            Spacer()
                            Spacer()
                            Rectangle()
                                .frame(width: 50)
                                .foregroundStyle(.yellow)
                            Spacer()
                        }
                        .rotationEffect(Angle(degrees: 225))
                        .blur(radius: 100)
                    }

                VStack {
                    ViewThatFits(in: .horizontal) {
                        Text("Productivity Pro AI")
                            .font(.largeTitle.bold())
                            .padding(.bottom, 5)

                        Text("AI")
                            .font(.largeTitle.bold())
                            .padding(.bottom, 5)
                    }

                    Text("Lade Productivity Pro AI auf dein iPad herunter und nutze künstliche Intelligenz offline. So bleiben deine Daten sicher & privat.")
                        .multilineTextAlignment(.center)

                    Spacer()

                    if showProgress == false {
                        Button(action: {
                            showProgress.toggle()
                        }) {
                            Text("AI herunterladen und offline nutzen.")
                                .font(.headline)
                                .foregroundStyle(Color.primary)
                                .padding()
                                .padding(.horizontal, 10)
                                .background {
                                    RoundedRectangle(cornerRadius: 80)
                                        .foregroundStyle(.windowBackground)

                                    RoundedRectangle(cornerRadius: 80)
                                        .stroke(LinearGradient(
                                            colors: [
                                                Color.blue,
                                                Color.purple,
                                                Color.yellow,

                                            ],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        ), lineWidth: 4)
                                }
                        }
                    } else {
                        HStack {
                            ProgressView(value: 33, total: 100)
                                .tint(Color.primary)
                                .progressViewStyle(.linear)

                            Text("33%")
                                .padding(.leading)
                        }
                        .padding(50)
                    }

                    Spacer()

                    Text("Je nach Leistung und Sprache der AI kann die Download-Größe variieren.")
                        .multilineTextAlignment(.center)
                        .font(.caption)
                        .foregroundStyle(Color.secondary)
                }
                .padding()
                .toolbarBackground(.hidden, for: .navigationBar)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Abbrechen") {
                            dismiss()
                        }
                        .foregroundStyle(Color.primary)
                    }
                }
            }
        }
    }

    @ViewBuilder func OLD() -> some View {
        NavigationView {
            VStack {
                ScrollView(.vertical, showsIndicators: true) {
                    Text(llamaState.messageLog)
                        .font(.system(size: 12))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .onTapGesture {
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
                }

                TextEditor(text: $multiLineText)
                    .frame(height: 80)
                    .padding()
                    .border(Color.gray, width: 0.5)

                HStack {
                    Button("Send") {
                        sendText()
                    }

                    Button("Bench") {
                        bench()
                    }

                    Button("Clear") {
                        clear()
                    }

                    Button("Copy") {
                        UIPasteboard.general.string = llamaState.messageLog
                    }
                }
                .buttonStyle(.bordered)
                .padding()

                NavigationLink(destination: DrawerView(llamaState: llamaState)) {
                    Text("View Models")
                }
                .padding()
            }
            .padding()
            .navigationBarTitle("Model Settings", displayMode: .inline)
        }
    }

    func sendText() {
        Task {
            await llamaState.complete(text: multiLineText)
            multiLineText = ""
        }
    }

    func bench() {
        Task {
            await llamaState.bench()
        }
    }

    func clear() {
        Task {
            await llamaState.clear()
        }
    }

    struct DrawerView: View {
        @ObservedObject var llamaState: LlamaState
        @State private var showingHelp = false
        func delete(at offsets: IndexSet) {
            offsets.forEach { offset in
                let model = llamaState.downloadedModels[offset]
                let fileURL = getDocumentsDirectory().appendingPathComponent(model.filename)
                do {
                    try FileManager.default.removeItem(at: fileURL)
                } catch {
                    print("Error deleting file: \(error)")
                }
            }

            // Remove models from downloadedModels array
            llamaState.downloadedModels.remove(atOffsets: offsets)
        }

        func getDocumentsDirectory() -> URL {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            return paths[0]
        }

        var body: some View {
            List {
                Section(header: Text("Download Models From Hugging Face")) {
                    HStack {
                        AIInputButton(llamaState: llamaState)
                    }
                }
                Section(header: Text("Downloaded Models")) {
                    ForEach(llamaState.downloadedModels) { model in
                        AIDownloadButton(llamaState: llamaState, modelName: model.name, modelUrl: model.url, filename: model.filename)
                    }
                    .onDelete(perform: delete)
                }
                Section(header: Text("Default Models")) {
                    ForEach(llamaState.undownloadedModels) { model in
                        AIDownloadButton(llamaState: llamaState, modelName: model.name, modelUrl: model.url, filename: model.filename)
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Model Settings", displayMode: .inline).toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Help") {
                        showingHelp = true
                    }
                }
            }.sheet(isPresented: $showingHelp) { // Sheet for help modal
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        Text("1. Make sure the model is in GGUF Format")
                            .padding()
                        Text("2. Copy the download link of the quantized model")
                            .padding()
                    }
                    Spacer()
                }
            }
        }
    }
}
