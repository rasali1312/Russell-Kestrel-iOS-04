import SwiftUI
import UIKit
import VLCKit

struct VLCPlayerView: UIViewRepresentable {
    let url: URL

    func makeCoordinator() -> Coordinator { Coordinator() }

    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .black
        context.coordinator.attach(url: url, to: view)
        return view
    }

    func updateUIView(_ view: UIView, context: Context) {
        context.coordinator.attach(url: url, to: view)
    }

    static func dismantleUIView(_ view: UIView, coordinator: Coordinator) {
        coordinator.stop()
    }

    final class Coordinator {
        private let player = VLCMediaPlayer()
        private var currentURL: URL?

        func attach(url: URL, to view: UIView) {
            player.drawable = view
            guard currentURL != url else { return }
            currentURL = url
            player.stop()
            player.media = VLCMedia(url: url)
            player.play()
        }

        func stop() {
            player.stop()
            player.drawable = nil
        }
    }
}
