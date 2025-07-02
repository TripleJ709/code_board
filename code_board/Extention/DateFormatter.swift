//
//  DateFormatter.swift
//  code_board
//
//  Created by 장주진 on 7/2/25.
//

import Foundation

extension DateFormatter {
    static func convert(_ dateString: String, from inputFormat: String, to outputFormat: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = inputFormat
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        inputFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = outputFormat
        outputFormatter.locale = Locale(identifier: "ko_KR")
        outputFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        if let date = inputFormatter.date(from: dateString) {
            return outputFormatter.string(from: date)
        } else {
            print("날짜 파싱 실패: \(dateString)")
            return dateString
        }
    }
}
