# Russell Kestrel iOS 0.4

Clean iPhone/iPad port of the **Russell Viewer External** concept for the OYN-X Kestrel DVR.

The old Windows implementation is intentionally **not** copied into this project. Windows-only IE/ActiveX/OCX/VPlugin code is replaced by iOS-native components.

## Ported External logic
- External DVR connection profile (host, web port, RTSP port, credentials)
- Live view with CAM 1–16 and scalable channel model (architecture is not limited to 5 cameras)
- 1 / 4 / 9 / 16 layouts
- Main / Sub stream selection
- Camera selection and per-camera player instances
- Kestrel web Playback entry point
- Playback adapter isolated so the real Kestrel HDD search/playback protocol can be implemented without changing the UI
- Audio/talk capability hooks for live/archive/two-way audio when supported by the DVR/camera protocol

## Known Kestrel values from the working External setup
- Web port: 8081
- RTSP port: 8554 for the external RTSP setup already tested
- Current installation: 5 cameras
- UI capacity: 16 channels now; model can be extended to 32+ without redesign

## Important
The legacy Kestrel web player used Windows ActiveX/OCX. iOS cannot execute that component. This project therefore uses a native RTSP player for live video and a separate archive adapter for true DVR HDD playback. The archive adapter is deliberately not filled with invented endpoints.

## Build
This repository uses XcodeGen. Run `xcodegen generate`, then open `RussellKestrel.xcodeproj` in Xcode.
