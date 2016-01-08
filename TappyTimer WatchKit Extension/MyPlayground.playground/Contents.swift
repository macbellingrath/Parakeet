//: Playground - noun: a place where people can play


import Foundation


struct Segment {
    enum Type: String { case Work, Rest }
    var interval: NSTimeInterval
    var type: Type
}

struct Session {
    var intervals: [Segment]
    var totalTime: NSTimeInterval {
        return intervals.reduce(0.0) { $0 + $1.interval }
    }
    
    
    init(rest: NSTimeInterval, work: NSTimeInterval, number: Int) {
        
        self.intervals = []
        
        
        let w = Segment(interval: work, type: .Work)
     
        let r = Segment(interval: rest, type: .Rest)
        
        
        for x in 1...number {
            if rest > 0.0 { self.intervals.append(r) }
            self.intervals.append(w)
        }
    }
    
}

let s = Session(rest: 10, work: 20, number: 8)


