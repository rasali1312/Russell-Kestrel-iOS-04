import Foundation
import Combine

enum ViewerGrid: Int, CaseIterable, Identifiable {
    case one = 1, four = 4, nine = 9, sixteen = 16
    var id: Int { rawValue }
    var columns: Int { switch self { case .one: 1; case .four: 2; case .nine: 3; case .sixteen: 4 } }
    var title: String { "\(columns)×\(columns)" }
}

enum StreamProfile: String, CaseIterable, Identifiable {
    case main, sub
    var id: String { rawValue }
    var title: String { rawValue.capitalized }
}

struct CameraChannel: Identifiable, Hashable {
    let id: Int
    var name: String { "CAM \(id)" }
}

final class DVRConfigStore: ObservableObject {
    @Published var host: String { didSet { save() } }
    @Published var rtspPort: String { didSet { save() } }
    @Published var webPort: String { didSet { save() } }
    @Published var username: String { didSet { save() } }
    @Published var password: String { didSet { save() } }
    @Published var channelCount: Int { didSet { save() } }
    @Published var rtspTemplate: String { didSet { save() } }
    @Published var playbackPath: String { didSet { save() } }

    private let d = UserDefaults.standard
    private var defaults: [String: String] { [
        "host": "", "rtspPort": "8554", "webPort": "8081", "username": "admin",
        "password": "", "rtspTemplate": "rtsp://{username}:{password}@{host}:{port}/",
        "playbackPath": "/playback.html"
    ] }

    init() {
        host = d.string(forKey: "host") ?? defaults["host"]!
        rtspPort = d.string(forKey: "rtspPort") ?? defaults["rtspPort"]!
        webPort = d.string(forKey: "webPort") ?? defaults["webPort"]!
        username = d.string(forKey: "username") ?? defaults["username"]!
        password = d.string(forKey: "password") ?? defaults["password"]!
        channelCount = max(1, d.integer(forKey: "channelCount") == 0 ? 16 : d.integer(forKey: "channelCount"))
        rtspTemplate = d.string(forKey: "rtspTemplate") ?? defaults["rtspTemplate"]!
        playbackPath = d.string(forKey: "playbackPath") ?? defaults["playbackPath"]!
    }

    var channels: [CameraChannel] { (1...channelCount).map(CameraChannel.init(id:)) }

    func save() {
        d.set(host, forKey: "host"); d.set(rtspPort, forKey: "rtspPort")
        d.set(webPort, forKey: "webPort"); d.set(username, forKey: "username")
        d.set(password, forKey: "password"); d.set(channelCount, forKey: "channelCount")
        d.set(rtspTemplate, forKey: "rtspTemplate"); d.set(playbackPath, forKey: "playbackPath")
    }

    func rtspURL(channel: Int, profile: StreamProfile) -> URL? {
        guard !host.isEmpty else { return nil }
        var value = rtspTemplate
        let replacements = [
            "{host}": host, "{port}": rtspPort, "{channel}": String(channel),
            "{username}": username, "{password}": password,
            "{stream}": profile == .main ? "main" : "sub"
        ]
        for (key, valueToInsert) in replacements { value = value.replacingOccurrences(of: key, with: valueToInsert) }
        return URL(string: value)
    }

    func webURL(path: String? = nil) -> URL? {
        guard !host.isEmpty, let port = Int(webPort) else { return nil }
        let p = path ?? playbackPath
        let normalized = p.hasPrefix("/") ? p : "/" + p
        return URL(string: "http://\(host):\(port)\(normalized)")
    }
}
