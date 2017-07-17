//
//  AudioEngine.swift
//  Ambience
//
//  Created by Y0070749 on 20/12/2016.
//  Copyright © 2016 TrommelAudio. All rights reserved.
//

import Foundation
import AudioKit

class SynthEngine {
    
    //MARK: SynthEngine Class Variables
    
    //Mixer for mixing together the two oscillators
    var oscMixer: AKMixer!
    
    //Declare all oscillators to be accessed by oscillator 1
    var osc1Sine: AKOscillator!
    var osc1Saw: AKOscillator!
    var osc1Square: AKOscillator!
    var osc1Triangle: AKOscillator!
    
    //Declare all oscillators to be accessed by oscillator 2
    var osc2Sine: AKOscillator!
    var osc2Saw: AKOscillator!
    var osc2Square: AKOscillator!
    var osc2Triangle: AKOscillator!
    
    //Declare the noise oscillator
    var oscNoise: AKWhiteNoise!
    
    //Declare the filter
    var lowpassFilter: AKMoogLadder!
    
    //Amplitude envelopes for oscillator 1
    var osc1SineAmpEnv: AKAmplitudeEnvelope!
    var osc1SawAmpEnv: AKAmplitudeEnvelope!
    var osc1SquareAmpEnv: AKAmplitudeEnvelope!
    var osc1TriangleAmpEnv: AKAmplitudeEnvelope!
    
    //Amplitude envelopes for oscillator 2
    var osc2SineAmpEnv: AKAmplitudeEnvelope!
    var osc2SawAmpEnv: AKAmplitudeEnvelope!
    var osc2SquareAmpEnv: AKAmplitudeEnvelope!
    var osc2TriangleAmpEnv: AKAmplitudeEnvelope!
    
    //Amplitude envelope for noise oscillator
    var oscNoiseAmpEnv: AKAmplitudeEnvelope!
    
    var osc1Amplitude = 0.5
    var osc2Amplitude = 0.5
    var osc1Frequency = 440.00
    var osc2Frequency = 440.00
    
    //MARK: Class init method
    init() {
        //Instantiate the oscillator 1 waveforms
        osc1Sine = AKOscillator(waveform: AKTable(.sine))
        osc1Saw = AKOscillator(waveform: AKTable(.sawtooth))
        osc1Square = AKOscillator(waveform: AKTable(.square))
        osc1Triangle = AKOscillator(waveform: AKTable(.triangle))
        
        //Instantiate the oscillator 2 waveforms
        osc2Sine = AKOscillator(waveform: AKTable(.sine))
        osc2Saw = AKOscillator(waveform: AKTable(.sawtooth))
        osc2Square = AKOscillator(waveform: AKTable(.square))
        osc2Triangle = AKOscillator(waveform: AKTable(.triangle))
        
        //Instantiate the Noise oscillator
        oscNoise = AKWhiteNoise()
        
        //Start all oscillators
        osc1Sine.start()
        osc1Saw.start()
        osc1Square.start()
        osc1Triangle.start()
        
        osc2Sine.start()
        osc2Saw.start()
        osc2Square.start()
        osc2Triangle.start()
        
        oscNoise.start()
        
        //Attach each oscillator to its own respective amplitude envelope
        osc1SineAmpEnv = AKAmplitudeEnvelope(osc1Sine)
        osc1SawAmpEnv = AKAmplitudeEnvelope(osc1Saw)
        osc1SquareAmpEnv = AKAmplitudeEnvelope(osc1Square)
        osc1TriangleAmpEnv = AKAmplitudeEnvelope(osc1Triangle)
        
        osc2SineAmpEnv = AKAmplitudeEnvelope(osc2Sine)
        osc2SawAmpEnv = AKAmplitudeEnvelope(osc2Saw)
        osc2SquareAmpEnv = AKAmplitudeEnvelope(osc2Square)
        osc2TriangleAmpEnv = AKAmplitudeEnvelope(osc2Triangle)
        
        oscNoiseAmpEnv = AKAmplitudeEnvelope(oscNoise)
        
        //Mix all oscillators into a mixer
        oscMixer = AKMixer(osc1SineAmpEnv, osc1SawAmpEnv, osc1SquareAmpEnv, osc1TriangleAmpEnv,
                           osc2SineAmpEnv, osc2SawAmpEnv, osc2SquareAmpEnv, osc2TriangleAmpEnv,
                           oscNoiseAmpEnv)
        oscMixer.start()
        
        //Route the mixer through a lowpass filter
        lowpassFilter = AKMoogLadder(oscMixer, cutoffFrequency: 100, resonance: 0.5)
        lowpassFilter.start()
    }
    
    //Synth Play/Stop Functions
    func playSynth(frequency: Double, osc1Tuning: Int, osc2Tuning: Int) {
        
        //Set the class frequency variables to the respective frequency
        osc1Frequency = frequency
        osc2Frequency = frequency
        
        //Determine the relative tuning of each oscillator
        setOscillatorTuning(tuningID: osc1Tuning)
        setOscillatorTuning(tuningID: osc2Tuning)
        
        
        /*
        osc1Sine.frequency = frequency
        osc1Saw.frequency = frequency
        osc1Square.frequency = frequency
        osc1Triangle.frequency = frequency
        
        osc2Sine.frequency = frequency
        osc2Saw.frequency = frequency
        osc2Square.frequency = frequency
        osc2Triangle.frequency = frequency
        */
        
        //Start the amplitude envelopes for all oscillators
        osc1SineAmpEnv.start()
        osc1SawAmpEnv.start()
        osc1SquareAmpEnv.start()
        osc1Triangle.start()
        
        osc2SineAmpEnv.start()
        osc2SawAmpEnv.start()
        osc2SquareAmpEnv.start()
        osc2TriangleAmpEnv.start()
        
        oscNoiseAmpEnv.start()
    }
    
    //Handles the release events of each keyboard note
    func stopSynth() {
        
        //Stop all oscillators following release of each key
        osc1SineAmpEnv.stop()
        osc1SawAmpEnv.stop()
        osc1SquareAmpEnv.stop()
        osc1TriangleAmpEnv.stop()
        
        osc2SineAmpEnv.stop()
        osc2SawAmpEnv.stop()
        osc2SquareAmpEnv.stop()
        osc2TriangleAmpEnv.stop()
        
        oscNoiseAmpEnv.stop()
    }
    
    //MARK: Oscillator functions
    
    //Set the waveform of the oscillator
    func setOscillatorWaveform(oscillatorID: Int, waveform: String){
        
        //Set oscillator 1 waveform
        if oscillatorID == 1 {
            switch waveform {
            case "sine":
                osc1Sine.amplitude = osc1Amplitude
                osc1Saw.amplitude = 0
                osc1Square.amplitude = 0
                osc1Triangle.amplitude = 0
            case "saw":
                osc1Sine.amplitude = 0
                osc1Saw.amplitude = osc1Amplitude
                osc1Square.amplitude = 0
                osc1Triangle.amplitude = 0
            case "square":
                osc1Sine.amplitude = 0
                osc1Saw.amplitude = 0
                osc1Square.amplitude = osc1Amplitude
                osc1Triangle.amplitude = 0
            case "triangle":
                osc1Sine.amplitude = 0
                osc1Saw.amplitude = 0
                osc1Square.amplitude = 0
                osc1Triangle.amplitude = osc1Amplitude
            default:
                print("unrecognised osc1 waveform")
            }
        }
        //Set oscillator 2 waveform
        else if oscillatorID == 2 {
            switch waveform {
            case "sine":
                osc2Sine.amplitude = osc2Amplitude
                osc2Saw.amplitude = 0
                osc2Square.amplitude = 0
                osc2Triangle.amplitude = 0
            case "saw":
                osc2Sine.amplitude = 0
                osc2Saw.amplitude = osc2Amplitude
                osc2Square.amplitude = 0
                osc2Triangle.amplitude = 0
            case "square":
                osc2Sine.amplitude = 0
                osc2Saw.amplitude = 0
                osc2Square.amplitude = osc2Amplitude
                osc2Triangle.amplitude = 0
            case "triangle":
                osc2Sine.amplitude = 0
                osc2Saw.amplitude = 0
                osc2Square.amplitude = 0
                osc2Triangle.amplitude = osc2Amplitude
            default:
                print("unrecognised osc2 waveform")
            }
        }
    }
    
    //Set the tuning according to the selected tuning buttons
    func setOscillatorTuning(tuningID: Int) {
        switch tuningID {
        case 0:
            osc1Sine.frequency = osc1Frequency/2
            osc1Saw.frequency = osc1Frequency/2
            osc1Square.frequency = osc1Frequency/2
            osc1Triangle.frequency = osc1Frequency/2
        case 1:
            osc1Sine.frequency = osc1Frequency/1.5
            osc1Saw.frequency = osc1Frequency/1.5
            osc1Square.frequency = osc1Frequency/1.5
            osc1Triangle.frequency = osc1Frequency/1.5
        case 2:
            osc1Sine.frequency = osc1Frequency/1.25
            osc1Saw.frequency = osc1Frequency/1.25
            osc1Square.frequency = osc1Frequency/1.25
            osc1Triangle.frequency = osc1Frequency/1.25
        case 3:
            osc1Sine.frequency = osc1Frequency
            osc1Saw.frequency = osc1Frequency
            osc1Square.frequency = osc1Frequency
            osc1Triangle.frequency = osc1Frequency
        case 4:
            osc1Sine.frequency = osc1Frequency*1.25
            osc1Saw.frequency = osc1Frequency*1.25
            osc1Square.frequency = osc1Frequency*1.25
            osc1Triangle.frequency = osc1Frequency*1.25
        case 5:
            osc1Sine.frequency = osc1Frequency*1.5
            osc1Saw.frequency = osc1Frequency*1.5
            osc1Square.frequency = osc1Frequency*1.5
            osc1Triangle.frequency = osc1Frequency*1.5
        case 6:
            osc1Sine.frequency = osc1Frequency*2
            osc1Saw.frequency = osc1Frequency*2
            osc1Square.frequency = osc1Frequency*2
            osc1Triangle.frequency = osc1Frequency*2
        case 7:
            osc2Sine.frequency = osc2Frequency/2
            osc2Saw.frequency = osc2Frequency/2
            osc2Square.frequency = osc2Frequency/2
            osc2Triangle.frequency = osc2Frequency/2
        case 8:
            osc2Sine.frequency = osc2Frequency/1.5
            osc2Saw.frequency = osc2Frequency/1.5
            osc2Square.frequency = osc2Frequency/1.5
            osc2Triangle.frequency = osc2Frequency/1.5
        case 9:
            osc2Sine.frequency = osc2Frequency/1.25
            osc2Saw.frequency = osc2Frequency/1.25
            osc2Square.frequency = osc2Frequency/1.25
            osc2Triangle.frequency = osc2Frequency/1.25
        case 10:
            osc2Sine.frequency = osc2Frequency
            osc2Saw.frequency = osc2Frequency
            osc2Square.frequency = osc2Frequency
            osc2Triangle.frequency = osc2Frequency
        case 11:
            osc2Sine.frequency = osc2Frequency*1.25
            osc2Saw.frequency = osc2Frequency*1.25
            osc2Square.frequency = osc2Frequency*1.25
            osc2Triangle.frequency = osc2Frequency*1.25
        case 12:
            osc2Sine.frequency = osc2Frequency*1.5
            osc2Saw.frequency = osc2Frequency*1.5
            osc2Square.frequency = osc2Frequency*1.5
            osc2Triangle.frequency = osc2Frequency*1.5
        case 13:
            osc2Sine.frequency = osc2Frequency*2
            osc2Saw.frequency = osc2Frequency*2
            osc2Square.frequency = osc2Frequency*2
            osc2Triangle.frequency = osc2Frequency*2
        default:
            print("tuning not recognised")
        }
    }
    
    //Change the oscillator amplitude based on the volume sliders for each oscillator
    func setOscillatorAmplitude(amplitude: Double, osc: Int, waveform: String) {
        
        //Change oscillator 1 amplitude
        if osc == 1 {
            osc1Amplitude = amplitude
            switch waveform {
            case "sine":
                osc1Sine.amplitude = amplitude
            case "saw":
                osc1Saw.amplitude = amplitude
            case "square":
                osc1Square.amplitude = amplitude
            case "triangle":
                osc1Triangle.amplitude = amplitude
            default:
                print("unrecognised osc1 waveform")
            }
        }
        //Change oscillator 2 amplitude
        else if osc == 2 {
            osc2Amplitude = amplitude
            switch waveform {
            case "sine":
                osc2Sine.amplitude = amplitude
            case "saw":
                osc2Saw.amplitude = amplitude
            case "square":
                osc2Square.amplitude = amplitude
            case "triangle":
                osc2Triangle.amplitude = amplitude
            default:
                print("unrecognised osc2 waveform")
            }
        }
        
        //Change noise oscillator amplitude
        else if osc == 3 {
            oscNoise.amplitude = amplitude
        }
    }
    
    //MARK: Filter Functions
    
    //Set the cutoff filter frequency
    func setFilterCutoff(cutoffFrequency: Double) {
        lowpassFilter.cutoffFrequency = cutoffFrequency
    }
    
    //Set filter resonance
    func setFilterResonance(resonance: Double) {
        lowpassFilter.resonance = resonance
    }
    
    //MARK: ADSR Functions
    
    //Adjust the synthesiser attack time
    func changeSynthAttack(attackTime: Double) {
        osc1SineAmpEnv.attackDuration = attackTime
        osc1SawAmpEnv.attackDuration = attackTime
        osc1SquareAmpEnv.attackDuration = attackTime
        osc1TriangleAmpEnv.attackDuration = attackTime
        
        osc2SineAmpEnv.attackDuration = attackTime
        osc2SawAmpEnv.attackDuration = attackTime
        osc2SquareAmpEnv.attackDuration = attackTime
        osc2TriangleAmpEnv.attackDuration = attackTime
        
        oscNoiseAmpEnv.attackDuration = attackTime
    }
    
    //Adjust the synthesiser decay time
    func changeSynthDecay(decayTime: Double) {
        osc1SineAmpEnv.decayDuration = decayTime
        osc1SawAmpEnv.decayDuration = decayTime
        osc1SquareAmpEnv.decayDuration = decayTime
        osc1TriangleAmpEnv.decayDuration = decayTime
        
        osc2SineAmpEnv.decayDuration = decayTime
        osc2SawAmpEnv.decayDuration = decayTime
        osc2SquareAmpEnv.decayDuration = decayTime
        osc2TriangleAmpEnv.decayDuration = decayTime
        
        oscNoiseAmpEnv.decayDuration = decayTime
    }
    
    //Adjust the synthesiser sustain level
    func changeSynthSustain(sustainLevel: Double) {
        osc1SineAmpEnv.sustainLevel = sustainLevel
        osc1SawAmpEnv.sustainLevel = sustainLevel
        osc1SquareAmpEnv.sustainLevel = sustainLevel
        osc1TriangleAmpEnv.sustainLevel = sustainLevel
        
        osc2SineAmpEnv.sustainLevel = sustainLevel
        osc2SawAmpEnv.sustainLevel = sustainLevel
        osc2SquareAmpEnv.sustainLevel = sustainLevel
        osc2TriangleAmpEnv.sustainLevel = sustainLevel
        
        
        oscNoiseAmpEnv.sustainLevel = sustainLevel
    }
    
    //Adjust the synthesiser release time
    func changeSynthRelease(releaseTime: Double) {
        osc1SineAmpEnv.releaseDuration = releaseTime
        osc1SawAmpEnv.releaseDuration = releaseTime
        osc1SquareAmpEnv.releaseDuration = releaseTime
        osc1TriangleAmpEnv.releaseDuration = releaseTime
        
        osc2SineAmpEnv.releaseDuration = releaseTime
        osc2SawAmpEnv.releaseDuration = releaseTime
        osc2SquareAmpEnv.releaseDuration = releaseTime
        osc2TriangleAmpEnv.releaseDuration = releaseTime
        
        
        oscNoiseAmpEnv.releaseDuration = releaseTime
    }
}
