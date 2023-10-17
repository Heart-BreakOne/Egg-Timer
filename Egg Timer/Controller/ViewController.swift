//

import UIKit

class ViewController: UIViewController {

    //Declares an instance of timerManager.
    var timerManager = TimerManager()

    //Declares outlets from the storyboard for UI manipulation
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //sets timerManager delegate to viewController
        timerManager.delegate = self
        
        //Programatically sets progress bar corner radius and clipping
        //Can also be set on the storyboard attributes.
        //progressView.layer.cornerRadius = 11
        //progressView.clipsToBounds = true
    }
    
    //IBAction for when the user presses the stop button
    @IBAction func stopSelected(_ sender: UIButton) {
        //Sets the title label back to its default text
        titleLabel.text = "How would you like your eggs?"
        //Stops timer
        timerManager.stopTimer()
        //Resets progress bar
        progressView.progress = 0.0
    }
    
    //IBAction for when the user presses the egg hardness buttons
    @IBAction func hardnessSelected(_ sender: UIButton) {
        //Stops timer
        timerManager.stopTimer()
        //Sets title label to the egg hardness selected by the user
        let hardness = sender.titleLabel?.text ?? ""
        titleLabel.text = hardness + " eggs selected"
        
        //Sets total time based on egg hardness selected by the user
        timerManager.setTotalTime(hardness: hardness)

        //Runs the timer
        timerManager.runTimer()
    }
    

}
//MARK: - ProgressUpdateDelegate
//Extending ViewController with the ProgressUpdateDelegate protocol
extension ViewController : ProgressUpdateDelegate {
    func updateProgressBar(value: Float) {
        progressView.progress = value
        
        if progressView.progress == 1 {
            titleLabel.text = "Your eggs are done"
        }
    }
}
