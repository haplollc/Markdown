<div align="center">

# Markdown

**A native SwiftUI Markdown rendering engine for Apple platforms.**

Render GitHub-flavored Markdown as real SwiftUI views — headings,
emphasis, lists, tables, block quotes, fenced code, and images — with a
fully themeable styling system. Built and maintained by **Haplo LLC**;
powers the PDF export in [md2pdf](https://github.com/haplollc/md2pdf).

[![Swift](https://img.shields.io/badge/Swift-5.9-orange?style=flat-square&logo=swift)](https://swift.org)
[![Platforms](https://img.shields.io/badge/platforms-macOS%20·%20iOS%20·%20tvOS%20·%20watchOS-black?style=flat-square&logo=apple)](https://developer.apple.com)
[![SwiftUI](https://img.shields.io/badge/SwiftUI-blue?style=flat-square&logo=swift)](https://developer.apple.com/swiftui/)
[![License](https://img.shields.io/badge/license-MIT-green?style=flat-square)](LICENSE)

</div>

---

## Install

### Swift Package Manager

```swift
dependencies: [
  .package(url: "https://github.com/haplollc/Markdown.git", branch: "main")
]
```

Then add `Markdown` to your target's dependencies and:

```swift
import Markdown
```

### As a submodule (how md2pdf consumes it)

```sh
git submodule add https://github.com/haplollc/Markdown.git Packages/Markdown
```

…then reference `Packages/Markdown` as a local package in Xcode.

---

## Quick start

```swift
import SwiftUI
import Markdown

struct ContentView: View {
  var body: some View {
    ScrollView {
      Markdown(
        """
        # Hello, Markdown

        Render **bold**, *italic*, `code`, and [links](https://example.com)
        as native SwiftUI text — no web view, no HTML bridge.

        - bullet one
        - bullet two

        > A block quote, styled by the active theme.
        """
      )
      .markdownTheme(.docC)
      .padding()
    }
  }
}
```

---

## What it renders

| Element | Supported |
| --- | --- |
| Headings (h1–h6) | ✅ |
| Bold / italic / strikethrough / inline code | ✅ |
| Ordered, unordered, and task lists (nested) | ✅ |
| Block quotes (nested) | ✅ |
| Tables with alignment + borders | ✅ |
| Fenced code blocks | ✅ (pluggable syntax highlighter) |
| Images (asset, file, and network URLs) | ✅ |
| Links | ✅ |
| Thematic breaks | ✅ |

Anything beyond CommonMark + GFM (LaTeX math, Mermaid diagrams,
footnotes) is handled by the **host app** at the source level — see
md2pdf's preprocessor — rather than baked into the renderer.

---

## Theming

Styling is driven by a `Theme` value with per-element block and text
styles. A DocC-style theme ships in the box:

```swift
Markdown(source)
  .markdownTheme(.docC)
```

Override individual pieces without rebuilding the whole theme:

```swift
Markdown(source)
  .markdownTextStyle(\.code) {
    FontFamilyVariant(.monospaced)
    FontSize(.em(0.9))
    ForegroundColor(.purple)
  }
  .markdownBlockStyle(\.blockquote) { configuration in
    configuration.label
      .padding()
      .overlay(alignment: .leading) { Rectangle().frame(width: 3) }
  }
```

### Pluggable code highlighting

Implement `CodeSyntaxHighlighter` to color fenced code blocks however
you like, then install it:

```swift
Markdown(source)
  .markdownCodeSyntaxHighlighter(MyHighlighter())
```

The default is plain text, so highlighting is entirely opt-in. (md2pdf
ships a dependency-free tokenizer covering Swift, JS/TS, Python, JSON,
HTML, CSS, shell, and Ruby.)

### Custom image providers

`ImageProvider` and `InlineImageProvider` let you control how images
load and size. md2pdf, for instance, supplies pre-downloaded images so
they render synchronously during static PDF snapshotting.

---

## Showcase

The [md2pdf feature showcase](https://github.com/haplollc/md2pdf/blob/main/Fixtures/feature_showcase.md)
is a single Markdown document that exercises the full surface — inline
formatting, every heading level, nested lists, block quotes, tables,
code in several languages, and images. Open it in md2pdf and export to
PDF to see the renderer's output end-to-end.

---

## Platform support

- macOS 12+
- iOS 15+
- tvOS 15+
- macCatalyst 15+
- watchOS 8+

---

## Credits & license

Released under the [MIT License](LICENSE).

`Markdown` is a substantially modified derivative of
[swift-markdown-ui](https://github.com/gonzalezreal/swift-markdown-ui)
by Guillermo Gonzalez, used under MIT. The original copyright notice is
retained in `LICENSE` alongside Haplo's. Markdown parsing is powered by
[swift-cmark](https://github.com/apple/swift-cmark) (cmark-gfm);
network image loading by
[NetworkImage](https://github.com/gonzalezreal/NetworkImage).
