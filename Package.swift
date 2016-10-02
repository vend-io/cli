import PackageDescription

let package = Package(name: "CLI",
    targets: [
      Target(name: "CLI", dependencies: [
        .Target(name: "Commander"),
        .Target(name: "Rexy"),
        .Target(name: "Extensions")
      ]),
      Target(name: "Commander", dependencies: [
        .Target(name: "Rexy"),
        .Target(name: "Extensions"),
        .Target(name: "EventEmitter")
      ])
    ],
    dependencies: []
)