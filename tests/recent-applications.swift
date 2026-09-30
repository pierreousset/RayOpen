import Foundation

@main struct RecentApplicationsTests {
    static func main() {
        let suite = "org.rayopen.tests.recent.\(UUID().uuidString)"
        let defaults = UserDefaults(suiteName: suite)!
        defer { defaults.removePersistentDomain(forName: suite) }
        var history = RecentApplications(paths: [])
        for name in ["A", "B", "C", "D", "B"] {
            history.record(URL(fileURLWithPath: "/Applications/\(name).app"))
        }
        precondition(history.paths == ["/Applications/B.app", "/Applications/D.app", "/Applications/C.app"], "Repeat launch must move to front and evict oldest")
        defaults.set(history.paths, forKey: RecentApplications.preferenceKey)
        let restored = RecentApplications(paths: defaults.stringArray(forKey: RecentApplications.preferenceKey) ?? [])
        precondition(restored.paths == history.paths, "History must survive reloading defaults")
        let available = restored.availablePaths { $0 != "/Applications/D.app" }
        precondition(available == ["/Applications/B.app", "/Applications/C.app"], "Unavailable apps must be skipped without changing order")
        precondition(restored.paths == history.paths, "Temporary unavailability must not destroy stored history")
        let malformed = RecentApplications(paths: ["", "/A.app", "/A.app", "/B.app", "/C.app", "/D.app"])
        precondition(malformed.paths == ["/A.app", "/B.app", "/C.app"], "Persisted duplicates and empty values must not consume slots")
        print("Recent application regression tests passed")
    }
}
