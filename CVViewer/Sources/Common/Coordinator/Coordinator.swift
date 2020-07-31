import UIKit

protocol Coordinate {
    func start()
}

class Coordinator: NSObject, Coordinate {
    
    private var navigationController: UINavigationController
    
    private var childCoordinators: [Coordinator] = []
    weak var parentCoordinator: Coordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
    }
    
    public func addDependency(_ coordinator: Coordinator) {
        for element in childCoordinators where element === coordinator {
            return
        }
        childCoordinators.append(coordinator)
        
        coordinator.parentCoordinator = self
    }
    
    public func removeDependency(_ coordinator: Coordinator?) {
        guard
            childCoordinators.isEmpty == false,
            let coordinator = coordinator
            else { return }
        
        for (index, element) in childCoordinators.enumerated() where element === coordinator {
            childCoordinators.remove(at: index)
        }
    }
    
    public func removeAllDependencies() {
        for coordinator in childCoordinators {
            removeDependency(coordinator)
        }
        childCoordinators.removeAll()
        navigationController.popToRootViewController(animated: true)
    }
    
}
