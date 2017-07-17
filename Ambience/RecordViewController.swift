//
//  RecordViewController.swift
//  Ambience
//
//  Created by Y0070749 on 26/01/2017.
//  Copyright © 2017 TrommelAudio. All rights reserved.
//

import Foundation
import AudioKit

//Global microphone and recording model variables to aid signal routing
let microphone = AKMicrophone()
let recordingModel = RecordingEngine()

class RecordViewController: UIViewController {
    
    //Plot for viewing incoming audio waveform
    @IBOutlet weak var audioPlot: EZAudioPlot!
    
    //Buttons for controlling recording
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    
    override func viewDidLoad() {
        //Setup the waveform plot to view the input waveform at the microphone
        let plot = AKNodeOutputPlot(recordingModel.mixer, frame: audioPlot.bounds)
        plot.shouldFill = true
        plot.shouldMirror = true
        plot.backgroundColor = UIColor(colorLiteralRed: 0.2, green: 0.2, blue: 0.2, alpha: 0.0)
        plot.plotType = EZPlotType.rolling
        audioPlot.addSubview(plot)
    }
    
    //Variable to track whether record button has been pressed
    var record = true
    
    @IBAction func handleRecording(_ sender: UIButton) {
        
        //Call the record function in the recording model
        recordingModel.record()
        
        //Logic to determine displayed record button image
        if record {
            recordButton.setImage(UIImage(named: "stopButton"), for: UIControlState.normal)
            record = false
        }
        else{
            recordButton.setImage(UIImage(named: "RecordButton"), for: UIControlState.normal)
            record = true
        }
    }
    
    //Variable to track whether record button has been pressed
    var play = true
    
    //Play the recorded audio file
    @IBAction func handlePlayback(_ sender: UIButton) {
        recordingModel.play()
        if play {
            playButton.setImage(UIImage(named: "stopButtonPlay"), for: UIControlState.normal)
            play = false
        }
        else{
            playButton.setImage(UIImage(named: "playButton"), for: UIControlState.normal)
            play = true
        }
        
        
    }
    
    //Clear the recorded audio file
    @IBAction func handleReset(_ sender: UIButton) {
        recordingModel.reset()
    }
}
