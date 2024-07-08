OpenTweet
=========

## System Design

The following image explains the overall architecture of the app.

![Untitled-2024-07-08-1631-2](https://github.com/omarzl/OpenTweet/assets/6267487/b8e2314d-ec16-4acc-b19f-3cd05f8a8ce4)

When the app opens, it presents the Tweet Timeline feature module, using the Injection service to resolve the implementation module.

Once a tweet is tap, it will present the Tweet Thread feature.

## Linking

The app demonstrates different ways to ship and link dependencies.

### Dynamic frameworks

The module `InjectionService` is built as a dynamic framework.

This can be demonstrated by looking into the `Frameworks` directory of the app:
```
tree -L 1 OpenTweet.app/Frameworks

OpenTweet.app/Frameworks
└── InjectionService.framework
```
The `InjectionService` will be linked at runtime by `dyld`

### Static frameworks

The module NetworkingService demonstrates the usage of a static framework.

Its code will be linked to the app binary during build time, it can be validated by searching for the symbols:
```
nm -U OpenTweet.app/OpenTweet | grep 'NetworkingService' | xcrun swift-demangle

0000000100034ed8 S protocol descriptor for NetworkingService.NetworkingRequesting
```
Note that it won't and shouldn't be in the `OpenTweet.app/Frameworks` directory.

### Static libraries

The rest of the modules are static archives/libraries that will be linked to the app binary as the static frameworks.

## Compilation

### Vanilla Xcode project

The app and tests can run using the project `OpenTweet.xcodeproj`. It was created using Xcode.

### Bazel

The app and tests can run using Bazel build system. The targets are defined in the `BUILD` file at the root.

Bazelisk should be installed first: `brew install bazelisk`

Then the app can run in a simulator executing `bazel run //:App`

Output example:
```
bazel run //:App
INFO: Analyzed target //:App (0 packages loaded, 6 targets configured).
INFO: Found 1 target...
Target //:App up-to-date:
  bazel-bin/App.ipa
INFO: Elapsed time: 2.178s, Critical Path: 1.99s
INFO: 32 processes: 21 internal, 10 darwin-sandbox, 1 local.
INFO: Build completed successfully, 32 total actions
INFO: Running command line: bazel-bin/App
2024-07-08 17:08:24.693 INFO Launching simulator with udid: 6E9886E2-86CA-452D-A6D5-C8276165C7F0
2024-07-08 17:08:24.797 INFO Waiting for simulator to boot...
2024-07-08 17:08:38.082 INFO Launching app com.omarzl.OpenTweet in simulator 6E9886E2-86CA-452D-A6D5-C8276165C7F0
com.omarzl.OpenTweet: 23311
```

And the tests can be executed with `bazel test --test_output=all //:UnitTests`

Output example:
```
bazel test //:UnitTests
INFO: Analyzed target //:UnitTests (0 packages loaded, 0 targets configured).
INFO: Found 1 test target...
Target //:UnitTests up-to-date:
  bazel-bin/UnitTests
  bazel-out/ios_sim_arm64-fastbuild-ios-sim_arm64-min17.5-applebin_ios-ST-2812ac92efab/bin/UnitTests.zip
INFO: Elapsed time: 0.215s, Critical Path: 0.00s
INFO: 1 process: 1 internal.
INFO: Build completed successfully, 1 total action
//:UnitTests                                                    (cached) PASSED in 1.9s

Executed 0 out of 1 test: 1 test passes.
```

### BwX

The project supports Bazel with Xcode using [rules_xcodeproj](https://github.com/MobileNativeFoundation/rules_xcodeproj) rules.

By running `bazel run //:xcodeproj` an `App.xcodeproj` will be generated in the root of the repo allowing you to run and test the app using Xcode.

## Code

### Networking

The networking code can be found in `NetworkingService`. It uses async/await capabilities from `URLSession`.

I added a property wrapper in `NetworkingServiceInterface` that allows an easier usage, example:

```
@NetworkRequest(url: "https://www.someendpoint.com/timeline")
private var request: AnyPublisher<Timeline, any Error>

request.sink { result in
  ...
} receiveValue: { timeline in
  ...
}
.store(in: &cancellables)
```

### Injection

To keep things simple, a created a simple injection implementation that can be found in the module `InjectionService`

It also has a property wrapper:
```
@Inject
var tweetThreadFeature: (any TweetThreadFeatureInterface)?
```

### Storage

I gave a try to `SwiftData`, this was my first time using it, and to be honest I wouldn't use it in production yet. It has many edge cases that can cause crashes. But for the purpose of this project, it worked.

The configuration can be found in the file `OpenTweetModelContainer` in the app target.

And the only model `Tweet` is in the `TweetFoundation` module.

### SwiftLint

Code style is forced using [SwiftLint](https://github.com/realm/SwiftLint), a script runs it when the app compiles.

### SwiftUI

I used SwiftUI to present the data, the views can be found in the modules `TweetTimelineFeature` and `TweetThreadFeature`.

## Functionality

This video showcase the functionality and UI/UX of the application.

https://github.com/omarzl/OpenTweet/assets/6267487/c4955277-e106-40a5-917c-25467b4491ac

## Tests

### Unit Tests

I wrote my tests using Behavior Driven Development or Given-When-Then.

There are many test bundles: `NetworkingServiceTests`, `InjectionServiceTests`, `TweetTimelineFeatureTests` and `TweetThreadFeatureTests`.
I didn't use `OpenTweetTests` because the app binary doesn't have logic at all.

### Snapshot Tests

I used the external dependency [Snapshot Testing](https://github.com/pointfreeco/swift-snapshot-testing) to add snapshot test to the two feature views.

Example:

![testView 1](https://github.com/omarzl/OpenTweet/assets/6267487/83d3c64f-d160-4bb8-bbc1-46ad53a80439)
