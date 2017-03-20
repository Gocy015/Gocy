import Foundation

public struct GocyLaunchManager{
    
    private var applications:[String]
    
    private let storage_key = "gocy.launchmanager.applications"
    private var changed : Bool = false
    
    
    public init(){
        
        applications = []
        if let apps = UserDefaults.standard.value(forKey: storage_key) as? [String]{
            applications = apps
        }
        
    }
    public mutating func add(applications apps:[String]){
        for app in apps {
            if validate(app: app) {
                applications.append(app)
                changed = true
            }
        }
    }
    public mutating func remove(applications apps:[String]){
        for app in apps{
            if let idx = applications.index(of: app) {
                applications.remove(at: idx) //perfectly save in swift ,not safe in objc
                changed = true
            }
        }
        
    }
    
    public mutating func save(){
        if !changed {
            return
        }
        UserDefaults.standard.set(applications, forKey: storage_key)
        if(UserDefaults.standard.synchronize()){
            print("configuration saved.")
            changed = false
        }
    }
    
    public func printApplications(){
        for app in applications{
            print("\(app)")
        }
    }
    
    public func launch(){
        
    }
    
    
    //interanl
    func validate(app:String) -> Bool{
        return true
    }
}

