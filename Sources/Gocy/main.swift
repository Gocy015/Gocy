import Foundation
import CommandLineKit
import GocyKit

let cli = CommandLineKit.CommandLine()

let add = MultiStringOption(shortFlag: "a", longFlag: "add",
                       helpMessage: "add an application to launch.")


let remove = MultiStringOption(shortFlag: "r", longFlag: "remove",
                       helpMessage: "remove an existing application.")

let help = BoolOption(shortFlag: "h", longFlag: "help",
                      helpMessage: "Prints a help message.")

let launch = BoolOption(shortFlag: "l", longFlag: "launch",
                        helpMessage: "launch all specified applications.")

cli.addOptions(add,remove,launch,help)

do {
    try cli.parse()
} catch {
    cli.printUsage(error)
    exit(EX_USAGE)
} 

var manager = GocyLaunchManager()

if let adds = add.value{
    manager.add(applications: adds)
}
if let removes = remove.value{
    manager.remove(applications: removes)
}
