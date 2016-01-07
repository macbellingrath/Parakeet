//
//  Time.swift
//  TappyTimer
//
//  Created by Mac Bellingrath on 1/7/16.
//  Copyright © 2016 Mac Bellingrath. All rights reserved.
//

import Foundation

enum IntervalType {
    case Work(NSTimeInterval)
    case Rest(NSTimeInterval)
    
    func time() -> NSTimeInterval {
        switch self {
        case .Work(let worktime): return worktime
        case .Rest(let restTime): return restTime
        }
    }
}


struct IntervalComposition {
    let rest: IntervalType
    let work: IntervalType
    var segmentTime: NSTimeInterval {
        return rest.time() + work.time()
    }
    
}

struct Session {
    
    var intervals: [IntervalComposition]
    
    init(numIntervals: Int, rest: NSTimeInterval, work: NSTimeInterval) {
        self.numberOfIntervals = numIntervals
        
        var intvls = [IntervalComposition]()
        
        let interval = IntervalComposition(rest: IntervalType.Rest(rest), work: IntervalType.Work(work))
        
        for _ in 1...self.numberOfIntervals {
            intvls.append(interval)
        }
        self.intervals = intvls
    }
    
    var numberOfIntervals: Int
    
    //total
    var sessionTotalTime: NSTimeInterval {
        return intervals.reduce(0.0){$0 + $1.segmentTime}
    }
}
