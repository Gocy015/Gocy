import Foundation
import PathKit
import AppKit

public struct GocyLaunchManager{
    
    private var applications:Set<String>
    private var installedApplications :[String] = []
    
    private let storage_key = "gocy.launchmanager.applications"
    private var changed : Bool = false
    
    
    public init(){
        
        applications = []
        if let appsArray = UserDefaults.standard.value(forKey: storage_key) as? [String]{
            applications = Set(appsArray)
        }
        
        installedApplications = getInstalledApplications()
        
    }
    
    func getInstalledApplications() -> [String]{
        guard let url = FileManager.default.urls(for: .applicationDirectory, in: .localDomainMask).first else{
            print("fail to load application directory")
            exit(EX_IOERR)
            
        }
        
        let properties = [URLResourceKey.localizedNameKey,URLResourceKey.nameKey]
        
        let installedApps : [URL]
        do{
            installedApps = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: properties, options: .skipsHiddenFiles)
        }catch let error{
            print("fail to load contents of application directory ,error : \(error)")
            exit(EX_IOERR)
        }
        var apps = [String]()
        
        for appUrl in installedApps {
            let app = Path(appUrl.absoluteString).lastComponentWithoutExtension.lowercased()
            apps.append(app)
        }
        return apps
    }
    
    public mutating func add(applications apps:[String]){
        for app in apps {
            if validate(app: app) {
                let res = applications.insert(app)
                if res.inserted {
                    changed = true
                }
            }else{
                print("Counldn't find installed application : \(app) ,please try again.")
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
    
    public mutating func removeAll(){
        if applications.count > 0 {
            applications.removeAll()
            changed = true
        }
    }
    
    public mutating func save(){
        if !changed {
            return
        }
        self.printApplications()
        UserDefaults.standard.set(Array(applications), forKey: storage_key)
        if(UserDefaults.standard.synchronize()){
            print("configuration saved.")
            changed = false
        }
    }
    
    public func printApplications(){
        if applications.count > 0 {
            for app in applications{
                print("\(app)")
            }
        }else{
            print("No application added for now.")
        }
        
    }
    
    public func launch(){
        for app in applications {
            let success = NSWorkspace.shared().launchApplication(app)
        }
    }
    
    
    //interanl
    func validate(app:String) -> Bool{
        return installedApplications.contains(app.lowercased())
    }
}

