import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            LiveView().tabItem { Label("Live", systemImage: "video.fill") }
            PlaybackView().tabItem { Label("Playback", systemImage: "clock.arrow.circlepath") }
            SettingsView().tabItem { Label("Settings", systemImage: "gearshape.fill") }
        }
        .tint(.cyan)
    }
}
