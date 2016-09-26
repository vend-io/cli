import Commander
import Rexy

for option in Command()
  .option("-i, --integer <n>", "An integer argument")
  .option("-f, --float <n>", "A float argument")
  .option("-r, --range <a>..<b>", "A range")
  .option("-l, --list <items>", "A list")
  .option("-o, --optional [value]", "An optional value")
  .option("-c, --collect [value]", "A repeatable value")
  .option("-v, --verbose", "A value that can be increased").options {
    print(
      "\nflags: \(option.flags),\n" +
      "isRequired: \(option.isRequired),\n" +
      "isBool: \(option.isBool),\n" +
      "short: \(option.short),\n" +
      "long: \(option.long)\n"
    )
  }


// if CommandLine.arguments.count != 2 {
//     print("Usage: hello NAME")
//     print(CommandLine.arguments)
// } else {
//     let name = CommandLine.arguments[1]
//     print(name)
// }