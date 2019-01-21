import UIKit

class ViewController: UIViewController {
    
    let allQuestions = QuestionBank()
    var pickedAnswer: Bool = false
    var questionNumber: Int = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // display the first question
        let firstQuestion = allQuestions.list[questionNumber]
        questionLabel.text = firstQuestion.questionText
        questionNumber += 1
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
        
    }
    

    func nextQuestion() {
        let questionCount = allQuestions.list.count
        
        if questionNumber < questionCount{
            questionLabel.text = allQuestions.list[questionNumber].questionText
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
            print("You got it")
        }
        else{
            print("Wrong")
        }
    }
    
    
    func startOver() {
        questionNumber = 0
        nextQuestion()
    }
}
