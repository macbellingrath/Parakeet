//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

protocol TimerDelegate {
    func didReachTargetTime(timer: NSTimer)
}

class TimeObj: TimerDelegate {
    func didReachTargetTime(timer: NSTimer) {
        print("reached target time")
    }
}

let clock = TimeObj()

var timer = NSTimer.scheduledTimerWithTimeInterval(20, target: clock , selector: "didReachTargetTime:", userInfo: nil, repeats: false)