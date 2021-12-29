//
//  ViewController.swift
//  Catch_To_Kenny
//
//  Created by Yagmur Konuksoy on 28.12.2021.
//

import UIKit

class ViewController: UIViewController {
    
    var timer = Timer()
    var counter = 0
    let positionPikachu = UIImageView()
    var catchedCount = 0
    var LastScoreCount = 0
    
    @IBOutlet weak var countDown: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScore: UILabel!
    
    
    let storedScore = UserDefaults.standard.object(forKey: "highscore")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        counter = 10
                
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunction), userInfo: nil, repeats: true)
        
        positionPikachu.image = UIImage(named: "pikachu-png-transparent-0")
        view.addSubview(positionPikachu) // sahneye img eklendi
        
        
        
        if let newScore = storedScore as? Int {
                    print(newScore)
                    highScore.text = "High Score: \(newScore)"
                }
        
    }
    @objc func timerFunction() {
        
        positionPikachu.isUserInteractionEnabled = true // eklenen img'ın tıklanabilir olma izni verildi
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(countCatched))
        positionPikachu.addGestureRecognizer(gestureRecognizer) // eklenen img'ın tıklanabilir olma fonksiyonu eklendi **countCatched**
            
        
        countDown.text = "\(counter)"
        counter -= 1
        //random sayı üretildi
        let randomNumberX = Int.random(in: 0...200)
        let randomNumberY = Int.random(in: 200...518)
        
        positionPikachu.frame = CGRect(x: randomNumberX, y: randomNumberY, width: 200, height: 200) // eklenen img'ın position değerleri değiştirildi
     
        
        if counter == 0 {
            timer.invalidate()
            countDown.text = "Time's Over"
            positionPikachu.isUserInteractionEnabled = false
            
            if let new = storedScore as? Int{
                if new < catchedCount{
                    UserDefaults.standard.set(catchedCount, forKey: "highscore")
                    highScore.text = "High Score: \(catchedCount)"
                }
            }
            
            let alert = UIAlertController(title: "OYUN BİTTİ", message: "Tekrar Oynamak İster misiniz?", preferredStyle: UIAlertController.Style.alert)
            let noButton = UIAlertAction(title: "Hayır", style: UIAlertAction.Style.default, handler: nil)
            let replayButton = UIAlertAction(title: "Yeniden Dene", style: UIAlertAction.Style.default) { [self] UIAlertAction in
                self.counter = 10
                self.catchedCount = 0
                self.scoreLabel.text = "Score: \(String(self.catchedCount))"
                self.countDown.text = String(self.counter)
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunction), userInfo: nil, repeats: true)
            }
           alert.addAction(replayButton)
            alert.addAction(noButton)
           self.present(alert, animated: true, completion: nil)
          
            

        }
        
    }
    
    @objc func countCatched() {
       catchedCount += 1
        print("tıklanıyor")
       scoreLabel.text = "Score: \(catchedCount)"
        
      
    }
    
   

    
}

