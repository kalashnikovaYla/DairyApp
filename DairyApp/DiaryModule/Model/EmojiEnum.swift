//
//  EmojiEnum.swift
//  DairyApp
//
//  Created by sss on 26.04.2023.
//

import Foundation


enum Emoji: Float {
    case mood0 = 0
    case mood4 = 4
    case mood8 = 8
    case mood12 = 12
    case mood16 = 16
    case mood20 = 20
    
    var emoji: String {
        switch self {
        case .mood0:
            return "😞"
        case .mood4:
            return "😔"
        case .mood8:
            return "😐"
        case .mood12:
            return "🙂"
        case .mood16:
            return "😊"
        case .mood20:
            return "😃"
        }
    }
}
