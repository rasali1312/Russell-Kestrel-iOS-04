import SwiftUI

@main
struct RussellKestrelApp: App {
    @StateObject private var config = DVRConfigStore()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(config)
                .preferredColorScheme(.dark)
        }
    }
}
