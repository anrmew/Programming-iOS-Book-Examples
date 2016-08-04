
import UIKit

@UIApplicationMain
class AppDelegate : UIResponder, UIApplicationDelegate {
    var window : UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
        self.window = UIWindow()
        let nav = UINavigationController(rootViewController:
            RootViewController(nibName: "RootViewController", bundle: nil))
        self.window!.rootViewController = nav
        self.window!.backgroundColor = .white
        self.window!.makeKeyAndVisible()
        return true
    }
}
