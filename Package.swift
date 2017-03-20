import PackageDescription

let package = Package(
    name: "Gocy",
    targets :[
        Target(name :"GocyKit",dependencies:[]),
        Target(name :"Gocy",dependencies:["GocyKit"])
    ],
    dependencies:[
        .Package(url: "https://github.com/kylef/PathKit" , majorVersion: 0 ,minor:8),
        .Package(url: "https://github.com/jatoben/CommandLine" , "3.0.0-pre1")
    ]
)
 
