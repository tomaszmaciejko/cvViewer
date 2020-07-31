import UIKit

final class ResumeCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    private let moduleFactory: ResumesModuleFactory
    
    init(navigationController: UINavigationController,
         factory: ResumesModuleFactory) {
        self.navigationController = navigationController
        self.moduleFactory = factory
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        super.start()
        
        runResumeListFlow()
    }
    
    private func runResumeListFlow() {
        let resumeListModule = moduleFactory.makeResumeListModule()
        let resumeListVC = resumeListModule.toPresent()
        
        resumeListModule.onNext = { [weak self] gist in
            self?.runResumesDetailsFlow(with: gist)
        }
        
        navigationController.setViewControllers([resumeListVC], animated: false)
    }
    
    private func runResumesDetailsFlow(with gistId: String) {
        let resumeDetailModule = moduleFactory.makeResumeDetailModule(with: gistId)
        let resumeDetailVC = resumeDetailModule.toPresent()

        navigationController.pushViewController(resumeDetailVC, animated: true)
    }
}
