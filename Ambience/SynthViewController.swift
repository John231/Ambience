//
//  SynthController.swift
//  Ambience
//
//  Created by Y0070749 on 19/12/2016.
//  Copyright © 2016 TrommelAudio. All rights reserved.
//

import Foundation
import AudioKit

//Globally declared synth engine to enable signal routing
let synthModel = SynthEngine()

class SynthViewController: UIViewController {
    
    //Oscillator waveform selectors
    @IBOutlet weak var osc1Waveform: UISegmentedControl!
    @IBOutlet weak var osc2Waveform: UISegmentedControl!
    
    //Oscillator 1 Coarse Tuning Buttons
    @IBOutlet weak var osc1Coarse0: UIButton!
    @IBOutlet weak var osc1CoarseMinus5: UIButton!
    @IBOutlet weak var osc1CoarseMinus7: UIButton!
    @IBOutlet weak var osc1CoarseMinus12: UIButton!
    @IBOutlet weak var osc1CoarsePlus5: UIButton!
    @IBOutlet weak var osc1CoarsePlus7: UIButton!
    @IBOutlet weak var osc1CoarsePlus12: UIButton!
    
    //Oscillator Amplitude Sliders
    @IBOutlet weak var osc1Mix: UISlider!
    @IBOutlet weak var osc2Mix: UISlider!
    @IBOutlet weak var oscNoiseMix: UISlider!
    
    
    
    //Oscillator 2 Coarse Tuning Buttons
    @IBOutlet weak var osc2Coarse0: UIButton!
    @IBOutlet weak var osc2CoarseMinus5: UIButton!
    @IBOutlet weak var osc2CoarseMinus7: UIButton!
    @IBOutlet weak var osc2CoarseMinus12: UIButton!
    @IBOutlet weak var osc2CoarsePlus5: UIButton!
    @IBOutlet weak var osc2CoarsePlus7: UIButton!
    @IBOutlet weak var osc2CoarsePlus12: UIButton!
    
    //ADSR Sliders
    @IBOutlet weak var attackSlider: UISlider!
    @IBOutlet weak var decaySlider: UISlider!
    @IBOutlet weak var sustainSlider: UISlider!
    @IBOutlet weak var releaseSlider: UISlider!
    
    //ADSR Labels
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var decayLabel: UILabel!
    @IBOutlet weak var sustainLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    
    //Keyboard buttons
    @IBOutlet weak var keysC: UIButton!
    @IBOutlet weak var keysCSharp: UIButton!
    @IBOutlet weak var keysD: UIButton!
    @IBOutlet weak var keysDSharp: UIButton!
    @IBOutlet weak var keysE: UIButton!
    @IBOutlet weak var keysF: UIButton!
    @IBOutlet weak var keysFSharp: UIButton!
    @IBOutlet weak var keysG: UIButton!
    @IBOutlet weak var keysGSharp: UIButton!
    @IBOutlet weak var keysA: UIButton!
    @IBOutlet weak var keysASharp: UIButton!
    @IBOutlet weak var keysB: UIButton!
    
    //Variable to keep track of oscillator tuning
    var osc1Tuning = 3
    var osc2Tuning = 10
    
    //Filter cutoff & resonance sliders
    @IBOutlet weak var cutoffSlider: UISlider!
    @IBOutlet weak var resonanceSlider: UISlider!
    
    //Dictionary to aid with waveform selection
    let oscillatorWaveformDictionary = [0:"sine",1:"saw",2:"square",3:"triangle"]
    
    override func viewDidLoad() {
        //Upon load, set the synthesiser oscillators to sine waves
        synthModel.setOscillatorWaveform(oscillatorID: 1, waveform: "sine")
        synthModel.setOscillatorWaveform(oscillatorID: 2, waveform: "sine")
        
        //Set oscillator amplitudes upon load
        synthModel.setOscillatorAmplitude(amplitude: 0.5, osc: 1, waveform: "sine")
        synthModel.setOscillatorAmplitude(amplitude: 0.5, osc: 2, waveform: "sine")
        synthModel.setOscillatorAmplitude(amplitude: 0.5, osc: 3, waveform: "noise")
        
        //Initialise the labels in the view to the values of the respective ADSR sliders
        attackLabel.text = String(format: "%0.2f", attackSlider.value)
        decayLabel.text = String(format: "%0.2f", decaySlider.value)
        sustainLabel.text = String(format: "%0.2f", sustainSlider.value)
        releaseLabel.text = String(format: "%0.2f", releaseSlider.value)
    }
    
    //Handle a change in the amplitude ADSR envelope
    @IBAction func handleEnvelopeChange(_ sender: UISlider) {
        if sender == attackSlider {
             synthModel.changeSynthAttack(attackTime: Double(attackSlider.value))
            attackLabel.text = String(format: "%0.2f", attackSlider.value)
        }
        else if sender == decaySlider {
            synthModel.changeSynthDecay(decayTime: Double(decaySlider.value))
            decayLabel.text = String(format: "%0.2f", decaySlider.value)
        }
        else if sender == sustainSlider {
            synthModel.changeSynthSustain(sustainLevel: Double(sustainSlider.value))
            sustainLabel.text = String(format: "%0.2f", sustainSlider.value)
        }
        else if sender == releaseSlider {
            synthModel.changeSynthRelease(releaseTime: Double(releaseSlider.value))
            releaseLabel.text = String(format: "%0.2f", releaseSlider.value)
        }

    }
    
    //Handle when user presses the keyboard keys
    @IBAction func handleKeyPress(_ sender: UIButton) {
        switch sender {
        case keysC:
            synthModel.playSynth(frequency: 261.6255653006, osc1Tuning: osc1Tuning, osc2Tuning: osc2Tuning)
        case keysCSharp:
            synthModel.playSynth(frequency: 277.1826309769, osc1Tuning: osc1Tuning, osc2Tuning: osc2Tuning)
        case keysD:
            synthModel.playSynth(frequency: 293.6647679174, osc1Tuning: osc1Tuning, osc2Tuning: osc2Tuning)
        case keysDSharp:
            synthModel.playSynth(frequency: 311.1269837221, osc1Tuning: osc1Tuning, osc2Tuning: osc2Tuning)
        case keysE:
            synthModel.playSynth(frequency: 329.6275569129, osc1Tuning: osc1Tuning, osc2Tuning: osc2Tuning)
        case keysF:
            synthModel.playSynth(frequency: 349.2282314330, osc1Tuning: osc1Tuning, osc2Tuning: osc2Tuning)
        case keysFSharp:
            synthModel.playSynth(frequency: 369.9944227116, osc1Tuning: osc1Tuning, osc2Tuning: osc2Tuning)
        case keysG:
            synthModel.playSynth(frequency: 391.9954359817, osc1Tuning: osc1Tuning, osc2Tuning: osc2Tuning)
        case keysGSharp:
            synthModel.playSynth(frequency: 415.3046975799, osc1Tuning: osc1Tuning, osc2Tuning: osc2Tuning)
        case keysA:
            synthModel.playSynth(frequency: 440.0000000000, osc1Tuning: osc1Tuning, osc2Tuning: osc2Tuning)
        case keysASharp:
            synthModel.playSynth(frequency: 466.1637615181, osc1Tuning: osc1Tuning, osc2Tuning: osc2Tuning)
        case keysB:
            synthModel.playSynth(frequency: 493.8833012561, osc1Tuning: osc1Tuning, osc2Tuning: osc2Tuning)
        default:
            print("not yet implemented")
        }
    }
    
    //Handle when the user releases a keyboard key
    @IBAction func handleKeyRelease(_ sender: UIButton) {
        synthModel.stopSynth()
    }
    
    //Respond to user changing the synth waveform
    @IBAction func handleWaveformChange(_ sender: UISegmentedControl) {
        if sender == osc1Waveform {
            synthModel.setOscillatorWaveform(oscillatorID: 1, waveform: oscillatorWaveformDictionary[osc1Waveform.selectedSegmentIndex]!)
        }
        else if sender == osc2Waveform {
            synthModel.setOscillatorWaveform(oscillatorID: 2, waveform: oscillatorWaveformDictionary[osc2Waveform.selectedSegmentIndex]!)
        }
    }
    
    //Change the tuning of the oscillators based on the selected button
    @IBAction func handleOscillatorTuning(_ sender: UIButton) {
        if sender.tag > 6 {
            osc2Tuning = sender.tag
        }
        else {
            osc1Tuning = sender.tag
        }
        synthModel.setOscillatorTuning(tuningID: sender.tag)
    }
    
    //Change oscillator mix volume
    @IBAction func handleOscLevel(_ sender: UISlider) {
        if sender == osc1Mix {
            synthModel.setOscillatorAmplitude(amplitude: Double(osc1Mix.value), osc: 1, waveform: oscillatorWaveformDictionary[osc1Waveform.selectedSegmentIndex]!)
        }
        else if sender == osc2Mix {
            synthModel.setOscillatorAmplitude(amplitude: Double(osc2Mix.value), osc: 2, waveform: oscillatorWaveformDictionary[osc1Waveform.selectedSegmentIndex]!)
        }
        else if sender == oscNoiseMix {
            synthModel.setOscillatorAmplitude(amplitude: Double(oscNoiseMix.value), osc: 3, waveform: "noise")
        }
    }
    
    //Change the filter cutoff amount according to the slider position
    @IBAction func handleFilterCutoff(_ sender: UISlider) {
        //To enable logarithmic slider, send slider value as index of 10
        synthModel.setFilterCutoff(cutoffFrequency: pow(10, Double(cutoffSlider.value)))
    }
    
    //Change the resonance amount according to the slider position
    @IBAction func handleFilterResonance(_ sender: UISlider) {
        synthModel.setFilterResonance(resonance: Double(resonanceSlider.value))
    }
}
