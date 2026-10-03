import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var config: DVRConfigStore

    var body: some View {
        NavigationStack {
            Form {
                Section("External DVR connection") {
                    TextField("DVR external address", text: $config.host)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                    TextField("RTSP port", text: $config.rtspPort)
                        .keyboardType(.numberPad)
                    TextField("Web port", text: $config.webPort)
                        .keyboardType(.numberPad)
                    TextField("Username", text: $config.username)
                        .textInputAutocapitalization(.never)
                    SecureField("Password", text: $config.password)
                }

                Section("Cameras") {
                    Stepper("Channels: \(config.channelCount)", value: $config.channelCount, in: 1...32)
                    Text("The current DVR has 5 cameras. The app is not hard-coded to five and can address up to 32 channels.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }

                Section("RTSP") {
                    TextField("RTSP template", text: $config.rtspTemplate, axis: .vertical)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                    Text("Variables: {host} {port} {channel} {username} {password} {stream}")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }

                Section("Kestrel web / playback") {
                    TextField("Playback path", text: $config.playbackPath)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                    Text("Known Kestrel web UI: port 8081 with Preview / Playback, CAM 1–16, Main / Sub, LocalPlayback and processbar.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }

                Section("Audio") {
                    Text("Live audio, archive audio and two-way talk are kept in the iOS architecture and will be enabled when the Kestrel camera/DVR transport exposes the required codec and talk channel.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("Settings")
        }
    }
}
