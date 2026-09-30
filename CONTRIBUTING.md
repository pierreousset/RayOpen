# Contributing to RayOpen

Everyone is welcome to contribute fixes, translations, accessibility improvements, documentation, or ideas. MIT permits using, modifying, and redistributing the code while retaining the license notice. Third-party models and tools retain their own licenses.

## Propose an improvement

1. For a substantial change, open an issue to discuss the need. Do not publicly disclose vulnerabilities; see [SECURITY.md](SECURITY.md).
2. Fork the repository and create a focused branch from `main`.
3. Keep changes scoped, without secrets, personal data, private translation text, or generated files.
4. Build with `./scripts/build-app.sh`, run `swift test`, and manually check affected interactions on macOS.
5. Open a pull request targeting `main`, describing the change and checks actually performed.

Changes require pull requests and maintainer review. Direct pushes to `main` are not part of the process. Merging does not automatically distribute a release to users.

## Things to preserve

Keep RayOpen local and free. Preserve loopback-only servers, request cancellation, and existing preferences. Describe new network access, macOS permissions, text storage, or clipboard behavior. Document limitations instead of promising accurate or instant translation.

Submitting a contribution means agreeing to its distribution under the project's MIT license. Remain respectful and help reviewers with small pull requests.
