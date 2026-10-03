import Foundation
import AVFoundation

final class AudioManager {
    private let session = AVAudioSession.sharedInstance()

    func prepare() throws {
        try session.setCategory(.playAndRecord, options: [.defaultToSpeaker, .allowBluetooth])
        try session.setActive(true)
    }

    // Live/archive audio and two-way talk are protocol capabilities.
    // The transport is kept separate so a Kestrel-supported codec/path can be
    // added without changing the viewer UI.
}
