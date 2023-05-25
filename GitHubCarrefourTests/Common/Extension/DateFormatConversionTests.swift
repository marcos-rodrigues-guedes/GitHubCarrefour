import Foundation
import XCTest

@testable import GitHubCarrefour

class DateFormatConversionTests: XCTestCase {
    
    func testConvertDateFormat_Success() {
        let dateString = "2007-10-20T05:24:19Z"
        let oldFormat = FormatDate.formateGlobal.id
        let newFormat = FormatDate.formateBR.id
        
        let convertedDate = dateString.convertDateFormat(oldFormat: oldFormat, newFormat: newFormat)
        
        XCTAssertEqual(convertedDate, "20-10-2007")
    }
    

    func testConvertDateFormat_EmptyString() {
        let dateString = ""
        let oldFormat = "yyyy-MM-dd"
        let newFormat = "dd-MM-yyyy"
        
        let convertedDate = dateString.convertDateFormat(oldFormat: oldFormat, newFormat: newFormat)
        
        XCTAssertEqual(convertedDate, Date().getFormattedDate(format: FormatDate.formateBR.id))
    }
    
    func testConvertDateFormat_InvalidFormat() {
        let dateString = "2023-05-21"
        let oldFormat = "yyyy-MMM-dd"
        let newFormat = "dd-MM-yyyy"
        
        let convertedDate = dateString.convertDateFormat(oldFormat: oldFormat, newFormat: newFormat)
        
        XCTAssertEqual(convertedDate, Date().getFormattedDate(format: FormatDate.formateBR.id))
    }
}

