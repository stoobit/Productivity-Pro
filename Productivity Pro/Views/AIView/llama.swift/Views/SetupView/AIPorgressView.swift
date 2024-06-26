import SwiftUI

struct AIProgressView: View {
    @ObservedObject private var llamaState: LlamaState
    private var modelName: String
    private var modelUrl: String
    private var filename: String

    @State private var status: String

    @State private var downloadTask: URLSessionDownloadTask?
    @State private var progress = 0.0
    @State private var observation: NSKeyValueObservation?
    
    var body: some View {
        HStack {
            ProgressView(value: progress, total: 1)
                .tint(Color.primary)
                .progressViewStyle(.linear)

            Text("\(Int(progress * 100))%")
                .frame(width: 50)
                .padding(.leading)
        }
        .padding(.horizontal, 70)
        .onAppear {
            if llamaState.isLoading == false {
                llamaState.isLoading = true
                download()
            }
        }

//        VStack {
//            if status == "download" {
//                Button(action: download) {
//                    Text("Download " + modelName)
//                }
//            } else if status == "downloading" {
//                Button(action: {
//                    downloadTask?.cancel()
//                    status = "download"
//                }) {
//                    Text("\(modelName) (Downloading \(Int(progress * 100))%)")
//                }
//            } else if status == "downloaded" {
//                Button(action: {
//                    let fileURL = AIDownloadButton.getFileURL(filename: filename)
//                    if !FileManager.default.fileExists(atPath: fileURL.path) {
//                        download()
//                        return
//                    }
//                    do {
//                        try llamaState.loadModel(modelUrl: fileURL)
//                    } catch let err {
//                        print("Error: \(err.localizedDescription)")
//                    }
//                }) {
//                    Text("Load \(modelName)")
//                }
//            } else {
//                Text("Unknown status")
//            }
//        }
//        .onDisappear {
//            downloadTask?.cancel()
//        }
//        .onChange(of: llamaState.cacheCleared) {
//            if llamaState.cacheCleared {
//                downloadTask?.cancel()
//                let fileURL = AIDownloadButton.getFileURL(filename: filename)
//                status = FileManager.default.fileExists(atPath: fileURL.path) ? "downloaded" : "download"
//            }
//        }
    }

    private static func getFileURL(filename: String) -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(filename)
    }

    init(llamaState: LlamaState, modelName: String, modelUrl: String, filename: String) {
        self.llamaState = llamaState
        self.modelName = modelName
        self.modelUrl = modelUrl
        self.filename = filename

        let fileURL = AIProgressView.getFileURL(filename: filename)
        status = FileManager.default.fileExists(atPath: fileURL.path) ? "downloaded" : "download"
    }

    private func download() {
        status = "downloading"
        print("Downloading model \(modelName) from \(modelUrl)")
        guard let url = URL(string: modelUrl) else { return }
        let fileURL = AIProgressView.getFileURL(filename: filename)

        downloadTask = URLSession.shared.downloadTask(with: url) { temporaryURL, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            guard let response = response as? HTTPURLResponse, (200 ... 299).contains(response.statusCode) else {
                print("Server error!")
                return
            }

            do {
                if let temporaryURL = temporaryURL {
                    try FileManager.default.copyItem(at: temporaryURL, to: fileURL)
                    print("Writing to \(filename) completed")

                    llamaState.cacheCleared = false

                    let model = AIModel(name: modelName, url: modelUrl, filename: filename, status: "downloaded")

                    DispatchQueue.main.async {
                        llamaState.downloadedModels.append(model)
                    }

                    status = "downloaded"
                }
            } catch let err {
                print("Error: \(err.localizedDescription)")
            }
        }

        observation = downloadTask?.progress.observe(\.fractionCompleted) { progress, _ in
            self.progress = progress.fractionCompleted
        }

        downloadTask?.resume()
    }
}
