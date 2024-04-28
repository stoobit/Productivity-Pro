//
//  AIChatView.swift
//  Productivity Pro
//
//  Created by Till Brügmann on 20.04.24.
//

import SwiftUI

struct AIChatView: View {
    @ObservedObject var llamaState: LlamaState
    @State var multiLineText: String = ""

    var body: some View {
        NavigationStack {
            ZStack {
                Color(UIColor.systemGroupedBackground)
                    .ignoresSafeArea(.all)

                VStack {
                    ScrollView {}

                    HStack(spacing: 15) {
                        TextField(
                            "Schreibe Productivity Pro AI...",
                            text: $multiLineText, axis: .vertical
                        )
                        .textFieldStyle(.plain)
                        .frame(height: 50)
                        .padding(.horizontal, 20)
                        .background {
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.accentColor, lineWidth: 2.0)
                        }

                        Button(action: {}, label: {
                            Label(
                                "Nachricht abschicken",
                                systemImage: "brain.fill"
                            )
                            .imageScale(.large)
                            .foregroundStyle(Color.white)
                            .labelStyle(.iconOnly)
                            .frame(width: 50, height: 50)
                            .background {
                                RoundedRectangle(cornerRadius: 16)
                                    .foregroundStyle(Color.accentColor)
                            }
                        })
                    }
                    .padding(20)
                    .background(.thickMaterial)
                    .disabled(llamaState.downloadedModels.isEmpty)
                }
            }
            .navigationTitle("AI")
            .toolbarRole(.browser)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button(
                        "Verlauf löschen",
                        systemImage: "clock.badge.xmark"
                    ) {}
                        .disabled(llamaState.downloadedModels.isEmpty)
                }
            }
        }
        .onAppear {
            load()
        }
    }

    private func load() {
        do {
            try llamaState.loadModel(
                modelUrl: getFileURL(
                    filename: llamaState.downloadedModels[0].filename
                )
            )
        } catch {}
    }

    private func getFileURL(filename: String) -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(filename)
    }

    // MARK: OLD

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
                    ForEach(llamaState.downloadedModels) { _ in
//                        AIDownloadButton(llamaState: llamaState, modelName: model.name, modelUrl: model.url, filename: model.filename)
                    }
                    .onDelete(perform: delete)
                }
                Section(header: Text("Default Models")) {
                    ForEach(llamaState.undownloadedModels) { _ in
//                        AIDownloadButton(llamaState: llamaState, modelName: model.name, modelUrl: model.url, filename: model.filename)
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
            }.sheet(isPresented: $showingHelp) {
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
