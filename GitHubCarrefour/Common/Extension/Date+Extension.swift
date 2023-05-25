import Foundation

enum FormatDate: String {
    case formateBR = "dd-MM-yyyy"
    case formateEN = "yyyy-MM-dd HH:mm:ss"
    case formatePT = "dd MM YYYY, HH:mm:ss"
    case formateGlobal = "yyyy-MM-dd'T'HH:mm:ssZ"
    var id: String {
        return self.rawValue
    }
}

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
