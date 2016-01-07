//
//  InterfaceController.swift
//  TappyTimer WatchKit Extension
//
//  Created by Mac Bellingrath on 1/6/16.
//  Copyright © 2016 Mac Bellingrath. All rights reserved.
//

import WatchKit
import Foundation


struct Time {
    //Rest
    var restTime: NSTimeInterval
    //Work
    var intervalLength: NSTimeInterval
    //Intervals
    var numberOfIntervals: Int
}

class InterfaceController: WKInterfaceController, HapticPlayable {

    var targetTimer: NSTimer?
    var timerManager: AIRTimer?
    var duration: NSTimeInterval = 20
    
    var timerRunning = false {
       
        didSet {
           
            let text = timerRunning ? "Pause" : "Start"
            
            let color = timerRunning ? UIColor.redColor() : UIColor.greenColor()
            
            let atr = NSAttributedString(string: text, attributes: [                                                NSForegroundColorAttributeName : color, NSFontAttributeName : UIFont.systemFontOfSize(15)])

            startButton?.setAttributedTitle(atr)
        }
    }
    
    @IBOutlet var watchTimer: WKInterfaceTimer!
    @IBOutlet weak var startButton: WKInterfaceButton!
    @IBAction func startButtonPressed() {
        
        if !timerRunning {
        
        watchTimer?.configure(withTimeInterval: duration)
       
        watchTimer.start()
        timerManager = AIRTimer.after(<#T##interval: NSTimeInterval##NSTimeInterval#>, handler: <#T##TimerHandler##TimerHandler##(AIRTimer) -> Void#>)
        
        startTargetTimer()
        
        playHaptic(.Start)
        
        } else if timerRunning {
            
            duration = targetTimer?.timeInterval ?? duration
            
            watchTimer.stop()
            
            targetTimer?.invalidate()
 
        }
        
        timerRunning = !timerRunning
    
    }
    
    func timerDone(sender: NSTimer) {
        watchTimer?.stop()
        playHaptic(.DirectionDown)
        sender.invalidate()
        
        timerRunning = false
        
    }
    
    func startTargetTimer() {
        targetTimer = NSTimer.scheduledTimerWithTimeInterval(duration, target: self, selector: Selector("timerDone:"), userInfo: nil, repeats: false)
    }
    
    override func didAppear() {
        super.didAppear()
    

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

protocol HapticPlayable {
    func playHaptic(type: WKHapticType)
}

extension HapticPlayable {
    
    func playHaptic(type: WKHapticType) {
    WKInterfaceDevice.currentDevice().playHaptic(type)
    }
    
}