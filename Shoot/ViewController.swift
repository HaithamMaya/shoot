//
//  ViewController.swift
//  Shoot
//
//  Created by Haitham Maaieh on 7/29/15.
//  Copyright (c) 2015 haithammaaieh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var rockButton = UIButton()
    var paperButton = UIButton()
    var scissorsButton = UIButton()
    var gameDisplayLabel = UILabel()
    var numPlayed = [0, 0, 0]
    var playerWin = [0, 0 ,0]
    var playerTie = [0, 0, 0]
    var playerLose = [0, 0, 0]
    var playerLog:[Int] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //format and content
        rockButton.backgroundColor = UIColor.grayColor()
        rockButton.setTitle("Rock", forState: .Normal)
        rockButton.addTarget(self, action: "playGame:", forControlEvents: UIControlEvents.TouchUpInside)
        rockButton.addTarget(self, action: "highlight:", forControlEvents: UIControlEvents.TouchDown)
        rockButton.addTarget(self, action: "unhighlight:", forControlEvents: UIControlEvents.TouchUpOutside)
        paperButton.backgroundColor = UIColor.grayColor()
        paperButton.setTitle("Paper", forState: .Normal)
        paperButton.addTarget(self, action: "playGame:", forControlEvents: UIControlEvents.TouchUpInside)
        paperButton.addTarget(self, action: "highlight:", forControlEvents: UIControlEvents.TouchDown)
        paperButton.addTarget(self, action: "unhighlight:", forControlEvents: UIControlEvents.TouchUpOutside)
        scissorsButton.backgroundColor = UIColor.grayColor()
        scissorsButton.setTitle("Scissors", forState: .Normal)
        scissorsButton.addTarget(self, action: "playGame:", forControlEvents: UIControlEvents.TouchUpInside)
        scissorsButton.addTarget(self, action: "highlight:", forControlEvents: UIControlEvents.TouchDown)
        scissorsButton.addTarget(self, action: "unhighlight:", forControlEvents: UIControlEvents.TouchUpOutside)
        gameDisplayLabel.text = "Shoot"
        gameDisplayLabel.numberOfLines = 0
        gameDisplayLabel.textAlignment = .Center
        gameDisplayLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        //layout
        gameDisplayLabel.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 100)
        gameDisplayLabel.center = CGPoint(x: view.bounds.midX, y: view.bounds.minY + gameDisplayLabel.bounds.height/2 + 100)
        rockButton.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        rockButton.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        paperButton.frame = rockButton.frame
        paperButton.center = CGPoint(x: rockButton.center.x, y: rockButton.center.y + rockButton.bounds.height/2 + paperButton.bounds.height/2 + 30)
        scissorsButton.frame = paperButton.frame
        scissorsButton.center = CGPoint(x: paperButton.center.x, y: paperButton.center.y + paperButton.bounds.height/2 + scissorsButton.bounds.height/2 + 30)
        
        
        //add subviews
        view.addSubview(gameDisplayLabel)
        view.addSubview(rockButton)
        view.addSubview(paperButton)
        view.addSubview(scissorsButton)
    }
    
    func playGame(sender: UIButton) {
        unhighlight(sender)
        var played:Int = 99
        if sender == self.rockButton {
            playerLog.append(0)
            numPlayed[0]++
            played = 0
        } else if sender == self.paperButton {
            playerLog.append(1)
            numPlayed[1]++
            played = 1
        } else if sender == self.scissorsButton {
            playerLog.append(2)
            numPlayed[2]++
            played = 2
        }
        
        let computer = anticipate()
        let result = determine(played, computer: computer)
        
        switch result {
        case 0:
            playerTie[played]++
            gameDisplayLabel.text = "\(playedToString(played)) ties \(playedToString(computer))"
        case 1:
            playerWin[played]++
            gameDisplayLabel.text = "\(playedToString(played)) beats \(playedToString(computer))"
        case -1:
            playerLose[played]++
            gameDisplayLabel.text = "\(playedToString(computer)) loses to \(playedToString(played))"
        default:
            gameDisplayLabel.text = "Something wrong."
        }
        var string = gameDisplayLabel.text!
        string += "\n You won \(sum(playerWin)) times out of \(sum(numPlayed))"
        gameDisplayLabel.text = string
    }
    
    func sum(array: [Int]) -> Int {
        var sum: Int = 0
        for i in 0...array.count-1 {
            sum += array[i]
        }
        return sum
    }
    
    func playedToString(played:Int) -> String {
        switch played {
        case 0:
            return "Rock"
        case 1:
            return "Paper"
        case 2:
            return "Scissors"
        default:
            println("error")
        }
        return "error"
    }
    
    func determine(played: Int, computer: Int) -> Int {
        switch played {
        case 0:
            switch computer {
            case 0:
                return 0
            case 1:
                return -1
            case 2:
                return 1
            default:
                println("determine failed")
            }
        case 1:
            switch computer {
            case 0:
                return 1
            case 1:
                return 0
            case 2:
                return -1
            default:
                println("determine failed")
            }
        case 2:
            switch computer {
            case 0:
                return -1
            case 1:
                return 1
            case 2:
                return 0
            default:
                println("determine failed")
        }
        default:
            println("determine failed")
        }
        
        return 99
    }
    
    func anticipate() -> Int {
        return randomInt(0, max: 2)
    }
    
    func randomInt(min: Int, max:Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
    
    func isLastTwoMatch() -> Bool {
        if(playerLog[playerLog.count - 1] == playerLog[playerLog.count - 2]) {
            return true
        } else {
            return false
        }
    }
    
    func isLastThreeMatch() -> Bool {
        if (playerLog[playerLog.count - 1] == playerLog[playerLog.count - 2] && playerLog[playerLog.count - 2] == playerLog[playerLog.count - 3]) {
            return true
        } else {
            return false
        }
    }
    
    func highlight(sender: UIButton) {
        sender.backgroundColor = UIColor.whiteColor()
    }
    func unhighlight(sender: UIButton) {
        sender.backgroundColor = UIColor.grayColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

