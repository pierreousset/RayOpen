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
        defaults.removeObject(forKey: RecentApplications.preferenceKey)
        defaults.set(history.paths, forKey: RecentApplications.legacyPreferenceKey)
        var migrated = RecentApplications(defaults: defaults)
        precondition(migrated.paths == history.paths, "Legacy app history must migrate in order")
        migrated.recordTranslation()
        precondition(migrated.paths == [RecentApplications.translationID, "/Applications/B.app", "/Applications/D.app"], "Translation must share the three-item limit")
        migrated.record(URL(fileURLWithPath: "/Applications/B.app"))
        migrated.recordTranslation()
        precondition(migrated.paths == [RecentApplications.translationID, "/Applications/B.app", "/Applications/D.app"], "Repeated commands must move to front without duplicates")
        precondition(migrated.availablePaths { _ in false } == [RecentApplications.translationID], "Translation must remain valid when apps are unavailable")
        defaults.set(migrated.paths, forKey: RecentApplications.preferenceKey)
        precondition(RecentApplications(defaults: defaults).paths == migrated.paths, "Mixed history must persist and take precedence over legacy history")
        defaults.set([], forKey: RecentApplications.preferenceKey)
        precondition(RecentApplications(defaults: defaults).paths.isEmpty, "Empty new history must not restore legacy history")
        print("Recent launcher regression tests passed")
    }
}
