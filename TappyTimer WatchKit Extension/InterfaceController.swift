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
            startButton?.setEnabled(!timerRunning)
        }
    }
    
    @IBOutlet var timer: WKInterfaceTimer!
    @IBOutlet weak var startButton: WKInterfaceButton!
    @IBAction func startButtonPressed() {
        
        timer?.configure(withTimeInterval: duration)
        targetTimer = NSTimer.scheduledTimerWithTimeInterval(duration, target: self, selector: Selector("timerDone:"), userInfo: nil, repeats: false)
      
        timer.start()
        playHaptic(.Start)
        timerRunning = true
    
        
    }
    
    func timerDone(sender: NSTimer) {
        timer?.stop()
        resetTimer(sender)
        timerRunning = false
        
    }
    @IBAction func resetButtonPressed() {
        timer?.stop()
        playHaptic(.Stop)
    }
    
   
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        

    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}

extension WKInterfaceTimer {
    func configure(withTimeInterval time: NSTimeInterval) {
        let futureDate = NSDate(timeIntervalSinceNow: time)
        self.setDate(futureDate)

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