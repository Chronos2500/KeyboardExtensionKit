//
//  KEKeySound.swift
//  KeyboardExtensionKit
//
//  Created by ky0me22 on 2023/09/03.
//

import AudioToolbox

public enum KEKeySound {
    static func playSystemSound(_ soundID: SystemSoundID) {
        Task {
            await AudioServicesPlaySystemSound(soundID)
        }
    }

    public static func tapDelete() {
        // key_press_delete.caf: 1155
        playSystemSound(1155)
    }

    public static func tapModifier() {
        // key_press_modifier.caf: 1156
        playSystemSound(1156)
    }

    public static func tapClick() {
        // key_press_modifier.caf: 1104
        playSystemSound(1104)
    }
}
