//: Playground - noun: a place where people can play

import UIKit


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

struct Time {
    
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




let interval = (rest: IntervalType.Rest(10), work: IntervalType.Work(20))

let t = Time(numIntervals: 8, rest: 10, work: 20)
t.intervals.count
t.sessionTotalTime




