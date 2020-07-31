import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?

    private lazy var applicationCoordinator: Coordinator = makeCoordinator()
    
    private lazy var rootController: UINavigationController = {
        return UINavigationController(rootViewController: UIViewController())
    }()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootController
        window?.makeKeyAndVisible()
        applicationCoordinator.start()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {}

    func applicationDidEnterBackground(_ application: UIApplication) {}

    func applicationWillEnterForeground(_ application: UIApplication) {}

    func applicationDidBecomeActive(_ application: UIApplication) {}

    func applicationWillTerminate(_ application: UIApplication) {}
    
    private func makeCoordinator() -> Coordinator {
        
        return ApplicationCoordinator(
            navigationController: rootController,
            coordinatorFactory: AnyCoordinatorFactory()
        )
    }

}
