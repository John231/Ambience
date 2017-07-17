//
//  RecordingEngine.swift
//  Ambience
//
//  Created by Y0070749 on 31/01/2017.
//  Copyright © 2017 TrommelAudio. All rights reserved.
//

import Foundation
import AudioKit

class RecordingEngine {
    
    //Class variable
    let filePlayer: AKAudioPlayer!
    let recorder: AKNodeRecorder!
    let mixer: AKMixer!
    
    init() {
        //Use a mixer to route the microphone to prevent crash caused by displaying microphone input directly with EZAudioPlot
        mixer = AKMixer(microphone)
        
        //Setup the recording file and associated player
        let recordFile = try! AKAudioFile()
        filePlayer = try! AKAudioPlayer(file: recordFile)
        filePlayer.looping = true //Loop the player when play is pressed
        
        //Record the microphone input
        recorder = try! AKNodeRecorder(node: microphone, file: recordFile)
    }
    
    //Handle recording event
    func record(){
        //If recorder is already recording, stop the recorder
        if recorder.isRecording {
            recorder.stop()
        }
        //Otherwise record new input
        else {
            try! recorder.record()
        }
    }
    
    //Clear the recorded file
    func reset() {
        try! recorder.reset()
    }
    
    //Playback the recorded file
    func play() {
        //If player is currently running then stop playback
        if filePlayer.isPlaying {
            filePlayer?.stop()
        }
        else {
            //Reload audio file and play from beginning
            try! filePlayer.reloadFile()
            filePlayer.play()
        }
    }
}
