//
//  ViewController.swift
//  memory
//
//  Created by Ahmed Abodeif on 4/15/17.
//  Copyright © 2017 Ahmed Abodeif. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {
    
    var firstClick = true
    var previousTag = -1;
    var previousButton :UIButton!
    @IBOutlet var buttons: [UIButton]!
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        print("The button tag is \(sender.tag)" )
        if(firstClick)
        {
            previousButton = sender
            previousTag = sender.tag
            firstClick = false
            sender.setBackgroundImage(UIImage(named: String(sender.tag)), for: UIControlState.normal)
        }
        else {
            if(sender.tag == previousButton.tag && !sender.isEqual(previousButton)){
                print("Similar images clicked")
                sender.setBackgroundImage(UIImage(named: String(sender.tag)), for: UIControlState.normal)
                UIView.animate(withDuration: 1.0,
                                           delay: 0,
                                           options: UIViewAnimationOptions.curveLinear,
                                           animations: {
                                            self.previousButton.alpha = 0
                                            sender.alpha = 0
                }, completion: nil)
                sender.tag = -1
                previousButton.tag = -1
            }
            else{
                sender.setBackgroundImage(UIImage(named: String(sender.tag)), for: UIControlState.normal)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    print("executing delayed func")
                    self.putCovers()
                })

            }
            previousButton = nil
            firstClick = true
        }
    }
    
    @IBAction func resetGame(_ sender: Any) {
        
    }
    
    func putCovers() {
        for button in buttons{
            if(button.tag != -1){
              button.setBackgroundImage(UIImage(named: "c"), for: UIControlState.normal)
                button.alpha = 1
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("looping over button")
        
        buttons = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: buttons) as! [UIButton]
        var i = 0
        var even  = false
        for button in buttons{
            button.tag = i;
            button.setTitle("", for: UIControlState.normal)
            button.setBackgroundImage(UIImage(named: String(i)), for: UIControlState.normal)
            
            
            UIView.animate(withDuration: 5.0, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: {
                button.alpha = 0
            }, completion:nil)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                print("executing delayed func")
                self.putCovers()
            })

            print("assigning button tag \(i)")
            if(even){
                i = i + 1
                even = false
            }
            else {
                even = true
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

