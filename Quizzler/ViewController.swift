import UIKit

class ViewController: UIViewController {
    
    let allQuestions = QuestionBank()
    var pickedAnswer: Bool = false
    var questionNumber: Int = 0
    var score: Int = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    @IBOutlet var falseButton: UIButton!
    @IBOutlet var trueButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // make soft corners for button
        falseButton.layer.cornerRadius = 5.0
        trueButton.layer.cornerRadius = 5.0
        
        // display the first question
        nextQuestion()
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        // store the answer of user
        if sender.tag == 1{
            pickedAnswer = true
        }
        else{
            pickedAnswer = false
        }
        
        // check the answer of user
        checkAnswer()
        
        // move on to the next question
        questionNumber += 1
        nextQuestion()
    }
    
    
    func updateUI() {
        scoreLabel.text = "Score: \(score)"
        progressLabel.text = "\(questionNumber + 1) / 13"
        
        // update the progress bar
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(questionNumber + 1)
    }
    

    func nextQuestion() {
        let questionCount = allQuestions.list.count
        
        if questionNumber < questionCount{
            questionLabel.text = allQuestions.list[questionNumber].questionText
            
            // update the score and progress bar
            updateUI()
        }
        else{
            // end of the game
            let alert = UIAlertController(title: "End of questions", message: "You finished all the questions, do you want to start over?", preferredStyle: .alert)
            
            let restartAction = UIAlertAction(title: "Restart", style: .default) { (UIAlertAction) in
                self.startOver()
            }
            
            // display the alert
            alert.addAction(restartAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    func checkAnswer() {
        // get the correct answer of the question
        let correctAnswer = allQuestions.list[questionNumber].answer
        
        if correctAnswer == pickedAnswer{
            score += 1
            ProgressHUD.showSuccess("Correct!")
        }
        else{
            ProgressHUD.showError("Wrong!")
        }
    }
    
    
    func startOver() {
        // reset all var
        questionNumber = 0
        nextQuestion()
        score = 0
        pickedAnswer = false
    }
}
