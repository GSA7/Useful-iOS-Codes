import UIKit

class ZoomingImageViewController: UIViewController {
    private let scrollView = UIScrollView()
    private let imageView = UIImageView()
    private var image: UIImage { return imageView.image! }
    override var prefersStatusBarHidden: Bool { return true }
    convenience init(withImage image: UIImage) {
        self.init()
        view.addSubview(scrollView)
        view.backgroundColor = .lightGray
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        scrollView.addSubview(imageView)
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.frame
        imageView.frame = scrollView.frame
        scrollView.contentSize = imageView.frame.size
        scrollView.maximumZoomScale = {
            let imageRatio = image.size.height / image.size.width
            let viewRatio = scrollView.bounds.size.height / scrollView.bounds.size.width
            if imageRatio > viewRatio {
                return image.size.height / scrollView.bounds.size.height
            } else {
                return image.size.width / scrollView.bounds.size.width
            }
        }()
    }
}

extension ZoomingImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let currentZoomScaleToMax = scrollView.zoomScale / scrollView.maximumZoomScale
        let currentImageSize = CGSize(width: image.size.width * currentZoomScaleToMax, height: image.size.height * currentZoomScaleToMax)
        let size = CGSize(width: max(scrollView.frame.size.width, currentImageSize.width), height: max(scrollView.frame.size.height, currentImageSize.height))
        imageView.frame.size = size
        scrollView.contentSize = size
    }
}
