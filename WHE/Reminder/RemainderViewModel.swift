//
//  RemainderViewModel.swift
//  WHE
//
//  Created by Nagarjunareddy Yeruvu on 11/04/23.
//

import UIKit

class RemainderViewModel: NSObject {
    let remainderArrStr =  "remainderArr"
    let remainderStr = "You currently have reminders set for "
    var remainderArr: [String] = []

    func getRemainderTime(){
        
        remainderArr =  UserDefaults.standard.object(forKey: remainderArrStr) as? [String] ?? []
        
    }
    
    func updateRemainderTime(remainderArr:[String]){
        
        UserDefaults.standard.set(remainderArr, forKey: remainderArrStr)
        
    }
    
    func addRemaiderTime(timeStr:String) -> Bool {
        var checkingTime = false
        if  remainderArr.count == 9 {
            checkingTime = true
        }else {
            checkingTime = compareTime(timeStr: timeStr)
            
            if !checkingTime {
                if remainderArr.contains(timeStr) {
                    checkingTime = true
                    
                }else{
                    checkingTime = false
                }
            }
        }
        return checkingTime
    }
    
    func compareTime(timeStr: String) -> Bool{
        var compareTime:Bool = false
        let todaysDate = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        var DateInFormat:String = dateFormatter.string(from: todaysDate as Date)
        print(DateInFormat)
        DateInFormat = DateInFormat + " " + timeStr
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "dd-MM-yyyy hh:mm a"
        let date = dateFormatter1.date(from:DateInFormat)
        let eight_today = calendar.date(
            bySettingHour: 09,
            minute: 0,
            second: 0,
            of: date!)!
        
        let four_thirty_today = calendar.date(
            bySettingHour: 17,
            minute: 00,
            second: 0,
            of: date!)!
        if date! >= eight_today &&
            date! <= four_thirty_today
        {
            compareTime = false
        }else{
            compareTime = true
            
        }
        return compareTime
    }
}
