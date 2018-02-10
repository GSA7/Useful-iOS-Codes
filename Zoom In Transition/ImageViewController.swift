import UIKit

class BaseImageViewController: UIViewController {
    let imageView = UIImageView(image: UIImage(named: "some image"))
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.frame = frameForImageView()
    }
    func frameForImageView() -> CGRect {
        return view.frame
    }
}

class SmallImageViewController: BaseImageViewController {
    override func frameForImageView() -> CGRect {
        return CGRect(x: 20, y: 30, width: view.frame.width/4, height: view.frame.width/4)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
    }
    @objc func tap() {
        let vc = BigImageViewController()
        
        // important
        vc.transitioningDelegate = self
        present(vc, animated: true)
    }
}

class BigImageViewController: BaseImageViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap)))
    }
    @objc func tap() {
        dismiss(animated: true)
    }
}
