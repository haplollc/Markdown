// swift-tools-version:5.9
//
//  Markdown — a SwiftUI Markdown rendering engine.
//  Maintained by Haplo LLC.
//
//  Derived from swift-markdown-ui (MIT). See LICENSE for the retained
//  upstream notice alongside Haplo's modifications.
//

import PackageDescription

let package = Package(
  name: "Markdown",
  platforms: [
    .macOS(.v12),
    .iOS(.v15),
    .tvOS(.v15),
    .macCatalyst(.v15),
    .watchOS(.v8),
  ],
  products: [
    .library(name: "Markdown", targets: ["Markdown"]),
  ],
  dependencies: [
    .package(url: "https://github.com/gonzalezreal/NetworkImage", from: "6.0.0"),
    .package(url: "https://github.com/apple/swift-cmark.git", from: "0.4.0"),
  ],
  targets: [
    .target(
      name: "Markdown",
      dependencies: [
        .product(name: "cmark-gfm", package: "swift-cmark"),
        .product(name: "cmark-gfm-extensions", package: "swift-cmark"),
        .product(name: "NetworkImage", package: "NetworkImage"),
      ]
    ),
  ]
)
