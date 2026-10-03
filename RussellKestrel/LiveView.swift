import SwiftUI

struct LiveView: View {
    @StateObject private var config = AppConfig.shared

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    Text("Live View")
                        .font(.title2)
                        .bold()

                    Text("DVR: \(config.host)")
                        .foregroundColor(.secondary)

                    Text("RTSP: \(config.rtspPort)")
                        .foregroundColor(.secondary)

                    ForEach(1...config.cameraCount, id: \.self) { camera in
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Camera \(camera)")
                                .font(.headline)

                            VLCPlayerView(
                                url: config.cameraURL(for: camera)
                            )
                            .frame(height: 220)
                            .cornerRadius(10)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Live")
        }
        .navigationViewStyle(.stack)
    }
}
