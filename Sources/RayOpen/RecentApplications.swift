import Foundation

/// Local launcher history; this does not track launches outside RayOpen.
struct RecentApplications {
    static let preferenceKey = "recentLauncherItemIDs"
    static let legacyPreferenceKey = "recentApplicationPaths"
    static let translationID = "command:translation"
    private(set) var paths: [String]

    init(paths: [String]) {
        var seen = Set<String>()
        self.paths = Array(paths.filter {
            ($0 == Self.translationID || $0.hasPrefix("/")) && seen.insert($0).inserted
        }.prefix(3))
    }

    init(defaults: UserDefaults) {
        self.init(paths: defaults.stringArray(forKey: Self.preferenceKey)
            ?? defaults.stringArray(forKey: Self.legacyPreferenceKey) ?? [])
    }

    mutating func record(_ url: URL) {
        recordID(url.standardizedFileURL.path)
    }

    mutating func recordTranslation() {
        recordID(Self.translationID)
    }

    private mutating func recordID(_ id: String) {
        paths = Array(([id] + paths.filter { $0 != id }).prefix(3))
    }

    func availablePaths(isAvailable: (String) -> Bool) -> [String] {
        paths.filter { $0 == Self.translationID || isAvailable($0) }
    }
}
