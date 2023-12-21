//
//  DateFormatterExtension.swift
//  MyMangas
//
//  Created by Carlos Lucas Sánchez on 19/12/23.
//

import Foundation

extension DateFormatter {
    static let dateFormatCustom = {
        let date = DateFormatter()
        date.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        return date
    }()
}
