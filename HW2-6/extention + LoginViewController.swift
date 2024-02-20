//
//  extention + LoginViewController.swift
//  HW2-6
//
//  Created by Pavel Dolgopolov on 19.02.2024.
//

import UIKit

// MARK: - IB Setup
extension LoginViewController {
    
    //MARK: - Public Methods
    // меняем цвет фона в зависимости от темы
    func setupView() {
        view.backgroundColor = self.traitCollection.userInterfaceStyle == .light ?
            UIColor(red: 0.957, green: 0.957, blue: 0.969, alpha: 1.0) :
            UIColor.systemBackground
    }
    
    func setupActionKeyboard() {
        // Подписываемся на уведомления о появлении и исчезновении клавиатуры
        NotificationCenter.default.addObserver(
            self, selector: #selector(keyboardShow(_:)),
            name: UIResponder.keyboardWillShowNotification, object: nil
        )
        
        NotificationCenter.default.addObserver(
            self, selector: #selector(keyboardHide(_:)),
            name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // если появилась клавиатура и ландшафтная ориентация,
    // то сдвигаемся вверх на 80 поинтов
    // если портретная то возвращаемся
     @objc func keyboardShow(_ notification: Notification) {
        
        self.mainStackCenterY.constant = UIDevice.current.orientation.isLandscape ? -80 : 0
        self.view.layoutIfNeeded() // принудительно обновляем макет
    }
    
    // сбрасываем изменения констрейнта, если клавиатура скрылась
    @objc func keyboardHide(_ notification: Notification) {
        
        if self.mainStackCenterY.constant != 0 {
            self.mainStackCenterY.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - Private Methods
     func setSettingsTextField(textField:  UITextField!, secureText: Bool = false) {
 
        textField.autocorrectionType = .no //автокоррекция отключена
        textField.smartQuotesType = .no //замена типа кавычек
        textField.smartDashesType = .no //замена тире
        textField.smartInsertDeleteType = .no //авто уд./доб. пробелов
        textField.keyboardType = .asciiCapable // отключаем смайлики
        //тип контента - ввод одноразового кода
        textField.textContentType = .oneTimeCode
        //скрытые символы при вводе
        textField.isSecureTextEntry = secureText
        
        //бар, который отображается над клавиатурой, nil - скрываем.
        //Может не скрываться, если isSecureTextEntry = false и
        //textContentType не равно .oneTimeCode и при не заданном keyboardType = .asciiCapable
        textField.inputAccessoryView = nil
        
         setColorTextField(textField: textField)
    }
    
    // меняем цвет рамки в зависимости от темы
    func setColorTextField(textField:  UITextField!) {
        if self.traitCollection.userInterfaceStyle == .light {
            // нужно задать остальные параметры, чтобы цвет обновился
            textField.layer.borderColor = UIColor.systemGray4.cgColor
            textField.layer.borderWidth = 1.0
            textField.layer.cornerRadius = 5.0
        } else {
            textField.layer.borderColor = UIColor.link.cgColor
            textField.layer.borderWidth = 1.0
            textField.layer.cornerRadius = 5.0
        }
    }
}


