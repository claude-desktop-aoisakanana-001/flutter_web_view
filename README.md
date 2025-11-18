# yomiagerun_app

A new Flutter project.

## iOS Build Pipeline

This project includes an automated iOS build pipeline using GitHub Actions. **No Mac or Xcode required!**

### Features

- Automated iOS development builds using GitHub Actions macOS runners
- Fastlane integration for certificate and provisioning profile management
- App Store Connect API authentication
- Automatic IPA generation and artifact upload

### Setup

To set up the iOS build pipeline, follow the comprehensive guide:

**[iOS Build Setup Guide](.github/workflows/IOS_BUILD_SETUP.md)**

Key requirements:
- Apple Developer Program account ($99/year)
- App Store Connect API Key
- GitHub repository secrets configuration

### Quick Start

1. Create App Store Connect API Key
2. Configure GitHub Secrets (see setup guide)
3. Push changes to trigger the workflow
4. Download IPA from GitHub Actions artifacts

For detailed instructions, see [IOS_BUILD_SETUP.md](.github/workflows/IOS_BUILD_SETUP.md).

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
