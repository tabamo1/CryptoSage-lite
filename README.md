# CryptoSage Lite

CryptoSage Lite is a small Flutter pilot app used to test a free, low-noise GitHub automation setup before reusing anything on more sensitive repositories.

## Current Source Layout

The Flutter app source is now exposed directly in the repository:

- `pubspec.yaml` for Dart/Flutter dependencies
- `lib/` for application source
- `.github/workflows/` for automation

The old uploaded source zip remains in the repository for historical reference, but the active workflows use the extracted source files.

## Automation Included

### Validate Flutter Source

Workflow: `.github/workflows/ci.yml`

Runs on pushes and pull requests. It creates a temporary Android Flutter project, copies the extracted source into it, installs packages, runs `flutter analyze`, and runs tests when a `test/` directory exists.

### Semgrep CE Pilot Scan

Workflow: `.github/workflows/semgrep.yml`

Runs the free Semgrep Community Edition CLI with explicit `p/default` and `p/secrets` rulesets. Metrics are disabled. Dependabot-triggered runs are skipped to reduce noise.

### Build Android APK

Workflow: `.github/workflows/apk.yml`

Manual workflow dispatch only. It creates a temporary Android Flutter project, builds a release APK, and uploads the APK as a GitHub Actions artifact.

Latest verified APK artifact from the pilot:

- Workflow run: `Build Android APK #9`
- Artifact: `cryptosage-ai-lite-apk`
- Size: about 23 MB
- Digest: `sha256:f89c3802ce8aac2a701077454cd728b5a8b14a697fadeb4f30ea52ba318dc271`

### Dependabot

Config: `.github/dependabot.yml`

Dependabot checks:

- GitHub Actions weekly
- Dart/Flutter `pub` packages weekly

Updates are grouped to avoid noisy separate pull requests.

## Tools Evaluated But Not Kept

Socket Security was evaluated but not installed for this pilot. Although it has a `$0` Marketplace plan, installation required billing-profile setup, the GitHub Actions path required a Socket API key, and its listed supported languages did not include Dart/Flutter. It was not a good fit for this repository.

## Reuse Recommendation For Future CPSC/Legal-Office Repositories

Safe to reuse first:

- GitHub Actions for repo-local validation and document/build checks
- Dependabot for GitHub Actions and ordinary package updates
- Semgrep CE only for code repositories, with metrics disabled and explicit rulesets

Use cautiously:

- Any third-party Marketplace app that asks for broad repository access, billing setup, account tokens, or access to private legal-office materials

Do not install on sensitive legal repositories until the tool has been tested on a non-sensitive pilot and its permissions are understood.

## Pilot Outcome

This pilot supports a conservative pattern for future work: start with built-in GitHub automation, keep third-party tools minimal, scope everything to selected repositories, and verify that each tool produces useful results without excessive noise.
