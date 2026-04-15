// swift-tools-version:5.3

import PackageDescription

/// Slates: swift-tree-sitter + two library products (TypeScript and TSX).
/// Each grammar uses `path: "typescript"` / `path: "tsx"` so SPM embeds `queries/highlights.scm`
/// at `TreeSitter*_* .bundle/.../queries/` (required by swift-tree-sitter `LanguageConfiguration`).
let package = Package(
    name: "TreeSitterTypeScript",
    products: [
        .library(name: "TreeSitterTypeScript", targets: ["TreeSitterTypeScript"]),
        .library(name: "TreeSitterTSX", targets: ["TreeSitterTSX"]),
    ],
    dependencies: [
        .package(name: "SwiftTreeSitter", url: "https://github.com/tree-sitter/swift-tree-sitter", from: "0.9.0"),
    ],
    targets: [
        .target(
            name: "TreeSitterTypeScript",
            dependencies: [],
            path: "typescript",
            exclude: [
                "grammar.js",
                "package.json",
                "CMakeLists.txt",
                "Makefile",
                "src/grammar.json",
                "src/node-types.json",
                "bindings/c",
                "bindings/go",
                "bindings/node",
                "bindings/python",
                "bindings/rust",
                "bindings/swift/TreeSitterTypeScriptTests",
            ],
            sources: ["src/parser.c", "src/scanner.c"],
            resources: [.copy("queries")],
            publicHeadersPath: "bindings/swift/typescript/TreeSitterTypeScript",
            cSettings: [.headerSearchPath("src")],
        ),
        .target(
            name: "TreeSitterTSX",
            dependencies: [],
            path: "tsx",
            exclude: [
                "grammar.js",
                "package.json",
                "CMakeLists.txt",
                "Makefile",
                "src/grammar.json",
                "src/node-types.json",
                "bindings/c",
                "bindings/go",
                "bindings/node",
                "bindings/python",
                "bindings/rust",
                "bindings/swift/TreeSitterTypeScriptTests",
            ],
            sources: ["src/parser.c", "src/scanner.c"],
            resources: [.copy("queries")],
            publicHeadersPath: "bindings/swift/tsx/TreeSitterTSX",
            cSettings: [.headerSearchPath("src")],
        ),
        .testTarget(
            name: "TreeSitterTypeScriptTests",
            dependencies: [
                "SwiftTreeSitter",
                "TreeSitterTypeScript",
                "TreeSitterTSX",
            ],
            path: "bindings/swift/TreeSitterTypeScriptTests",
        ),
    ],
    cLanguageStandard: .c11,
)
