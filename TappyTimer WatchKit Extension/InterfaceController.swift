//
//  InterfaceController.swift
//  TappyTimer WatchKit Extension
//
//  Created by Mac Bellingrath on 1/6/16.
//  Copyright © 2016 Mac Bellingrath. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController, HapticPlayable {

    var targetTimer: NSTimer?
    var currentSegment: Segment? {
        didSet {
            let repsLeft = String(s.intervals.filter { $0.type == .Work }.count)
            intervalTypeLabel.setText(currentSegment?.type.rawValue)
            numberOfIntervalsLabel.setText(repsLeft)
        }
    }
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
    @IBOutlet var numberOfIntervalsLabel: WKInterfaceLabel!
    @IBOutlet var intervalTypeLabel: WKInterfaceLabel!
    @IBAction func startButtonPressed() {
        
        guard let seg = currentSegment else { return }
        
        if !timerRunning {
        
        watchTimer?.configure(withTimeInterval: seg.interval)
       
        watchTimer.start()
        
        startTargetTimer()
        
        playHaptic(.Start)
        
        } else if timerRunning {
        
            
            watchTimer.stop()
            
            targetTimer?.invalidate()
 
        }
        
        timerRunning = !timerRunning
    
    }
    
    func timerDone(sender: NSTimer) {
        watchTimer?.stop()
        playHaptic(.DirectionDown)
        sender.invalidate()

        guard !s.intervals.isEmpty else {timerRunning = false; return }
        s.intervals.removeFirst()
        currentSegment = s.intervals.first
        watchTimer.configure(withTimeInterval: currentSegment?.interval ?? 0)
        startTargetTimer()
        watchTimer.start()
        
        
       
        
    }
    
    func startTargetTimer() {
        guard let seg = currentSegment else { return }
        targetTimer = NSTimer.scheduledTimerWithTimeInterval(seg.interval, target: self, selector: Selector("timerDone:"), userInfo: nil, repeats: false)
    }
    
 
    var s = Session(rest: 10, work: 20, number: 8)
    
    
    override func didAppear() {
        super.didAppear()
    
        currentSegment = s.intervals.first
        
        let reps = String(s.intervals.filter { $0.type == .Work }.count)
        
        numberOfIntervalsLabel.setText(reps)
        
        if let seg = currentSegment {
        watchTimer.configure(withTimeInterval: seg.interval)
        switch seg.type {
            case .Rest: intervalTypeLabel.setText(seg.type.rawValue)
            case .Work: intervalTypeLabel.setText(seg.type.rawValue)
            
            }
        }
    
    }
}

extension WKInterfaceTimer: HapticPlayable {
    
    func configure(withTimeInterval time: NSTimeInterval) {
      
        let futureDate = NSDate(timeIntervalSinceNow: (time) + 1.0)
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