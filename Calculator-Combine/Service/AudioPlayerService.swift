//
//  AudioPlayerService.swift
//  Calculator-Combine
//
//  Created by Giray Şengönül on 1.12.2024.
//

import Foundation
import AVFoundation

public protocol AudioPlayerService{
    func playSound()
}

public final class DefaultAudioPlayer: AudioPlayerService{
    
    private var player: AVAudioPlayer?
    
    
    public func playSound() {
        let bundleURL = Bundle.main.path(forResource: "click", ofType: "m4a")!
        let url = URL(fileURLWithPath: bundleURL)
        do{
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        }catch(let error){
            print(error.localizedDescription)
        }
    }
    
    
    
    
}
