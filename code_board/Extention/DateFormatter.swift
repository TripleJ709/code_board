//
//  DateFormatter.swift
//  code_board
//
//  Created by 장주진 on 7/2/25.
//

import Foundation

extension DateFormatter {
    static func convert(_ dateString: String, from inputFormat: String, to outputFormat: String) -> String {
        
        print(dateString)
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = inputFormat
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        inputFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = outputFormat
        print(outputFormatter.string(from: inputFormatter.date(from: dateString)!))
        outputFormatter.locale = Locale(identifier: "ko_KR")
        print(outputFormatter.string(from: inputFormatter.date(from: dateString)!))
        outputFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        print(outputFormatter.string(from: inputFormatter.date(from: dateString)!))
        
        if let date = inputFormatter.date(from: dateString) {
            return outputFormatter.string(from: date)
        } else {
            print("날짜 파싱 실패: \(dateString)")
            return dateString
        }
    }
}
