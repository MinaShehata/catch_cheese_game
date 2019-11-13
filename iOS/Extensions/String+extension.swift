//
//  String+extension.swift
//  IntermediateTraining
//
//  Created by Mina Shehata on 11/1/18.
//  Copyright © 2018 Mina Shehata. All rights reserved.
//

import Foundation

extension String {
    
    var Localize: String {
        return NSLocalizedString(self, comment: "")
    }
    
    func isEnglishPhoneNumber() -> String {
        var newPhone = self
        newPhone = newPhone.replacingOccurrences(of: "١", with: "1")
        newPhone = newPhone.replacingOccurrences(of: "٢", with: "2")
        newPhone = newPhone.replacingOccurrences(of: "٣", with: "3")
        newPhone = newPhone.replacingOccurrences(of: "٤", with: "4")
        newPhone = newPhone.replacingOccurrences(of: "٥", with: "5")
        newPhone = newPhone.replacingOccurrences(of: "٦", with: "6")
        newPhone = newPhone.replacingOccurrences(of: "٧", with: "7")
        newPhone = newPhone.replacingOccurrences(of: "٨", with: "8")
        newPhone = newPhone.replacingOccurrences(of: "٩", with: "9")
        newPhone = newPhone.replacingOccurrences(of: "٠", with: "0")
        return newPhone

    }
    
    func getDateFromString() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC") // cairo time zone.......
        return dateFormatter.date(from: self)
    }
    
}
extension String {
    
    
    var trim: String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func fileName() -> String {
        return NSURL(fileURLWithPath: self).deletingPathExtension?.lastPathComponent ?? ""
    }
    
    func fileExtension() -> String {
        return NSURL(fileURLWithPath: self).pathExtension ?? ""
    }
}
extension Date {
    func convertDateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateString = dateFormatter.string(from: self)
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC") // cairo time zone.......
        return dateString
    }
    
    func getStringFromDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-mm-yyyy"
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    
    
    func getStringFromTime() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC") // cairo time zone.......
        let timeString = dateFormatter.string(from: self)
        return timeString
    }
    
}
