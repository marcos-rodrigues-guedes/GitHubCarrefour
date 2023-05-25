import Foundation
import XCTest

@testable import GitHubCarrefour

class DateFormattingTests: XCTestCase {
    
   
    func testGetFormattedDate_FormateBR() {
        let date = Date()
        let formattedDate = date.getFormattedDate(format: FormatDate.formateBR.rawValue)
        
        let formatter = DateFormatter()
        formatter.dateFormat = FormatDate.formateBR.rawValue
        let expectedDate = formatter.string(from: date)
        
        XCTAssertEqual(formattedDate, expectedDate)
    }
    
    func testGetFormattedDate_FormateEN() {
        let date = Date()
        let formattedDate = date.getFormattedDate(format: FormatDate.formateEN.rawValue)
        
        let formatter = DateFormatter()
        formatter.dateFormat = FormatDate.formateEN.rawValue
        let expectedDate = formatter.string(from: date)
        
        XCTAssertEqual(formattedDate, expectedDate)
    }
    
    func testGetFormattedDate_FormatePT() {
        let date = Date()
        let formattedDate = date.getFormattedDate(format: FormatDate.formatePT.rawValue)
        
        let formatter = DateFormatter()
        formatter.dateFormat = FormatDate.formatePT.rawValue
        let expectedDate = formatter.string(from: date)
        
        XCTAssertEqual(formattedDate, expectedDate)
    }
    
    func testGetFormattedDate_FormateGlobal() {
        let date = Date()
        let formattedDate = date.getFormattedDate(format: FormatDate.formateGlobal.rawValue)
        
        let formatter = DateFormatter()
        formatter.dateFormat = FormatDate.formateGlobal.rawValue
        let expectedDate = formatter.string(from: date)
        
        XCTAssertEqual(formattedDate, expectedDate)
    }
}
