//

import Foundation
import AVFoundation

//Declares a delegate to update the progress bar for conformance, all structs that extend this procol must conform to it
protocol ProgressUpdateDelegate: AnyObject {
    func updateProgressBar(value: Float)
}

class TimerManager{
    
    //Sets delegate to the ProgressUpdateDelegate for conformance
    weak var delegate: ProgressUpdateDelegate?
    
    //Example of how to declare an empty dictionary
    var myDictionary: [String : Int] = [:]
    
    //Declares an instance of timer
    var timer = Timer()
    //Declares an instance of AudioPlayer
    var player: AVAudioPlayer?

     let eggTimes = [HardnessModel(h: "Soft", t: 300),
                     HardnessModel(h: "Medium", t: 420),
                     HardnessModel(h: "Hard", t: 720)]
    var totalTime = 0
    var secondsPassed = 0
    var hardness: String = ""
    
    //Method to stop the timer, resets elapsed time and stops the alarm if it's currently playing
    func stopTimer() {
        timer.invalidate()
        secondsPassed = 0
        if player?.isPlaying == true {
            player?.stop()
        }
    }
    
    //Method to set total time based on user selection at the ViewController
    func setTotalTime(hardness: String) {
        for checkHardness in eggTimes {
            if checkHardness.hard == hardness {
                totalTime = checkHardness.time
                break
            }
        }
    }
    
    //Method to run the timer and calls updateTimer
    func runTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    //Method to update the timer
    @objc func updateTimer() {
        //If time is not over this evaluates to true
        if secondsPassed < totalTime {
            secondsPassed += 1
            let progress = Float(secondsPassed) / Float(totalTime)
            //Updates the progress bar with a new value until timer runs out
            delegate?.updateProgressBar(value: progress)
        }
        //If timer is over this evaluates to true
        else if Float(secondsPassed) >= Float(totalTime) {
            //Creates a path to alarm audio file
            guard let path = Bundle.main.path(forResource: "alarm_sound", ofType:"mp3") else {
                return }
            //Create a url using the path
            let url = URL(fileURLWithPath: path)
            //Tries to play audio file from the url
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player?.play()
            } catch let error {
                print(error.localizedDescription)
            }
            //Resets variables and time
            timer.invalidate()
            secondsPassed = 0
        }
    }
}
