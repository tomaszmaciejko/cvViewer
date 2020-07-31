import UIKit

final class ApplicationCoordinator: Coordinator {

    private let coordinatorFactory: CoordinatorFactory
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController,
         coordinatorFactory: CoordinatorFactory) {
        self.navigationController = navigationController
        self.coordinatorFactory = coordinatorFactory
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        super.start()
        
        runMainFlow()
    }
    
    private func runMainFlow() {
        let coordinator = coordinatorFactory.makeResumesCoordinator(navController: navigationController)
        addDependency(coordinator)
        coordinator.start()
    }
    
}
