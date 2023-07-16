import UIKit

class ViewController: UIViewController {
    
    private lazy var squareView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 10
        return view
    }()
    
    private var animator: UIDynamicAnimator!
    private var snapBehavior: UISnapBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(squareView)
        squareView.center = view.center

        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tapGesture)
        
        animator = UIDynamicAnimator(referenceView: view)
        let collisionBehavior = UICollisionBehavior(items: [squareView])
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        let itemBehavior = UIDynamicItemBehavior(items: [squareView])
        itemBehavior.angularResistance = 2.0
        
        animator.addBehavior(collisionBehavior)
        animator.addBehavior(itemBehavior)
        
        snapBehavior = UISnapBehavior(item: squareView, snapTo: view.center)
        snapBehavior.damping = 0.6
    }
    
    @objc private func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        let tapLocation = gestureRecognizer.location(in: view)
        moveView(to: tapLocation)
    }
    
    private func moveView(to point: CGPoint) {
        animator.removeBehavior(snapBehavior)
        snapBehavior = UISnapBehavior(item: squareView, snapTo: point)
        snapBehavior.damping = 0.6
        animator.addBehavior(snapBehavior)
    }
}
