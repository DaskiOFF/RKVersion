    import XCTest
    import RKVersion

    final class RKVersionTests: XCTestCase {
        func testInitVersionWithDefaultSeparator() {
            typealias TestVersion = (major: Int, minor: Int, patch: Int)
            
            func equal(version: Version, testVersion: TestVersion) {
                let message = "\(version) != \(testVersion)"
                XCTAssertEqual(version.major, testVersion.major, message)
                XCTAssertEqual(version.minor, testVersion.minor, message)
                XCTAssertEqual(version.patch, testVersion.patch, message)
            }
            
            equal(version: .zero, testVersion: (0, 0, 0))
            equal(version: try! Version(raw: "1"), testVersion: (1, 0, 0))
            equal(version: try! Version(raw: "1.1"), testVersion: (1, 1, 0))
            equal(version: try! Version(raw: "1.1.1"), testVersion: (1, 1, 1))
            
            equal(version: try! Version(raw: "100.0.0"), testVersion: (100, 0, 0))
            equal(version: try! Version(raw: "100.100.0"), testVersion: (100, 100, 0))
            equal(version: try! Version(raw: "100.100.100"), testVersion: (100, 100, 100))
        }
        
        func testInitVersionWithCustomSeparator() {
            func tryCreate(rawVersion: String, with separator: Character) {
                do {
                    _ = try Version(raw: rawVersion, separator: separator)
                } catch {
                    XCTFail("rawVersion: \(rawVersion) | separator: \(separator)")
                }
            }
            
            tryCreate(rawVersion: "1.1.1", with: ".")
            tryCreate(rawVersion: "1,1,1", with: ",")
        }
        
        func testInitVersionErrors() {
            do {
                _ = try Version(raw: "1.0", separator: ",")
                XCTFail()
            } catch Version.Error.stringContainsWrongFormat {
            } catch {
                XCTFail()
            }
            
            do {
                _ = try Version(raw: "1.0.0.0", separator: ".")
                XCTFail()
            } catch Version.Error.wrongRawVersion {
            } catch {
                XCTFail()
            }
        }
        
        func testVersionComparable() {
            func version(_ version: Version, lessThan version2: Version) {
                let message = "\(version) >= \(version2)"
                XCTAssertLessThan(version, version2, message)
            }
            
            func version(_ version: Version, greaterThan version2: Version) {
                let message = "\(version) <= \(version2)"
                XCTAssertGreaterThan(version, version2, message)
            }
            
            func version(_ version: Version, equal version2: Version) {
                let message = "\(version) != \(version2)"
                XCTAssertEqual(version, version2, message)
            }
            
            do {
                version(try Version(raw: "1"), lessThan: try Version(raw: "2"))
                version(try Version(raw: "1.1"), lessThan: try Version(raw: "1.2"))
                version(try Version(raw: "1.1.1"), lessThan: try Version(raw: "1.1.2"))
                
                version(try Version(raw: "2"), greaterThan: try Version(raw: "1"))
                version(try Version(raw: "1.2"), greaterThan: try Version(raw: "1.1"))
                version(try Version(raw: "1.1.2"), greaterThan: try Version(raw: "1.1.1"))
                
                version(try Version(raw: "2"), greaterThan: try Version(raw: "1"))
                version(try Version(raw: "2.2"), greaterThan: try Version(raw: "1.1"))
                version(try Version(raw: "2.1.2"), greaterThan: try Version(raw: "1.1.1"))
                
                version(try Version(raw: "2"), equal: try Version(raw: "2"))
                version(try Version(raw: "1.2"), equal: try Version(raw: "1.2"))
                version(try Version(raw: "1.1.2"), equal: try Version(raw: "1.1.2"))
            } catch {
                XCTFail()
            }
        }
    }
