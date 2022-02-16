import Foundation

public struct Version {
    public static let zero = Version(major: 0, minor: 0, patch: 0)
    
    public let major: Int
    public let minor: Int
    public let patch: Int
}

public extension Version {
    init(raw: String, separator: Character = ".") throws {
        let components = raw.split(separator: separator).map(String.init)
        switch components.count {
        case 1:
            major = try Version.intFromString(components[0])
            minor = 0
            patch = 0
        case 2:
            major = try Version.intFromString(components[0])
            minor = try Version.intFromString(components[1])
            patch = 0
        case 3:
            major = try Version.intFromString(components[0])
            minor = try Version.intFromString(components[1])
            patch = try Version.intFromString(components[2])
        default:
            throw Error.wrongRawVersion
        }
    }
    
    private static func intFromString(_ rawInt: String) throws -> Int {
        if let value = Int(rawInt) {
            return value
        } else {
            throw Error.stringContainsWrongFormat
        }
    }
}

extension Version: Equatable { }

extension Version: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        return (lhs.major < rhs.major) ||
            (lhs.major == rhs.major && lhs.minor < rhs.minor) ||
            (lhs.major == rhs.major && lhs.minor == rhs.minor && lhs.patch < rhs.patch)
    }
}

public extension Version {
    enum Error: Swift.Error {
        case wrongRawVersion
        case stringContainsWrongFormat
    }
}

