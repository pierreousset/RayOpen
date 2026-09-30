import Foundation

/// Local launch history; this does not track launches outside RayOpen.
struct RecentApplications {
    static let preferenceKey = "recentApplicationPaths"
    private(set) var paths: [String]

    init(paths: [String]) {
        var seen = Set<String>()
        self.paths = Array(paths.filter { !$0.isEmpty && seen.insert($0).inserted }.prefix(3))
    }

    mutating func record(_ url: URL) {
        let path = url.standardizedFileURL.path
        paths = Array(([path] + paths.filter { $0 != path }).prefix(3))
    }

    func availablePaths(isAvailable: (String) -> Bool) -> [String] {
        paths.filter(isAvailable)
    }
}
