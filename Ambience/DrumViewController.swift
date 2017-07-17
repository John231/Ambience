//
//  DrumController.swift
//  Ambience
//
//  Created by Y0070749 on 19/12/2016.
//  Copyright © TrommelAudio. All rights reserved.
//

import Foundation
import AudioKit

//Global signal chain to allow for connection between drum, synthesiser & looop recorder models according to MVC methodology
let signalRouter = AudioRouter()
let drumModel = DrumEngine()

class DrumViewController: UIViewController {
    //MARK: 3x3 trigger pad grid buttons
    @IBOutlet weak var kickPad: UIButton!
    @IBOutlet weak var rimPad: UIButton!
    @IBOutlet weak var snarePad: UIButton!
    @IBOutlet weak var closedHiHatPad: UIButton!
    @IBOutlet weak var openHiHatPad: UIButton!
    @IBOutlet weak var clapPad: UIButton!
    @IBOutlet weak var hiTomPad: UIButton!
    @IBOutlet weak var midTomPad: UIButton!
    @IBOutlet weak var loTomPad: UIButton!
    
    //Slider and labels to accomodate sequencer tempo change
    @IBOutlet weak var tempoSlider: UISlider!
    @IBOutlet weak var tempoLabel: UILabel!
    
    //MARK: 16-step sequencer buttons
    @IBOutlet weak var seqZero: UIButton!
    @IBOutlet weak var seqOne: UIButton!
    @IBOutlet weak var seqTwo: UIButton!
    @IBOutlet weak var seqThree: UIButton!
    @IBOutlet weak var seqFour: UIButton!
    @IBOutlet weak var seqFive: UIButton!
    @IBOutlet weak var seqSix: UIButton!
    @IBOutlet weak var seqSeven: UIButton!
    @IBOutlet weak var seqEight: UIButton!
    @IBOutlet weak var seqNine: UIButton!
    @IBOutlet weak var seqTen: UIButton!
    @IBOutlet weak var seqEleven: UIButton!
    @IBOutlet weak var seqTwelve: UIButton!
    @IBOutlet weak var seqThirteen: UIButton!
    @IBOutlet weak var seqFourteen: UIButton!
    @IBOutlet weak var seqFifteen: UIButton!
    
    //MARK: 16-step sequencer lights
    @IBOutlet weak var seqLightZero: UIButton!
    @IBOutlet weak var seqLightOne: UIButton!
    @IBOutlet weak var seqLightTwo: UIButton!
    @IBOutlet weak var seqLightThree: UIButton!
    @IBOutlet weak var seqLightFour: UIButton!
    @IBOutlet weak var seqLightFive: UIButton!
    @IBOutlet weak var seqLightSix: UIButton!
    @IBOutlet weak var seqLightSeven: UIButton!
    @IBOutlet weak var seqLightEight: UIButton!
    @IBOutlet weak var seqLightNine: UIButton!
    @IBOutlet weak var seqLightTen: UIButton!
    @IBOutlet weak var seqLightEleven: UIButton!
    @IBOutlet weak var seqLightTwelve: UIButton!
    @IBOutlet weak var seqLightThirteen: UIButton!
    @IBOutlet weak var seqLightFourteen: UIButton!
    @IBOutlet weak var seqLightFifteen: UIButton!
    
    //Dictionary for storing step sequencer buttons
    var seqButtonDict: [Int: UIButton]!
    
    //Timer to enable timed step sequencing
    var sequenceTimer: Timer!
    
    //Button for starting the step sequencing
    @IBOutlet weak var playSequence: UIButton!
    
    //Control to allow the user to change drum instrument
    @IBOutlet weak var sampleSelector: UISegmentedControl!
    
    //Variable to keep track of selected sequence of the drum instrument segment control
    var selectedSequence: Int!
    
    //MARK: - Class functions
    override func viewDidLoad() {
        
        //Setup the audio chain between the drum, synth and loop recorder modules
        signalRouter.setupOutput(device1: drumModel.drumMixer, device2: synthModel.lowpassFilter, device3: recordingModel.filePlayer)
        signalRouter.start()
        
        //Instantiate the timer responsible for sequencing tasks
        sequenceTimer = Timer()
        
        //Initialise a dictionary for keeping track of the sequence
        seqButtonDict = [0:seqZero, 1:seqOne, 2:seqTwo, 3:seqThree,
                         4:seqFour, 5:seqFive, 6:seqSix, 7:seqSeven,
                         8:seqEight, 9:seqNine, 10:seqTen, 11:seqEleven,
                         12:seqTwelve, 13: seqThirteen, 14:seqFourteen,
                         15:seqFifteen]
        
        //Set the selected sequence variable to the currently selected drum instrument
        selectedSequence = sampleSelector.selectedSegmentIndex
        
        //Update the tempo label with the current value of the tempo slider
        tempoLabel.text = String(format: "%0.0f", tempoSlider.value)
    }
    //MARK: Trigger pad function
    
    //Handle user pressing a drum trigger pad
    @IBAction func handleTriggerPadPress(_ sender: UIButton) {
        drumModel.playSample(sampleID: sender.tag)
    }
    
    //MARK: Tempo function
    
    //Handle user changing slider position
    @IBAction func handleTempoChange(_ sender: UISlider) {
        tempoLabel.text = String(format: "%0.0f", tempoSlider.value)
    }
    
    //MARK: Step sequencer functions
    
    //Handle step sequence button being selected
    @IBAction func handleButtonPress(_ sender: UIButton) {
        //Determine using illuminate() function which returns a Bool, whether selected sequencer button is to be illuminated or not
        if illuminate(sequenceStepId: sender.tag) {
            //Change sequencer button to green 'highlighted' version (selected state)
            highlightSequenceButton(buttonID: sender.tag)
        }
        else {
            //If the button has previously been selected then toggle the sequence button off
            //and return to the original colour (off state)
            deHighlightSequenceButton(buttonID: sender.tag)
        }
        
    }
    
    //Function to change the button image to the green 'highlight' image version
    func highlightSequenceButton(buttonID: Int){
        switch buttonID {
        case 0: seqZero.setImage(UIImage(named: "sequenceOneHighlight") , for: UIControlState.normal)
        case 1: seqOne.setImage(UIImage(named: "sequenceTwoHighlight") , for: UIControlState.normal)
        case 2: seqTwo.setImage(UIImage(named: "sequenceThreeHighlight") , for: UIControlState.normal)
        case 3: seqThree.setImage(UIImage(named: "sequenceFourHighlight") , for: UIControlState.normal)
        case 4: seqFour.setImage(UIImage(named: "sequenceFiveHighlight") , for: UIControlState.normal)
        case 5: seqFive.setImage(UIImage(named: "sequenceSixHighlight") , for: UIControlState.normal)
        case 6: seqSix.setImage(UIImage(named: "sequenceSevenHighlight") , for: UIControlState.normal)
        case 7: seqSeven.setImage(UIImage(named: "sequenceEightHighlight") , for: UIControlState.normal)
        case 8: seqEight.setImage(UIImage(named: "sequenceNineHighlight") , for: UIControlState.normal)
        case 9: seqNine.setImage(UIImage(named: "sequenceTenHighlight") , for: UIControlState.normal)
        case 10: seqTen.setImage(UIImage(named: "sequenceElevenHighlight") , for: UIControlState.normal)
        case 11: seqEleven.setImage(UIImage(named: "sequenceTwelveHighlight") , for: UIControlState.normal)
        case 12: seqTwelve.setImage(UIImage(named: "sequenceThirteenHighlight") , for: UIControlState.normal)
        case 13: seqThirteen.setImage(UIImage(named: "sequenceFourteenHighlight") , for: UIControlState.normal)
        case 14: seqFourteen.setImage(UIImage(named: "sequenceFifteenHighlight") , for: UIControlState.normal)
        case 15: seqFifteen.setImage(UIImage(named: "sequenceSixteenHighlight") , for: UIControlState.normal)
        default:
            print("sequence step tag not recognised for changing to green selected state")
        }
    }
    
    //Function to return button image to original 'unselected' image version
    func deHighlightSequenceButton(buttonID: Int) {
        switch buttonID {
        case 0: seqZero.setImage(UIImage(named: "sequenceOne"), for: UIControlState.normal)
        case 1: seqOne.setImage(UIImage(named: "sequenceTwo"), for: UIControlState.normal)
        case 2: seqTwo.setImage(UIImage(named: "sequenceThree"), for: UIControlState.normal)
        case 3: seqThree.setImage(UIImage(named: "sequenceFour"), for: UIControlState.normal)
        case 4: seqFour.setImage(UIImage(named: "sequenceFive"), for: UIControlState.normal)
        case 5: seqFive.setImage(UIImage(named: "sequenceSix"), for: UIControlState.normal)
        case 6: seqSix.setImage(UIImage(named: "sequenceSeven"), for: UIControlState.normal)
        case 7: seqSeven.setImage(UIImage(named: "sequenceEight"), for: UIControlState.normal)
        case 8: seqEight.setImage(UIImage(named: "sequenceNine"), for: UIControlState.normal)
        case 9: seqNine.setImage(UIImage(named: "sequenceTen"), for: UIControlState.normal)
        case 10: seqTen.setImage(UIImage(named: "sequenceEleven"), for: UIControlState.normal)
        case 11: seqEleven.setImage(UIImage(named: "sequenceTwelve"), for: UIControlState.normal)
        case 12: seqTwelve.setImage(UIImage(named: "sequenceThirteen"), for: UIControlState.normal)
        case 13: seqThirteen.setImage(UIImage(named: "sequenceFourteen"), for: UIControlState.normal)
        case 14: seqFourteen.setImage(UIImage(named: "sequenceFifteen"), for: UIControlState.normal)
        case 15: seqFifteen.setImage(UIImage(named: "sequenceSixteen"), for: UIControlState.normal)
        default:
            print("sender tag not recognised line 165 DrumViewController")
        }
    }
    
    //Function for determining which sequence buttons to illuminate
    func illuminate(sequenceStepId: Int) -> Bool {
        
        //Variable for toggling the sequence step buttons
        var illuminate = false
        
        //Check which sampler instument is currently selected
        switch selectedSequence {
            
        //Kick drum
        case 0:
            //If the kick drum sequence step has not been highlighted previously,
            //set the kick sequence array at the respective sequence position to true
            //and then set the illuminate variable to true to illuminate the sequence step button
            //at the respective sequence step index
            
            if !drumModel.kickSequence[sequenceStepId] {
                drumModel.kickSequence[sequenceStepId] = true
                illuminate = true
            }
                //If the kick drum sequence has been highlighted in this position, toggle off the sequence
                //step button and set the kick drum sequence at this index to false
            else {
                drumModel.kickSequence[sequenceStepId] = false
                illuminate = false
            }
            
        //Rim drum
        case 1:
            //If the rim sequence step has not been highlighted previously,
            //set the rim array at the respective sequence position to true
            //and then set the illuminate variable to true to illuminate the sequence step button
            //at the respective sequence step index
            if !drumModel.rimSequence[sequenceStepId] {
                drumModel.rimSequence[sequenceStepId] = true
                illuminate = true
            }
                //If the rim sequence has been highlighted in this position, toggle off the sequence
                //step button and set the rim sequence at this index to false
            else {
                drumModel.rimSequence[sequenceStepId] = false
                illuminate = false
            }
            
        //Snare
        case 2:
            //If the snare sequence step has not been highlighted previously,
            //set the snare sequence array at the respective sequence position to true
            //and then set the illuminate variable to true to illuminate the sequence step button
            //at the respective sequence step index
            if !drumModel.snareSequence[sequenceStepId] {
                drumModel.snareSequence[sequenceStepId] = true
                illuminate = true
            }
                //If the snare sequence has been highlighted in this position, toggle off the sequence
                //step button and set the snare sequence at this index to false
            else {
                drumModel.snareSequence[sequenceStepId] = false
                illuminate = false
            }
            
        //Clap
        case 3:
            //If the clap sequence step has not been highlighted previously,
            //set the clap sequence array at the respective sequence position to true
            //and then set the illuminate variable to true to illuminate the sequence step button
            //at the respective sequence step index
            if !drumModel.clapSequence[sequenceStepId] {
                drumModel.clapSequence[sequenceStepId] = true
                illuminate = true
            }
                //If the clap sequence has been highlighted in this position, toggle off the sequence
                //step button and set the clap sequence at this index to false
            else {
                drumModel.clapSequence[sequenceStepId] = false
                illuminate = false
            }
        //Closed Hi Hat
        case 4:
            //If the closed hi hat sequence step has not been highlighted previously,
            //set the closed hi hat sequence array at the respective sequence position to true
            //and then set the illuminate variable to true to illuminate the sequence step button
            //at the respective sequence step index
            if !drumModel.closedHiHatSequence[sequenceStepId] {
                drumModel.closedHiHatSequence[sequenceStepId] = true
                illuminate = true
            }
                //If the clap sequence has been highlighted in this position, toggle off the sequence
                //step button and set the clap sequence at this index to false
            else {
                drumModel.closedHiHatSequence[sequenceStepId] = false
                illuminate = false
            }
        //Open Hi Hat
        case 5:
            //If the open hi hat sequence step has not been highlighted previously,
            //set the open hi hat sequence array at the respective sequence position to true
            //and then set the illuminate variable to true to illuminate the sequence step button
            //at the respective sequence step index
            if !drumModel.openHiHatSequence[sequenceStepId] {
                drumModel.openHiHatSequence[sequenceStepId] = true
                illuminate = true
            }
                //If the open hi hat sequence has been highlighted in this position, toggle off the sequence
                //step button and set the open hi hat sequence at this index to false
            else {
                drumModel.openHiHatSequence[sequenceStepId] = false
                illuminate = false
            }
        //Hi Tom
        case 6:
            //If the hi tom sequence step has not been highlighted previously,
            //set the hi tom sequence array at the respective sequence position to true
            //and then set the illuminate variable to true to illuminate the sequence step button
            //at the respective sequence step index
            if !drumModel.hiTomSequence[sequenceStepId] {
                drumModel.hiTomSequence[sequenceStepId] = true
                illuminate = true
            }
                //If the hi tom sequence has been highlighted in this position, toggle off the sequence
                //step button and set the hi tom sequence at this index to false
            else {
                drumModel.hiTomSequence[sequenceStepId] = false
                illuminate = false
            }
        //Mid Tom
        case 7:
            //If the mid tom sequence step has not been highlighted previously,
            //set the mid tom sequence array at the respective sequence position to true
            //and then set the illuminate variable to true to illuminate the sequence step button
            //at the respective sequence step index
            if !drumModel.midTomSequence[sequenceStepId] {
                drumModel.midTomSequence[sequenceStepId] = true
                illuminate = true
            }
                //If the mid tom sequence has been highlighted in this position, toggle off the sequence
                //step button and set the mid tom sequence at this index to false
            else {
                drumModel.midTomSequence[sequenceStepId] = false
                illuminate = false
            }
        //Lo Tom
        case 8:
            //If the lo tom sequence step has not been highlighted previously,
            //set the lo tom sequence array at the respective sequence position to true
            //and then set the illuminate variable to true to illuminate the sequence step button
            //at the respective sequence step index
            if !drumModel.loTomSequence[sequenceStepId] {
                drumModel.loTomSequence[sequenceStepId] = true
                illuminate = true
            }
                //If the lo tom sequence has been highlighted in this position, toggle off the sequence
                //step button and set the lo tom sequence at this index to false
            else {
                drumModel.loTomSequence[sequenceStepId] = false
                illuminate = false
            }
        default:
            print("Sequencer step ID not recognised")
        }
        
        //Return the illuminate variable
        return illuminate
    }
    
    var startButtonSelected = true //Variable used to determine button state
    
    //Handle step sequencer play button being pressed
    @IBAction func handleStepSequencer(_ sender: UIButton) {
        
        //Logic to allow for toggle switch functionality of play button
        if startButtonSelected {
            playSequence.setImage(UIImage(named: "stopIcon"), for: UIControlState.normal)
            startButtonSelected = false
            
            //Calculate timing interval based on current value of the tempo slider
            let interval = drumModel.getInterval(tempo: tempoSlider.value)
            
            //Create a timer that will repeat the stepSequence function every interval
            sequenceTimer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(stepSequence), userInfo: nil, repeats: true)
            
        }
        else {
            playSequence.setImage(UIImage(named: "playIcon"), for: UIControlState.normal)
            
            //Invalidate the timer to stop sequencing
            sequenceTimer.invalidate()
            startButtonSelected = true
        }
    }
    
    var stepCounter = 0 //Variable to keep track of current step sequencer location
    
    //Play sequence and illuminate sequencer step buttons to indicate current position
    func stepSequence(){
        
        //Call playStep function in the drum model
        drumModel.playStep()
        
        //For each step position, turn the step sequence indicator on and turn the previous
        //step indicator off
        switch stepCounter % 16 {
        case 0:
            seqLightZero.setImage(UIImage(named: "sequencerOn"), for: UIControlState.normal)
            seqLightFifteen.setImage(UIImage(named: "sequencerOff"), for: UIControlState.normal)
        case 1:
            seqLightOne.setImage(UIImage(named: "sequencerOn"), for: UIControlState.normal)
            seqLightZero.setImage(UIImage(named: "sequencerOff"), for: UIControlState.normal)
        case 2:
            seqLightTwo.setImage(UIImage(named: "sequencerOn"), for: UIControlState.normal)
            seqLightOne.setImage(UIImage(named: "sequencerOff"), for: UIControlState.normal)
        case 3:
            seqLightThree.setImage(UIImage(named: "sequencerOn"), for: UIControlState.normal)
            seqLightTwo.setImage(UIImage(named: "sequencerOff"), for: UIControlState.normal)
        case 4:
            seqLightFour.setImage(UIImage(named: "sequencerOn"), for: UIControlState.normal)
            seqLightThree.setImage(UIImage(named: "sequencerOff"), for: UIControlState.normal)
        case 5:
            seqLightFive.setImage(UIImage(named: "sequencerOn"), for: UIControlState.normal)
            seqLightFour.setImage(UIImage(named: "sequencerOff"), for: UIControlState.normal)
        case 6:
            seqLightSix.setImage(UIImage(named: "sequencerOn"), for: UIControlState.normal)
            seqLightFive.setImage(UIImage(named: "sequencerOff"), for: UIControlState.normal)
        case 7:
            seqLightSeven.setImage(UIImage(named: "sequencerOn"), for: UIControlState.normal)
            seqLightSix.setImage(UIImage(named: "sequencerOff"), for: UIControlState.normal)
        case 8:
            seqLightEight.setImage(UIImage(named: "sequencerOn"), for: UIControlState.normal)
            seqLightSeven.setImage(UIImage(named: "sequencerOff"), for: UIControlState.normal)
        case 9:
            seqLightNine.setImage(UIImage(named: "sequencerOn"), for: UIControlState.normal)
            seqLightEight.setImage(UIImage(named: "sequencerOff"), for: UIControlState.normal)
        case 10:
            seqLightTen.setImage(UIImage(named: "sequencerOn"), for: UIControlState.normal)
            seqLightNine.setImage(UIImage(named: "sequencerOff"), for: UIControlState.normal)
        case 11:
            seqLightEleven.setImage(UIImage(named: "sequencerOn"), for: UIControlState.normal)
            seqLightTen.setImage(UIImage(named: "sequencerOff"), for: UIControlState.normal)
        case 12:
            seqLightTwelve.setImage(UIImage(named: "sequencerOn"), for: UIControlState.normal)
            seqLightEleven.setImage(UIImage(named: "sequencerOff"), for: UIControlState.normal)
        case 13:
            seqLightThirteen.setImage(UIImage(named: "sequencerOn"), for: UIControlState.normal)
            seqLightTwelve.setImage(UIImage(named: "sequencerOff"), for: UIControlState.normal)
        case 14:
            seqLightFourteen.setImage(UIImage(named: "sequencerOn"), for: UIControlState.normal)
            seqLightThirteen.setImage(UIImage(named: "sequencerOff"), for: UIControlState.normal)
        case 15:
            seqLightFifteen.setImage(UIImage(named: "sequencerOn"), for: UIControlState.normal)
            seqLightFourteen.setImage(UIImage(named: "sequencerOff"), for: UIControlState.normal)
        default:
            print("step number not recognised")
        }
        
        //Increment the sequence step by 1
        stepCounter += 1
    }
    
    //Update the step sequencer buttons according to the currently selected instrument channel
    @IBAction func handleSequenceSelector(_ sender: UISegmentedControl) {
        selectedSequence = sampleSelector.selectedSegmentIndex
        updateSequenceButtons(sequence: sampleSelector.selectedSegmentIndex)
    }
    
    //Function to update the sequencer buttons when the sequence is changed
    func updateSequenceButtons(sequence: Int){
        
        switch sequence {
            
        //Kick drum
        case 0:
            //Loop once through the kick drum sequence array
            for i in 0..<16 {
                //Illuminate the respective sequence step for steps where the kick drum has been set to trigger
                if drumModel.kickSequence[i]{
                    highlightSequenceButton(buttonID: i)
                }
                    //Otherwise set the default sequence buttons
                else {
                    deHighlightSequenceButton(buttonID: i)
                }
            }
            
        //Rim
        case 1:
            //Loop once through the rim drum sequence array
            for i in 0..<16 {
                //Illuminate the respective sequence step for steps where the snare drum has been set to trigger
                if drumModel.rimSequence[i]{
                    highlightSequenceButton(buttonID: i)
                }
                    //Otherwise set the default sequence buttons
                else {
                    deHighlightSequenceButton(buttonID: i)
                }
            }
            
        //Snare
        case 2:
            //Loop once through the snare drum sequence array
            for i in 0..<16 {
                //Illuminate the respective sequence step for steps where the snare has been set to trigger
                if drumModel.snareSequence[i]{
                    highlightSequenceButton(buttonID: i)
                }
                    //Otherwise set the default sequence buttons
                else {
                    deHighlightSequenceButton(buttonID: i)
                }
            }
            
        //Clap
        case 3:
            //Loop once through the clap sequence array
            for i in 0..<16 {
                //Illuminate the respective sequence step for steps where the clap has been set to trigger
                if drumModel.clapSequence[i]{
                    highlightSequenceButton(buttonID: i)
                }
                    //Otherwise set the default sequence buttons
                else {
                    deHighlightSequenceButton(buttonID: i)
                }
            }
        //Closed Hi Hat
        case 4:
            //Loop once through the closed hi hat sequence array
            for i in 0..<16 {
                //Illuminate the respective sequence step for steps where the closed hi hat has been set to trigger
                if drumModel.closedHiHatSequence[i]{
                    highlightSequenceButton(buttonID: i)
                }
                    //Otherwise set the default sequence buttons
                else {
                    deHighlightSequenceButton(buttonID: i)
                }
            }
            
        //Open Hi Hat
        case 5:
            //Loop once through the open hi hat sequence array
            for i in 0..<16 {
                //Illuminate the respective sequence step for steps where the open hi hat has been set to trigger
                if drumModel.openHiHatSequence[i]{
                    highlightSequenceButton(buttonID: i)
                }
                    //Otherwise set the default sequence buttons
                else {
                    deHighlightSequenceButton(buttonID: i)
                }
            }
        //Hi Tom
        case 6:
            //Loop once through the hi tom drum sequence array
            for i in 0..<16 {
                //Illuminate the respective sequence step for steps where the hi tom drum has been set to trigger
                if drumModel.hiTomSequence[i]{
                    highlightSequenceButton(buttonID: i)
                }
                    //Otherwise set the default sequence buttons
                else {
                    deHighlightSequenceButton(buttonID: i)
                }
            }
        //Mid Tom
        case 7:
            //Loop once through the mid tom drum sequence array
            for i in 0..<16 {
                //Illuminate the respective sequence step for steps where the mid tom drum has been set to trigger
                if drumModel.midTomSequence[i]{
                    highlightSequenceButton(buttonID: i)
                }
                    //Otherwise set the default sequence buttons
                else {
                    deHighlightSequenceButton(buttonID: i)
                }
            }
        //Lo Tom
        case 8:
            //Loop once through the lo tom drum sequence array
            for i in 0..<16 {
                //Illuminate the respective sequence step for steps where the low tom drum has been set to trigger
                if drumModel.loTomSequence[i]{
                    highlightSequenceButton(buttonID: i)
                }
                    //Otherwise set the default sequence buttons
                else {
                    deHighlightSequenceButton(buttonID: i)
                }
            }
        default:
            print("Step index not recognised")
        }
    }
}
