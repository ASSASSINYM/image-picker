// Copyright © 2018 INLOOPX. All rights reserved.

import AVFoundation

extension AVCaptureDevice {
    var preferredPosition: Position {
        return position.preferredPosition
    }

    var preferredDeviceType: DeviceType {
        return position.preferredDeviceType
    }
}

private extension AVCaptureDevice.Position {
    var preferredPosition: AVCaptureDevice.Position {
        switch self {
        case .front:
            return .back
        default:
            return .front
        }
    }

    var preferredDeviceType: AVCaptureDevice.DeviceType {
        switch self {
        case .back:
            return .builtInWideAngleCamera
        default:
            return .builtInDuoCamera
        }
    }
}

extension Array where Element == AVCaptureDevice {
    func getPreferredDevice(for currentDevice: AVCaptureDevice) -> AVCaptureDevice? {
        return getPreferredDevice(position: currentDevice.preferredPosition, deviceType: currentDevice.preferredDeviceType) ??
            getPreferredDevice(position: currentDevice.preferredPosition)
    }
    
    private func getPreferredDevice(position: AVCaptureDevice.Position, deviceType: AVCaptureDevice.DeviceType? = nil) -> AVCaptureDevice? {
        return filter {
            guard $0.position == position else { return false }
            guard let deviceType = deviceType else { return true }
            return $0.deviceType == deviceType
        }.first
    }
}
