//
//  String+Date.swift
//  TVShows
//
//  Created by Lucas Fernandez Nicolau on 08/01/22.
//

import Foundation

public extension String {
  func asDate(format: String = "yyyy-MM-dd", style: DateFormatter.Style = .short) -> String {
    let formatter = DateFormatter()
    formatter.locale = Locale.current
    formatter.dateStyle = style
    formatter.dateFormat = format
    guard let date = formatter.date(from: self) else {
      return .init()
    }
    return DateFormatter.localizedString(from: date, dateStyle: style, timeStyle: .none)
  }
}
