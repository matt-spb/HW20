import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var acivityIndIcator: UIActivityIndicatorView!
    
    @IBAction func generateAction(_ sender: UIButton) {
        var password = ""
        let passLength = Int.random(in: 3...4)
        let availableSymbols = (password.digits + password.letters).map { String($0) }

        for _ in 1...passLength {
            let randomIndex = Int.random(in: 0..<availableSymbols.count)
            let char = availableSymbols[randomIndex]
            password += char
        }
        
        generateButton.isUserInteractionEnabled = false
        textField.text = password
        unlockPassword(for: password)
    }
    
    private func unlockPassword(for password: String) {
        acivityIndIcator.isHidden = false
        acivityIndIcator.startAnimating()
        setDefault()
        
        DispatchQueue.global(qos: .userInteractive).async {
            bruteForce(passwordToUnlock: password, completion: { result in
                DispatchQueue.main.async {
                    self.acivityIndIcator.stopAnimating()
                    self.textField.isSecureTextEntry = false
                    self.label.text = result
                    self.generateButton.isUserInteractionEnabled = true
                }
            })
        }
    }
    
    private func setDefault() {
        textField.isSecureTextEntry = true
        label.text = "unlocking..."
    }
    
    var isBlack: Bool = false {
        didSet {
            if isBlack {
                self.view.backgroundColor = .black
            } else {
                self.view.backgroundColor = .white
            }
        }
    }
    
    @IBAction func onBut(_ sender: Any) {
        isBlack.toggle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.isSecureTextEntry = true
        acivityIndIcator.isHidden = true
    }
}

