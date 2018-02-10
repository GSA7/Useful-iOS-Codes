import UIKit

class PresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let originFrame: CGRect
    
    init(originFrame: CGRect) {
        self.originFrame = originFrame
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from) as? SmallImageViewController,
            let toVC = transitionContext.viewController(forKey: .to) as? BigImageViewController,
            let image = toVC.imageView.image
            else {
                return
        }
        let containerView = transitionContext.containerView
        fromVC.imageView.isHidden = true
        let maskView = UIView(frame: containerView.frame)
        maskView.backgroundColor = .white
        containerView.addSubview(maskView)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        containerView.addSubview(imageView)
        let finalFrame = transitionContext.finalFrame(for: toVC)
        imageView.frame = originFrame
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            maskView.backgroundColor = .black
            imageView.frame = finalFrame
        }) { _ in
            containerView.addSubview(toVC.view)
            fromVC.imageView.isHidden = false
            maskView.removeFromSuperview()
            imageView.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
}

extension SmallImageViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController)
        -> UIViewControllerAnimatedTransitioning? {
            return PresentAnimationController(originFrame: imageView.frame)
    }
}
