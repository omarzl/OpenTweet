load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")
load(
  "@build_bazel_rules_apple//apple:ios.bzl",
  "ios_application",
  "ios_unit_test",
  "ios_framework",
)
load(
    "@rules_xcodeproj//xcodeproj:defs.bzl",
    "top_level_target",
    "xcodeproj",
)

# Dynamic frameworks

swift_library(
    name = "InjectionService",
    srcs = glob(["InjectionService/*.swift"]),
)

ios_framework(
    name = "InjectionServiceFramework",
    families = ["iphone"],
    bundle_id = "com.omarzl.InjectionService",
    minimum_os_version = "17.5",
    infoplists = ["InjectionService/Info.plist"],
    deps = [":InjectionService"],
)

# Static libraries

swift_library(
    name = "NetworkingService",
    srcs = glob(["NetworkingService/*.swift"]),
    deps = [":NetworkingServiceInterface"],
)

swift_library(
    name = "NetworkingServiceInterface",
    srcs = glob(["NetworkingServiceInterface/*.swift"]),
    deps = [":InjectionService"],
)

swift_library(
    name = "TweetFoundation",
    srcs = glob(["TweetFoundation/*.swift"]),
)

swift_library(
    name = "TweetThreadFeature",
    srcs = glob(["TweetThreadFeature/*.swift"]),
    deps = [":TweetUI", ":TweetThreadFeatureInterface"],
)

swift_library(
    name = "TweetThreadFeatureInterface",
    srcs = glob(["TweetThreadFeatureInterface/*.swift"]),
    deps = [":TweetFoundation"],
)

swift_library(
    name = "TweetTimelineFeature",
    srcs = glob(["TweetTimelineFeature/*.swift"]),
    deps = [
        ":TweetUI",
        ":TweetTimelineFeatureInterface",
        ":TweetThreadFeatureInterface",
        ":NetworkingServiceInterface"
    ],
)

swift_library(
    name = "TweetTimelineFeatureInterface",
    srcs = glob(["TweetTimelineFeatureInterface/*.swift"]),
    deps = [":TweetFoundation"],
)

swift_library(
    name = "TweetUI",
    srcs = glob(["TweetUI/*.swift"]),
    deps = [":TweetFoundation"],
)

# App targets

swift_library(
    name = "OpenTweetSources",
    srcs = glob(["OpenTweet/*.swift"]),
    deps = [
        ":TweetTimelineFeature",
        ":TweetThreadFeature",
        ":NetworkingService"
    ],
)

ios_application(
    name = "App",
    bundle_id = "com.omarzl.OpenTweet",
    families = ["iphone"],
    infoplists = [":OpenTweet/Info.plist"],
    minimum_os_version = "17.5",
    visibility = ["//visibility:public"],
    deps = [":OpenTweetSources"],
    frameworks = [":InjectionServiceFramework"],
)

# Tests

swift_library(
    name = "InjectionServiceTests",
    testonly = True,
    srcs = glob(["InjectionServiceTests/*.swift"]),
    deps = [
        ":InjectionService",
    ],
)

swift_library(
    name = "NetworkingServiceTests",
    testonly = True,
    srcs = glob(["NetworkingServiceTests/*.swift"]),
    deps = [
        ":NetworkingService",
    ],
)

swift_library(
    name = "OpenTweetTests",
    testonly = True,
    srcs = glob(["OpenTweetTests/*.swift"]),
    deps = [
        ":OpenTweetSources",
    ],
)

ios_unit_test(
    name = "UnitTests",
    minimum_os_version = "17.5",
    deps = [
        ":InjectionServiceTests",
        ":NetworkingServiceTests",
        ":OpenTweetTests",
    ],
    platform_type = "ios",
    visibility = ["//visibility:public"],
)