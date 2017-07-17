//
//  DrumEngine.swift
//  Ambience
//
//  Created by Y0070749 on 31/01/2017.
//  Copyright © 2017 TrommelAudio. All rights reserved.
//

import Foundation
import AudioKit

class DrumEngine {
    
    //MARK: Drum Engine Class Variables
    var kickSampler: AKSampler!
    var rimSampler: AKSampler!
    var snareSampler: AKSampler!
    var clapSampler: AKSampler!
    var clHiHatSampler: AKSampler!
    var opHiHatSampler: AKSampler!
    var hiTomSampler: AKSampler!
    var midTomSampler: AKSampler!
    var loTomSampler: AKSampler!
    var drumMixer: AKMixer!
    
    var kickSequence: Array<Bool>!
    var rimSequence: Array<Bool>!
    var snareSequence: Array<Bool>!
    var clapSequence: Array<Bool>!
    var closedHiHatSequence: Array<Bool>!
    var openHiHatSequence: Array<Bool>!
    var hiTomSequence: Array<Bool>!
    var midTomSequence: Array<Bool>!
    var loTomSequence: Array<Bool>!

    init() {
        //Initialise and load the drum trigger pad samples
        kickSampler = AKSampler()
        try! kickSampler.loadWav("Kick")
        rimSampler = AKSampler()
        try! rimSampler.loadWav("Rim")
        snareSampler = AKSampler()
        try! snareSampler.loadWav("Snare")
        clapSampler = AKSampler()
        try! clapSampler.loadWav("Clap")
        clHiHatSampler = AKSampler()
        try! clHiHatSampler.loadWav("CL_HIHAT")
        opHiHatSampler = AKSampler()
        try! opHiHatSampler.loadWav("Op_HIHAT")
        hiTomSampler = AKSampler()
        try! hiTomSampler.loadWav("HiTom")
        midTomSampler = AKSampler()
        try! midTomSampler.loadWav("MidTom")
        loTomSampler = AKSampler()
        try! loTomSampler.loadWav("LoTom")
        
        //Route the outputs of each sampler through the drumMixer
        drumMixer = AKMixer(kickSampler, rimSampler, snareSampler, clapSampler, clHiHatSampler, opHiHatSampler, hiTomSampler, midTomSampler, loTomSampler)
        drumMixer.start()
        
        //Intialise the drum sequence arrays to false (i.e. no buttons selected)
        kickSequence = Array(repeating: false, count: 16)
        rimSequence = Array(repeating: false, count: 16)
        snareSequence = Array(repeating: false, count: 16)
        clapSequence = Array(repeating: false, count: 16)
        closedHiHatSequence = Array(repeating: false, count: 16)
        openHiHatSequence = Array(repeating: false, count: 16)
        hiTomSequence = Array(repeating: false, count: 16)
        midTomSequence = Array(repeating: false, count: 16)
        loTomSequence = Array(repeating: false, count: 16)
    }
    
    //MARK: Drum Functions
    
    //Play the respective drum sample
    func playSample(sampleID: Int){
        switch sampleID {
        case 0:
            kickSampler.play()
        case 1:
            rimSampler.play()
        case 2:
            snareSampler.play()
        case 3:
            clHiHatSampler.play()
        case 4:
            opHiHatSampler.play()
        case 5:
            clapSampler.play()
        case 6:
            hiTomSampler.play()
        case 7:
            midTomSampler.play()
        case 8:
            loTomSampler.play()
        default:
            print("sampleID for drum trigger pad not recognised")
        }
    }
    
    //Obtain the time interval, given the current value of the tempo slider
    func getInterval(tempo: Float) -> Double{
        var interval: Double
        //Sequence step interval is 60(seconds in minute)/(4*tempo(bpm)) for a 16th (quarter) step sequencer
        interval = Double(15/Double(tempo))
        return interval
    }
    
    //Variables to keep track of the current sequencer step
    var sequenceStep = 0
    var currentStep = 0
    
    func playStep() {
        currentStep = sequenceStep % 16
        //If the sampler instrument sequence array returns true at a particular sequence step,
        //play the respective sampler instrument
        if kickSequence[currentStep] {
            kickSampler.play()
        }
        if rimSequence[currentStep]{
            rimSampler.play()
        }
        if snareSequence[currentStep]{
            snareSampler.play()
        }
        if closedHiHatSequence[currentStep]{
            clHiHatSampler.play()
        }
        if openHiHatSequence[currentStep] {
            opHiHatSampler.play()
        }
        if clapSequence[currentStep] {
            clapSampler.play()
        }
        if hiTomSequence[currentStep]{
            hiTomSampler.play()
        }
        if midTomSequence[currentStep]{
            midTomSampler.play()
        }
        if loTomSequence[currentStep] {
            loTomSampler.play()
        }
        //Increment the sequence step
        sequenceStep += 1
    }
}
