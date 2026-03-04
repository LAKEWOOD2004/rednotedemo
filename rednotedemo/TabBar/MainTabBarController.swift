import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarAppearance()
        setupViewControllers()
    }
    
    private func setupTabBarAppearance() {
        tabBar.backgroundColor = .white
        tabBar.tintColor = UIColor(red: 0.99, green: 0.17, blue: 0.33, alpha: 1.0) // xhsRed
        tabBar.unselectedItemTintColor = .gray
    }
    
    private func setupViewControllers() {
        // 1. 首页 (已经完成瀑布流那个)
        let homeVC = createNavController(viewController: HomeViewController(),
                                         title: "",
                                         imageName: "sparkles",
                                         selectedImageName: "sparkles")
        
        // 2. 视频 (新改的)
        let videoVC = createNavController(viewController: VideoViewController(),
                                          title: "",
                                          imageName: "play.rectangle.on.rectangle",
                                          selectedImageName: "play.rectangle.on.rectangle.fill")
        
        // 3. 发布
        let postVC = createNavController(viewController: UIViewController(),
                                         title: "",
                                         imageName: "plus.rectangle.fill",
                                         selectedImageName: "plus.rectangle.fill")
        
        // 4. 消息
        let messageVC = createNavController(viewController: UIViewController(),
                                            title: "",
                                            imageName: "bubble.left.and.bubble.right",
                                            selectedImageName: "bubble.left.and.bubble.right.fill")
        
        // 5. 我
        let meVC = createNavController(viewController: UIViewController(),
                                       title: "",
                                       imageName: "person",
                                       selectedImageName: "person.fill")
        
        viewControllers = [homeVC, videoVC, postVC, messageVC, meVC]
    }
    
    private func createNavController(viewController: UIViewController,
                                     title: String,
                                     imageName: String,
                                     selectedImageName: String) -> UINavigationController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = UIImage(systemName: imageName)
        viewController.tabBarItem.selectedImage = UIImage(systemName: selectedImageName)
        //viewController.view.backgroundColor = .systemBackground
        return UINavigationController(rootViewController: viewController)
    }
}
