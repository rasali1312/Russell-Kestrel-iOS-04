import SwiftUI
import AVKit

struct VLCPlayerView: View {
    let url: URL?

    var body: some View {
        Group {
            if let url = url {
                VideoPlayer(player: AVPlayer(url: url))
                    .background(Color.black)
            } else {
                ZStack {
                    Color.black
                    Text("No video stream")
                        .foregroundColor(.white)
                }
            }
        }
    }
}
