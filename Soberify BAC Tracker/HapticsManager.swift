//
//  HapticsManager.swift
//  Soberify BAC Tracker
//
//  Created by Noah S on 09/05/22.
//

import UIKit
import AVKit

final class HapticsManager {
    
    static let shared = HapticsManager()
    
    private init() {}
    
    public func vibrate(for type: UINotificationFeedbackGenerator.FeedbackType){
        DispatchQueue.main.async {
            let notificationGenerator = UINotificationFeedbackGenerator()
            notificationGenerator.prepare()
            notificationGenerator.notificationOccurred(type)
        }
    }
}

final class SoundManager {
    
    static let shared = SoundManager()
    
    var player: AVAudioPlayer?
    
    let soundFiles = ["burp", ""]
    
    func playBurp() {
        
        guard let url = Bundle.main.url(forResource: "burp", withExtension: ".mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error playing sound \(error.localizedDescription)")
        }
        
    }
    
}
