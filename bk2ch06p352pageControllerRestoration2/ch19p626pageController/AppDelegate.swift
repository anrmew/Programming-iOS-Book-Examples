
import UIKit

@UIApplicationMain
class AppDelegate : UIResponder, UIApplicationDelegate {
    var window : UIWindow?
    var pep : [String]!
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.window = UIWindow()
        
        self.setUpPageViewController()
        
        self.window!.backgroundColor = .white
        self.window!.makeKeyAndVisible()
        return true
    }
    
    func application(_ application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
        return true
    }
    
    func application(_ application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
        return true
    }
    
    func setUpPageViewController() {
        self.pep = ["Manny", "Moe", "Jack"]
        // make a page view controller
        let pvc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        pvc.restorationIdentifier = "pvc" // * crucial!
        
        // give it an initial page
        let page = Pep(pepBoy: self.pep[0])
        pvc.setViewControllers([page], direction: .forward, animated: false)
        // give it a data source
        pvc.dataSource = self
        // stick it in the interface
        self.window!.rootViewController = pvc
        
        let proxy = UIPageControl.appearance()
        proxy.pageIndicatorTintColor = UIColor.red().withAlphaComponent(0.6)
        proxy.currentPageIndicatorTintColor = UIColor.red()
        proxy.backgroundColor = UIColor.yellow()
        
    }
    
    // similar to the previous example, but the knowledge of how to archive a Pep...
    // ... should reside in Pep, not here
    // so this time around, we save the Pep object itself
    // and assume that Pep is itself archivable (which it now is)
    
    func application(_ application: UIApplication, willEncodeRestorableStateWith coder: NSCoder) {
        let pvc = self.window!.rootViewController as! UIPageViewController
        let pep = pvc.viewControllers![0] as! Pep
        print("app delegate encoding \(pep)")
        coder.encode(pep, forKey:"pep")
    }
    
    func application(_ application: UIApplication, didDecodeRestorableStateWith coder: NSCoder) {
        let pep : AnyObject? = coder.decodeObject(forKey:"pep")
        print("app delegate decoding \(pep)")
        if let pep = pep as? Pep {
            let pvc = self.window!.rootViewController as! UIPageViewController
            pvc.setViewControllers([pep], direction: .forward, animated: false)
        }
    }
}

extension AppDelegate : UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let boy = (viewController as! Pep).boy
        let ix = self.pep.index(of:boy)! + 1
        if ix >= self.pep.count {
            return nil
        }
        return Pep(pepBoy: self.pep[ix])
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let boy = (viewController as! Pep).boy
        let ix = self.pep.index(of:boy)! - 1
        if ix < 0 {
            return nil
        }
        return Pep(pepBoy: self.pep[ix])
    }
    
    // if these methods are implemented, page indicator appears
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.pep.count
    }
    func presentationIndex(for pvc: UIPageViewController) -> Int {
        let page = pvc.viewControllers![0] as! Pep
        let boy = page.boy
        return self.pep.index(of:boy)!
    }
    
}
