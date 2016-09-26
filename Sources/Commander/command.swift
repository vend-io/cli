import Foundation

public class Command {
    public private(set) var options: [Option] = []
    public init () { }
    public func option(_ flags: String, _ description: String) -> Command {
        options.append(Option(flags, description))
        return self
    }
    public func option(_ flags: String, _ description: String, _ fn: (_ value: Any) -> Any) -> Command {
      options.append(Option(flags, description))
      return self
    }
}