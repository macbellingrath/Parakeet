//
//  InterfaceController.swift
//  TappyTimer WatchKit Extension
//
//  Created by Mac Bellingrath on 1/6/16.
//  Copyright © 2016 Mac Bellingrath. All rights reserved.
//

import WatchKit
import Foundation




class InterfaceController: WKInterfaceController, HapticPlayable, TimerConfigurable {

    var targetTimer: NSTimer?
    var duration: NSTimeInterval = 20
    
    var timerRunning = false {
       
        didSet {
           
            let text = timerRunning ? "Pause" : "Start"
            
            let color = timerRunning ? UIColor.redColor() : UIColor.greenColor()
            
            let atr = NSAttributedString(string: text, attributes: [                                                NSForegroundColorAttributeName : color, NSFontAttributeName : UIFont.systemFontOfSize(15)])

            startButton?.setAttributedTitle(atr)
        }
    }
    
    @IBOutlet var timer: WKInterfaceTimer!
    @IBOutlet weak var startButton: WKInterfaceButton!
    @IBAction func startButtonPressed() {
        
        if !timerRunning {
        
        timer?.configure(withTimeInterval: duration)
       
        timer.start()
        
        startTargetTimer()
        
        playHaptic(.Start)
        
        } else if timerRunning {
            
            timer.stop()
            
            
        }
        
        timerRunning = !timerRunning
    
    }
    
    func timerDone(sender: NSTimer) {
        timer?.stop()
        resetTimer(sender)
        timerRunning = false
        
    }
    @IBAction func resetButtonPressed() {
       timer.reset()
       timerRunning = false
    }
    
    func startTargetTimer() {
        targetTimer = NSTimer.scheduledTimerWithTimeInterval(duration, target: self, selector: Selector("timerDone:"), userInfo: nil, repeats: false)
    }
    

}

extension WKInterfaceTimer: HapticPlayable {
    
    func configure(withTimeInterval time: NSTimeInterval) {
      
        let futureDate = NSDate(timeIntervalSinceNow: (time + 1.0))
        self.setDate(futureDate)

    }
    
    func reset() {
        self.stop()
        self.setDate(NSDate())
        playHaptic(.Stop)
    }
}


protocol TimerConfigurable {
    
    func resetTimer(timer: NSTimer?)
}

extension TimerConfigurable {
    
   
    func resetTimer(var timer: NSTimer?) {
        timer?.invalidate()
        timer = nil
        
    }
    
}

protocol HapticPlayable {
    func playHaptic(type: WKHapticType)
}

extension HapticPlayable {
    
    func playHaptic(type: WKHapticType) {
    WKInterfaceDevice.currentDevice().playHaptic(type)
    }
    
}