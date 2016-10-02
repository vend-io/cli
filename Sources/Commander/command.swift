import Foundation
import Extensions

public class Command {
    public private(set) var options = [Option]()
    public private(set) var commands = [Command]()
    public private(set) var name: String = ""
    public private(set) var arguments = [String]()
    public init () { }
    public init (name: String) {
        self.name = name
    }

    public func command(name: String, opts: [String]?) {
        var args = name.split("/ +/")
        var cmd = Command()
    }

    public func option(_ flags: String, _ description: String) -> Command {
        options.append(Option(flags, description))
        return self
    }
    public func option<T>(_ flags: String, _ description: String, _ fn: (T) -> Any) -> Command {
      options.append(Option(flags, description))
      return self
    }
}