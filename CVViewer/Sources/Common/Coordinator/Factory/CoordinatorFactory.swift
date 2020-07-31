import UIKit

protocol CoordinatorFactory {
    func makeResumesCoordinator(navController: UINavigationController) -> Coordinator
}
