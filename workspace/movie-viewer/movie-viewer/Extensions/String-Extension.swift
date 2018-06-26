//
//  String-Extension.swift
//  movie-viewer
//
//  Created by Dreb Rodriguez on 16/06/2018.
//  Copyright © 2018 Dreb Rodriguez. All rights reserved.
//

import UIKit

extension String {
    func formattedDate() -> String {
        
        let dateFormatter = DateFormatter()
        
        let dateFormat = "yyyy-MM-dd"
        dateFormatter.dateFormat = dateFormat
        
        let date = dateFormatter.date(from: self)
        
        let identifier = "en_US"
        dateFormatter.locale = Locale(identifier: identifier)
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        guard let unwrappedDate = date else {
            return String()
        }
        
        return dateFormatter.string(from: unwrappedDate)
    }
    
    func formattedTime() -> String {
        guard let intervalInMin = Double(self) else { return String() }
        let intervalInSec = intervalInMin * 60
        
        let dateComponentsFormatter = DateComponentsFormatter()
        dateComponentsFormatter.allowedUnits = [.hour, .minute]
        dateComponentsFormatter.unitsStyle = .brief
        
        guard let result = dateComponentsFormatter.string(from: TimeInterval(intervalInSec)) else {
            return String()
        }
        return result
    }
}
