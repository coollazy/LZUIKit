import Foundation

extension Date {
    public func addYear(_ year: Int) -> Date {
        Calendar.current.date(byAdding:.year, value: year, to: self)!
    }

    public func addMonth(_ month: Int) -> Date {
        Calendar.current.date(byAdding:.month, value: month, to: self)!
    }

    public func addDay(_ day: Int) -> Date {
        Calendar.current.date(byAdding:.day, value: day, to: self)!
    }
    
    public func addHour(_ hour: Int) -> Date {
        Calendar.current.date(byAdding:.hour, value: hour, to: self)!
    }
    
    public func addMinute(_ minute: Int) -> Date {
        Calendar.current.date(byAdding:.minute, value: minute, to: self)!
    }
    
    public func addSecond(_ second: Int) -> Date {
        Calendar.current.date(byAdding:.second, value: second, to: self)!
    }
}

extension Date {
    public func firstMinuteOfHour() -> Date {
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour], from: self)
        dateComponents.minute = 0
        return Calendar.current.date(from: dateComponents)!
    }
    
    public func lastMinuteOfHour() -> Date {
        var dateComponents = DateComponents()
        dateComponents.hour = 1
        dateComponents.second = -1
        return Calendar.current.date(byAdding: dateComponents, to: self.firstMinuteOfHour())!
    }
    
    public func firstHourOfDay(timeZone: TimeZone? = nil) -> Date {
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: self)
        if let timeZone = timeZone {
            dateComponents.timeZone = timeZone
        }
        dateComponents.hour = 0
        return Calendar.current.date(from: dateComponents)!
    }
    
    public func lastHourOfDay(timeZone: TimeZone? = nil) -> Date {
        var dateComponents = DateComponents()
        dateComponents.day = 1
        dateComponents.second = -1
        return Calendar.current.date(byAdding: dateComponents, to: self.firstHourOfDay(timeZone: timeZone))!
    }
    
    public func firstDayOfMonth() -> Date {
        var dateComponents = Calendar.current.dateComponents([.year, .month], from: self)
        dateComponents.day = 1
        return Calendar.current.date(from: dateComponents)!
    }
    
    public func lastDayOfMonth() -> Date {
        var dateComponents = DateComponents()
        dateComponents.month = 1
        dateComponents.second = -1
        return Calendar.current.date(byAdding: dateComponents, to: self.firstDayOfMonth())!
    }
    
    public func firstDayOfYear() -> Date {
        var dateComponents = Calendar.current.dateComponents([.year], from: self)
        dateComponents.month = 1
        dateComponents.day = 1
        return Calendar.current.date(from: dateComponents)!
    }
    
    public func lastDayOfYear() -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = 1
        dateComponents.second = -1
        return Calendar.current.date(byAdding: dateComponents, to: self.firstDayOfYear())!
    }
}
