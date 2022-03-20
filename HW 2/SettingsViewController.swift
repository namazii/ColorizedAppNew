//  Created by Nazar Tkachenko on 18.03.2022.

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var colorView: UIView!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    var mainViewBackGround: UIColor!
    var delegate: SettingsViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMainColorToSettings()
        colorView.layer.cornerRadius = 15
        
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        
        setColor()
        setValue(for: redLabel, greenLabel, blueLabel)
    }
    
    @IBAction func conveyСolorButton(_ sender: UIButton) {
        delegate.setMainBackGround(for: colorView.backgroundColor)
    }
    
    
    @IBAction func rgbTextField(_ sender: UITextField) {
        textFieldDidEndEditing(sender)
    }
    
    @IBAction func rgbSlider(_ sender: UISlider) {
        setColor()
        switch sender {
        case redSlider:
            redLabel.text = string(from: redSlider)
            redTextField.text = string(from: redSlider)
        case greenSlider:
            greenLabel.text = string(from: greenSlider)
            greenTextField.text = string(from: greenSlider)
        default:
            blueLabel.text = string(from: blueSlider)
            blueTextField.text = string(from: blueSlider)
        }
    }
    
    private func setColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    private func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redLabel:
                redLabel.text = string(from: redSlider)
                redTextField.text = string(from: redSlider)
            case greenLabel:
                greenLabel.text = string(from: greenSlider)
                greenTextField.text = string(from: greenSlider)
            default:
                blueLabel.text = string(from: blueSlider)
                blueTextField.text = string(from: blueSlider)
            }
        }
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    private func setMainColorToSettings() {
        let convert = convertUIColor(colorToConvert: mainViewBackGround)
        redSlider.value = Float(convert["red"] ?? 0)
        greenSlider.value = Float(convert["green"] ?? 0)
        blueSlider.value = Float(convert["blue"] ?? 0)
    }
    private func convertUIColor(colorToConvert: UIColor)-> [String: CGFloat] {
        
        var red:CGFloat = 0
        var green:CGFloat = 0
        var blue:CGFloat = 0
        var color: [String: CGFloat] = [:]
        
        colorToConvert.getRed(&red, green: &green, blue: &blue, alpha: nil)
        
        if(red < 0) {red = 0}
        
        if(green < 0) {green = 0}
        
        if(blue < 0) {blue = 0}
        
        if(red > 255) {red = 255}
        
        if(green > 255) {green = 255}
        
        if(blue > 255) {blue = 255}
        
        color["red"] = red
        color["green"] = green
        color["blue"] = blue
        
        return color
    }
}
//MARK - UITextFieldDelegate
extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if let currentValue = Float(text) {
            switch textField {
            case redTextField:
                redSlider.value = currentValue
            case greenTextField:
                greenSlider.value = currentValue
            default:
                blueSlider.value = currentValue
            }
            setColor()
            setValue(for: redLabel, greenLabel, blueLabel)
        }  else {
            showAlert(title: "Wrong format!", message: "Please enter correct value") }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
extension SettingsViewController {
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

