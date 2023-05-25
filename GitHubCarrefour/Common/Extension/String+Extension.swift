import Foundation

extension String {
    func convertDateFormat(oldFormat: String, newFormat: String) -> String {
        
        let oldDateFormatter = DateFormatter()
        oldDateFormatter.dateFormat = oldFormat
        oldDateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        let oldDate = oldDateFormatter.date(from: self) ??  Date()
        
        
        let convertDateFormatter = DateFormatter()
        convertDateFormatter.locale = Locale(identifier: "en_US_POSIX")
        convertDateFormatter.dateFormat = newFormat
        
        let finalDate = convertDateFormatter.string(from: oldDate)
        
        return finalDate
    }
}
