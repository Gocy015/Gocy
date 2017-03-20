import Foundation

public struct GocyLaunchManager{
    
    public internal(set) var applications:[String]
    
    public init(){
        applications = []
    }
    public mutating func add(applications apps:[String]){
        for app in apps {
            if validate(app: app) {
                applications.append(app)
            }
        }
        print(applications)
    }
    public mutating func remove(applications apps:[String]){
        for app in apps{
            if let idx = applications.index(of: app) {
                applications.remove(at: idx) //perfectly save in swift ,not safe in objc
            }
        }
        
        print(applications)
    }
    public func launch(){
        
    }
    
    
    //interanl
    func validate(app:String) -> Bool{
        return true
    }
}

