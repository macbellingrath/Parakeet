//
//  Session.swift
//  TappyTimer
//
//  Created by Mac Bellingrath on 1/8/16.
//  Copyright © 2016 Mac Bellingrath. All rights reserved.
//

import Foundation

struct Segment {
    enum Type: String { case Work, Rest }
    var interval: NSTimeInterval
    var type: Type
    var completed: Bool
}

struct Session {
    var intervals: [Segment]
    var totalTime: NSTimeInterval {
        return intervals.reduce(0.0) { $0 + $1.interval }
    }
    
    
    init(rest: NSTimeInterval, work: NSTimeInterval, number: Int) {
        
        self.intervals = []
        
        
        let w = Segment(interval: work, type: .Work, completed: false)
        
        let r = Segment(interval: rest, type: .Rest, completed: false )
        
        
        for _ in 1...number {
            if rest > 0.0 { self.intervals.append(r) }
            self.intervals.append(w)
        }
    }
    
}



