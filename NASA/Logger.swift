import os.log
import Foundation

class Logger {
    static let log = OSLog(subsystem: Bundle.main.bundleIdentifier!, category: "network")
}
