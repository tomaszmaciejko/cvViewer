import UIKit

final class AnyCoordinatorFactory: CoordinatorFactory {
    public func makeResumesCoordinator(navController: UINavigationController) -> Coordinator {
        let coordinator = ResumeCoordinator(navigationController: navController, factory: AnyModuleFactory())
        return coordinator
    }
    
}
