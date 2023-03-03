# Changelog

The changelog for `Foil`. Also see the [releases](https://github.com/jessesquires/Foil/releases) on GitHub.

NEXT
-----

- TBA

4.0.1
-----

This release closes the [4.0.1 milestone](https://github.com/jessesquires/Foil/milestone/6?closed=1).

### Fixed

- `WrappedDefaultOptional` no longer crashes when the type stored in `UserDefaults` does not match the type being requested, `nil` is now returned instead. ([#70](https://github.com/jessesquires/Foil/pull/70), [@ejensen](https://github.com/ejensen))

4.0.0
-----

This release closes the [4.0.0 milestone](https://github.com/jessesquires/Foil/milestone/5?closed=1).

### New

- The publisher projected by the property wrapper now sends values when user defaults changes from anywhere. Previously, only when using the property wrapper's setter would the projected publisher send a new value. ([#61](https://github.com/jessesquires/Foil/pull/61), [@nolanw](https://github.com/nolanw))

### Breaking

- Due to [#61](https://github.com/jessesquires/Foil/pull/61) (see above), there are some (potentially) breaking changes with key names. If any of your keys are named like the following examples and you need to observe changes, you will need to migrate your key names.
    - Key names starting with an `@` character **do not** notify observers on updates.
        - Example: `@my-key-name`
    - Key names containing a `.` character _anywhere_ in the name **do not** notify observers on updates. (This is a side-effect of `KeyPaths` which include periods.)
        - Example: `com.myApp.my-key-name`

### Changed

- Upgrade to Xcode 14
- Upgrade to Swift 5.7

3.0.0
-----

This release closes the [3.0.0 milestone](https://github.com/jessesquires/Foil/milestone/4?closed=1).

### New

- Refined the Combine API for responding to changes. This removes the need for the `.publisher(for:)` KVO API call. See the updated documentation for additional details. ([#38](https://github.com/jessesquires/Foil/issues/38), [@JonnyBeeGod](https://github.com/JonnyBeeGod))

### Breaking

- Updated minimum deployment targets for all platforms
    - iOS 13.0
    - tvOS 13.0
    - watchOS 6.0
    - macOS 11.0

2.0.0
-----

This release closes the [2.0.0 milestone](https://github.com/jessesquires/Foil/milestone/3?closed=1).

### Breaking

- Implemented more succinct implicit initialization. See example below. ([#36](https://github.com/jessesquires/Foil/issues/36), [@jessesquires](https://github.com/jessesquires))

```swift
// OLD
@WrappedDefault(keyName: "flag", defaultValue: true)
var flag: Bool

// NEW
@WrappedDefault(key: "flag")
var flag = true
```

### Changed

- Various project infra updates: Xcode 13, Swift 5.5, etc. ([#34](https://github.com/jessesquires/Foil/issues/34), [@jessesquires](https://github.com/jessesquires))

1.2.0
-----

This release closes the [1.2.0 milestone](https://github.com/jessesquires/Foil/milestone/2?closed=1).

- Fix deployment target inconsistencies between CocoaPods and SwiftPM. ([#18](https://github.com/jessesquires/Foil/issues/18), [#19](https://github.com/jessesquires/Foil/pull/19), [@kambala-decapitator](https://github.com/kambala-decapitator), [@jessesquires](https://github.com/jessesquires))

- Lower deployment targets to support iOS/tvOS 9.0 and above. ([#16](https://github.com/jessesquires/Foil/issues/16), [#19](https://github.com/jessesquires/Foil/pull/19), [@kambala-decapitator](https://github.com/kambala-decapitator), [@jessesquires](https://github.com/jessesquires))

1.1.0
-----

This release closes the [1.1.0 milestone](https://github.com/jessesquires/Foil/milestone/1?closed=1).

- Added support for custom `RawRepresentable` types ([#10](https://github.com/jessesquires/Foil/pull/10), [@basememara](https://github.com/basememara))

- Add default support for `UInt` ([#3](https://github.com/jessesquires/Foil/issues/3), [#12](https://github.com/jessesquires/Foil/pull/12), [@jessesquires](https://github.com/jessesquires))

- Updated documentation with examples for observing changes in defaults ([#4](https://github.com/jessesquires/Foil/issues/4), [#5](https://github.com/jessesquires/Foil/pull/5), [@basememara](https://github.com/basememara))

- Updated documentation with examples for observing changes in defaults when using Foil ([#4](https://github.com/jessesquires/Foil/issues/4), [#5](https://github.com/jessesquires/Foil/pull/5), [@basememara](https://github.com/basememara))

- Minor documentation and internal library improvements ([@jessesquires](https://github.com/jessesquires))

1.0.0
-----

Initial release. 🎉

[Documentation available here](https://jessesquires.github.io/Foil/).
