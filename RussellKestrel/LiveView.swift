import SwiftUI

struct LiveView: View {
    @EnvironmentObject var config: DVRConfigStore
    @State private var grid: ViewerGrid = .four
    @State private var profile: StreamProfile = .main

    private var visibleChannels: [CameraChannel] {
        Array(config.channels.prefix(grid.rawValue))
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                externalToolbar
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 2), count: grid.columns), spacing: 2) {
                        ForEach(visibleChannels) { camera in
                            CameraTile(channel: camera.id, url: config.rtspURL(channel: camera.id, profile: profile))
                                .aspectRatio(16.0 / 9.0, contentMode: .fit)
                        }
                    }
                    .padding(2)
                }
                .background(Color.black)
            }
            .navigationTitle("Russell Kestrel")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private var externalToolbar: some View {
        HStack(spacing: 8) {
            Menu {
                ForEach(ViewerGrid.allCases) { item in
                    Button(item.title) { grid = item }
                }
            } label: {
                Label(grid.title, systemImage: "square.grid.2x2")
            }
            .buttonStyle(.bordered)

            Picker("Stream", selection: $profile) {
                ForEach(StreamProfile.allCases) { Text($0.title).tag($0) }
            }
            .pickerStyle(.segmented)

            Spacer(minLength: 0)
        }
        .padding(8)
        .background(.black)
    }
}

struct CameraTile: View {
    let channel: Int
    let url: URL?

    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.black
            if let url {
                VLCPlayerView(url: url)
            } else {
                VStack(spacing: 5) {
                    Image(systemName: "video.slash")
                    Text("Set DVR address")
                }
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            Text("CAM \(channel)")
                .font(.caption.bold())
                .padding(5)
                .background(.black.opacity(0.75))
        }
        .clipped()
    }
}
