import Foundation
import Extensions

public class Option {
    public private(set) var flags: String
    public private(set) var isRequired: Bool
    public private(set) var isOptional: Bool
    public private(set) var isBool: Bool = false
    public private(set) var short: String = ""
    public private(set) var long: String = ""
    public private(set) var description: String = ""

    init(_ flags: String, _ description: String) {
        self.flags = flags
        self.short = ""
        self.isRequired = flags.contains("<")
        self.isOptional = flags.contains("[")
        self.isBool = !flags.contains("-no-")
        print("flags: \(flags)")
        var f = flags.split("[ ,|]+")
        if f.count > 1 && !f[1].test("^[[<]") {
            self.short = f.shift()!
        }
        self.long = f.shift()!
        self.description = description
    }

    func name() -> String{
        return long
        .replace("--", "")
        .replace("no-", "");
    }

    func isFlag(arg: String) -> Bool {
        return arg == short || arg == long
    }
}