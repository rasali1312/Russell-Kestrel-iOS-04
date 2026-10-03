import Foundation

/// Native archive transport boundary for the Kestrel DVR.
///
/// The old Windows viewer obtained HDD playback through the legacy Kestrel
/// web/OCX stack. iOS cannot load ActiveX, so the exact archive request must
/// be implemented here from captured Kestrel HTTP/protocol traffic rather
/// than guessed.
final class KestrelArchiveClient {
    struct SearchRequest {
        let channel: Int
        let start: Date
        let end: Date
    }

    enum ArchiveError: Error {
        case protocolNotCaptured
        case invalidResponse
    }

    func search(_ request: SearchRequest, completion: @escaping (Result<[URL], Error>) -> Void) {
        // Intentionally no fake endpoint: connect this method to the actual
        // Kestrel archive request once it has been captured from External.
        completion(.failure(ArchiveError.protocolNotCaptured))
    }
}
