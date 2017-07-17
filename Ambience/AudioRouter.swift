//
//  AudioRouter.swift
//  Ambience
//
//  Created by Y0070749 on 31/01/2017.
//  Copyright © 2017 TrommelAudio. All rights reserved.
//

import Foundation
import AudioKit

class AudioRouter {
    //Declare a mixer
    private var mixer: AKMixer!
    
    init(){
        print("Audio Router initialised")
    }
    func setupOutput(device1: AKNode, device2: AKNode, device3: AKNode) {
        mixer = AKMixer(device1, device2, device3)
    }
    func start() {
        AKSettings.audioInputEnabled = true
        AudioKit.output = mixer
        AudioKit.start()
    }
}
