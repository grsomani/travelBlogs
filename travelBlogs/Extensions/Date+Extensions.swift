//
//  Date+Extensions.swift
//  travelBlogs
//
//  Created by Ganesh Somani on 02/07/20.
//  Copyright © 2020 Ganesh Somani. All rights reserved.
//

import Foundation

extension Date {

    func getElapsedTime() -> String {

        let interval = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: self, to: Date())
        var elaspedTime = ""
        if let year = interval.year, year > 0 {
            elaspedTime = year == 1 ? "\(year)" + " " + "year" :
                "\(year)" + " " + "years"
        } else if let month = interval.month, month > 0 {
            elaspedTime = month == 1 ? "\(month)" + " " + "month" :
                "\(month)" + " " + "months"
        } else if let day = interval.day, day > 0 {
            elaspedTime = day == 1 ? "\(day)" + " " + "day" :
                "\(day)" + " " + "days"
        } else if let hour = interval.hour, hour > 0 {
            elaspedTime = hour == 1 ? "\(hour)" + " " + "hr" :
                "\(hour)" + " " + "hr"
        } else if let minute = interval.minute, minute > 0 {
            elaspedTime = minute == 1 ? "\(minute)" + " " + "min" :
                "\(minute)" + " " + "mins"
        } else {
            elaspedTime = "few moments"
        }
        return elaspedTime + " ago"
    }
}
