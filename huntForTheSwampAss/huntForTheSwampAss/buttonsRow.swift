
import UIKit

class buttonsRow: UIView {

    //MARK: init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let button = UIButton(type: .Custom) as UIButton
        button.frame = CGRectMake(0, 0, 90, 90)
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.backgroundColor = UIColor.blueColor()
        button.addTarget(self, action: #selector(buttonsRow.circlePressed(_:)), forControlEvents: .TouchDown)
        button.setImage(UIImage(named: "test"), forState: .Normal)
        addSubview(button)
    }
    
    override func intrinsicContentSize() -> CGSize {
        return CGSize(width: 300, height: 90)
    }
    
    func circlePressed(button: UIButton){
        print("okei")
    }

}
