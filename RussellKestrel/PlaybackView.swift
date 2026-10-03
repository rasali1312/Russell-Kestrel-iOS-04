import SwiftUI
import WebKit

struct PlaybackView: View {
    @EnvironmentObject var config: DVRConfigStore
    @State private var channel = 1
    @State private var date = Date()
    @State private var showingWebPlayback = false

    var body: some View {
        NavigationStack {
            Form {
                Section("DVR archive") {
                    Picker("Camera", selection: $channel) {
                        ForEach(config.channels) { camera in
                            Text(camera.name).tag(camera.id)
                        }
                    }
                    DatePicker("Date", selection: $date, displayedComponents: [.date, .hourAndMinute])

                    Button("Search DVR archive") {
                        // The UI is wired to the Kestrel archive adapter.
                        // The real HDD-search request must be filled from captured Kestrel protocol traffic.
                    }

                    if config.webURL() != nil {
                        Button("Open Kestrel Playback") { showingWebPlayback = true }
                    } else {
                        Text("Set the DVR address in Settings first.")
                            .foregroundStyle(.secondary)
                    }
                }

                Section("Russell Viewer External flow") {
                    Text("Camera → date/time → DVR HDD search → playback")
                    Text("The legacy Windows ActiveX/OCX player is not used on iOS. The archive transport is isolated in KestrelArchiveClient so the native player can be connected once the exact DVR playback request is captured.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("Playback")
            .sheet(isPresented: $showingWebPlayback) {
                if let url = config.webURL() {
                    KestrelWebView(url: url)
                        .ignoresSafeArea()
                }
            }
        }
    }
}

struct KestrelWebView: UIViewRepresentable {
    let url: URL
    func makeUIView(context: Context) -> WKWebView {
        let web = WKWebView(frame: .zero)
        web.allowsBackForwardNavigationGestures = true
        web.load(URLRequest(url: url))
        return web
    }
    func updateUIView(_ web: WKWebView, context: Context) {}
}
