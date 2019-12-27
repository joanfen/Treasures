//
//  DateTimeUtil.swift
//
//  Created by suqi on 16/10/13.
//  Copyright © 2016年 FLIP. All rights reserved.
//

import Foundation

public class DateTimeUtil{
    
    class public func dateFromTimeStamp(timeStampVal:Double)->Date{
        let timeStamp:TimeInterval = timeStampVal
        return Date(timeIntervalSince1970: timeStamp)
    }
    class public func formatFromTimeStamp(timeStampVal:Double)->String{
        let timeStamp:TimeInterval = timeStampVal
        return format(time: Date(timeIntervalSince1970: timeStamp))
    }
    class public func formatISODate(time:Date?)->String{
        if time == nil{
            return ""
        }
        let text:String = time!.description
        let day = (text as NSString).substring(to: 10)
        let time = (text as NSString).substring(with: NSMakeRange(11, 8))
        return "\(day)T\(time)Z"
    }
    class public func format(time:Date?)->String{
        return format(time: time, formatText: nil)
    }
    class public func format(time:Date?, formatText:String?)->String{
        if time == nil{
            return ""
        }
        let formatter = DateFormatter()
        if formatText == nil{
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        }else{
            formatter.dateFormat = formatText
        }
        return formatter.string(from: time!)
    }
    class public func parse(text:String, format:String?)->Date?{
        var formatText:String
        if format == nil{
            formatText = "yyyy-MM-dd HH:mm:ss"
        }else{
            formatText = format!
        }
        let formatter = DateFormatter()
        formatter.dateFormat = formatText
        return formatter.date(from: text)
    }
    //搜索时间
    class public func searchTime(time:Date?) -> String{
        if time == nil{
            return ""
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        var text = formatter.string(from: time!)
        text = "\(text) 00:00:00"
        return text
    }
    //制作自然开始时间
    class private func makeNatureStartTime(time:Date, formatter:DateFormatter?=nil) -> String{
        let actualFormatter:DateFormatter = formatter == nil ? DateFormatter() : formatter!
        actualFormatter.dateFormat = "yyyy-MM-dd"
        return "\(actualFormatter.string(from: time)) 00:00:00"
    }
    //返回当天起始时间字符串
    class public func startTimeStr(time: Date?) -> String{
        if time == nil{
            return ""
        }
        return makeNatureStartTime(time: time!)
    }
    //返回当天起始时间
    class public func startTime(time: Date?) -> Date?{
        if time == nil{
            return time
        }
        let formatter:DateFormatter = DateFormatter()
        let text:String = makeNatureStartTime(time: time!, formatter: formatter)
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.date(from: text)
    }
    //制作自然结束时间
    class private func makeNatureEndTime(time: Date, formatter:DateFormatter?=nil) -> String{
        let actualFormatter:DateFormatter = formatter == nil ? DateFormatter() : formatter!
        actualFormatter.dateFormat = "yyyy-MM-dd"
        return "\(actualFormatter.string(from: time)) 23:59:59"
    }
    //返回当天结束时间字符串
    class public func endTimeStr(time: Date?) -> String{
        if time == nil {
            return ""
        }
        return makeNatureEndTime(time: time!)
    }
    //返回当天结束时间
    class public func endTime(time:Date?) -> Date?{
        if time == nil{
            return time
        }
        let formatter = DateFormatter()
        let text:String = makeNatureEndTime(time: time!, formatter: formatter)
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.date(from: text)
    }
    class public func isToday(time:Date?) -> Bool {
        if time == nil {
            return false
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let timeStr = formatter.string(from: time!)
        let todayStr = formatter.string(from: Date())
        if timeStr == todayStr {
            return true
        }
        return false
    }
    //返回与当前时间相隔天数
    class public func dayDistance(time: Date?) -> Int {
        if time == nil {
            return 0
        }
        let interval = time!.timeIntervalSinceNow
        return Int(interval/60/60/24 + 0.5)
    }
    
    class public func diffDays(start:Date?, end:Date?) -> Int{
        if start == nil || end == nil{
            return 0
        }
        let comps: Set<Calendar.Component> = [.day]
        
        let components = Calendar.current.dateComponents(comps, from: start!, to: end!)
        return components.day ?? 0
    }
    class public func diffSeconds(start:Date?, end:Date?) -> Double{
        if start == nil || end == nil{
            return 0
        }
        let comps: Set<Calendar.Component> = [.second]
        let components = Calendar.current.dateComponents(comps, from: start!, to: end!)
        return Double(components.second ?? 0)
    }
    class public func nowInMyZone()->Date{
        let zone = NSTimeZone.system
        let time = Date()
        return time.addingTimeInterval(TimeInterval(zone.secondsFromGMT(for: time)))
    }
    //本周第一天
    class public func startWeekDay(time:Date) -> Date{
        let weekDay:Int = Calendar.current.component(.weekday, from: time)
        let diffDay:Int = weekDay == 1 ? -6 : 2 - weekDay
        if diffDay == 0{
            return time
        }
        return DateTimeUtil.addDays(time: time, offset: diffDay)!
    }
    //本月第一天
    class public func startMonthDay(time:Date) -> Date{
        let day:Int = Calendar.current.component(.day, from: time as Date)
        let diffDay:Int = 1 - day
        if diffDay == 0{
            return time
        }
        return DateTimeUtil.addDays(time: time, offset: diffDay)!
    }
    //当月最后一天
    class public func endMonthDay(time:Date) -> Date {
        var firstDate:Date = Date()
        
        var interval:Double = 0
        let ok = Calendar.current.dateInterval(of: .month, start: &firstDate, interval: &interval, for: time)
        if ok {
            return firstDate.addingTimeInterval(interval-1)
        }
        return time
        
    }
    //获取星期(周日为1)
    class public func getWeekday(date: Date) -> Int {
        let comps: Set<Calendar.Component> = [.weekday]
        let components = Calendar.current.dateComponents(comps, from: date)
        return components.weekday ?? 0
    }
    
    class public func isLaterDate(time: Date) ->Bool {
        if (time.compare(Date())) == ComparisonResult.orderedDescending{
            return true
        }
        return false
    }
    
    class public func addSeconds(time:Date?, offset: Int)->Date?{
        return addIntevals(time: time, component: .second, offset: offset)
    }
    class public func addMinutes(time:Date?, offset: Int)->Date?{
        return addIntevals(time: time, component: .minute, offset: offset)
    }
    class public func addHours(time:Date?, offset: Int)->Date?{
        return addIntevals(time: time, component: .hour, offset: offset)
    }
    class public func addDays(time:Date?, offset: Int)->Date?{
        return addIntevals(time: time, component: .day, offset: offset)
    }
    class public func addMonths(time:Date?, offset: Int)->Date?{
        return addIntevals(time: time, component: .month, offset: offset)
    }
    class public func addYears(time:Date?, offset: Int)->Date?{
        return addIntevals(time: time, component: .year, offset: offset)
    }
    class private func addIntevals(time:Date?, component:Calendar.Component, offset: Int)->Date?{
        if time == nil || offset == 0{
            return time
        }
        return Calendar.current.date(byAdding: component, value: offset, to: time!)
    }
    //判断当前时间是否处于每个时间段内
    class public func validateWidthStartTime(startTime:String,expireTime:String,format:String = "yyyy-MM-dd HH:mm:ss") ->Bool{
        guard let startDate = DateTimeUtil.parse(text: startTime, format: format) else { return false }
        guard var expireDate = DateTimeUtil.parse(text: expireTime, format: format) else { return false }
        let nowString = DateTimeUtil.format(time: Date(), formatText: format)
        guard let nowDate = DateTimeUtil.parse(text: nowString, format: format)  else { return false }
        if startDate.compare(expireDate) == ComparisonResult.orderedDescending {
            expireDate = expireDate.addingTimeInterval(60*60*24)
        }
        if nowDate.compare(startDate) == ComparisonResult.orderedDescending && nowDate.compare(expireDate) == ComparisonResult.orderedAscending {
            return true
        }
        return false
    }
    
    //计算传入时间与当前时间的间隔
    class public func calculateIntervalTime(dateString:String) ->Int {
        guard let date = DateTimeUtil.parse(text: dateString, format: "yyyy-MM-dd HH:mm:ss") else {return 0}
        let dateInterval = date.timeIntervalSince1970
        let nowDateInterval = Date().timeIntervalSince1970
        return Int(nowDateInterval - dateInterval)
    }
    
    //传入时间戳转为日期格式
    class public func timeStampToformat(timeStamp:Int) ->String {
        let timeInterval = TimeInterval.init(timeStamp/1000)
        let date = Date.init(timeIntervalSince1970: timeInterval)
        return DateTimeUtil.format(time: date)
    }
    
    class public func takeOutDeliverTime(dateString: String) ->String {
        guard let date = DateTimeUtil.parse(text: dateString, format: nil) else { return ""}
        let calendar = Calendar.current
        let deliverCmps = calendar.dateComponents([.day,.month,.year], from: date)
        let nowCmps = calendar.dateComponents([.day,.month,.year], from: Date())
        if deliverCmps.year == nowCmps.year && deliverCmps.month == nowCmps.month && deliverCmps.day == nowCmps.day {
            return "今日" + DateTimeUtil.format(time: date, formatText: "HH:mm") + "送餐"
        }
        return DateTimeUtil.format(time: date, formatText: "MM-dd HH:mm") + "送餐"
    }
    
    class public func divideDateString(dateString:String) -> (String,String) {
        var dateInfo = (date: "今天",time: "上午7:00")
        guard let date = DateTimeUtil.parse(text: dateString, format: nil) else {
            return dateInfo
        }
        if DateTimeUtil.isToday(time: date) {
            dateInfo.date = "今天 " + DateTimeUtil.format(time: date, formatText: "yyyy年MM月dd日")
        }
        else {
            dateInfo.date = DateTimeUtil.format(time: date, formatText: "yyyy年MM月dd日")
        }
        let format = DateFormatter.init()
        format.amSymbol = "上午"
        format.pmSymbol = "下午"
        format.dateFormat = "aaahh:mm"
        dateInfo.time = format.string(from: date)
        return dateInfo
    }        
    
    class public func diffRoundDay(start:Date?, end:Date?) -> Int {
        if start == nil || end == nil{
            return 0
        }
        let dateInterval = end!.timeIntervalSince1970
        let nowDateInterval = start!.timeIntervalSince1970
        let times = dateInterval-nowDateInterval
        return Int(round(times/(60*60*24)))
    }
    
    class public func diffCeilDay(start:Date?, end:Date?) -> Int {
        if start == nil || end == nil{
            return 0
        }
        let dateInterval = end!.timeIntervalSince1970
        let nowDateInterval = start!.timeIntervalSince1970
        let times = dateInterval-nowDateInterval
        return Int(ceil(times/(60*60*24)))
    }
}
