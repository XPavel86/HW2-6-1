//
//  ViewController.swift
//  HW2-6
//
//  Created by Pavel Dolgopolov on 17.02.2024.
//

import UIKit

final class LoginViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - IBOutlet
    @IBOutlet var mainStackCenterY: NSLayoutConstraint!
    
    @IBOutlet var userNameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    
    @IBOutlet var loginButton: UIButton!
    
    @IBOutlet var remindNameButton: UIButton!
    @IBOutlet var remindPasswordButton: UIButton!
    
    //MARK: - Private Properties
    private let user = "User"
    private let password = "123"
    
    // MARK: - Initializers
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordField.delegate = self
        userNameField.delegate = self
        
        passwordField.setSetting()
        userNameField.setSetting()
        
        passwordField.isSecureTextEntry = true
        
        loginButton.layer.cornerRadius = 5 //скругляеем кнопку
    }
    
    override func viewWillLayoutSubviews() {
        
        setViewColor()
        setupActionKeyboard()
        
    }
    
    // MARK: - Overrides Methods
    //событие перед переходом на WelcomeViewController, проверяем логин
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        return checkСredentials()
    }
    
    // скрываем клавиатуру при тапе на экране
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    // передаем текст в welcomeView
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let welcomeView = segue.destination as? WelcomeViewController
        
        welcomeView?.greetingText = userNameField.text
    }
    
    // MARK: - IBAction
    // показываем подсказки логина / пароля
    @IBAction func remindUserOrPassword(sender: UIButton) {
        sender == remindNameButton ?
        showAlert(
            withTitle: "Oops!",
            andMessage: "Your name is \(user) 😉",
            clearFields: false
        ) :
        showAlert(
            withTitle: "Oops!",
            andMessage: "Your password is \(password) 😉",
            clearFields: false
        )
    }
    
    // обрабатываем закрытие welcomeView
    //
    @IBAction func unwind(for segue: UIStoryboardSegue ) {
        userNameField.text = ""
        passwordField.text = ""
    }
    
    // MARK: - Public Methods
    //  событие клавиатуры при нажатии на enter
    // для работы нужно присвоить делегат и добавить протокол
    // UITextFieldDelegate и textField.delegate = self
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if checkСredentials() { // переход по сегвею mainSegue
            performSegue(withIdentifier: "mainSegue", sender: self)
        }
        return true
    }
    
    // MARK: - Private Methods

    // проверяем логин / пароль
    private func checkСredentials() -> Bool {
        guard userNameField.text != "" else { userNameField.alarm()
            return false
        }
        
        guard passwordField.text != "" else { passwordField.alarm()
            return false
        }

        guard userNameField.text == user, passwordField.text == password else {
            showAlert(
                withTitle: "Invalid login or password!",
                andMessage: "Please, enter correct login and password",
                clearFields: true
            )
            return false
        }
        return true
    }
    
    // объявление алерта
    private func showAlert(
        withTitle title: String,
        andMessage message: String,
        clearFields: Bool){
          
            let alert = UIAlertController(
                title: title, message: message, preferredStyle: .alert
            )
            let okAction = UIAlertAction(title: "OK", style: .default) {  _ in
                if clearFields {
                   // self.userNameField.text = ""
                    self.passwordField.text = ""
                }
            }
            alert.addAction(okAction)
            present(alert, animated: true)
        }
}

extension UITextField {
    
    func setBorderColor() {
        layer.borderColor = self.traitCollection.userInterfaceStyle == .light ? UIColor.systemGray4.cgColor : UIColor.link.cgColor
        
        layer.borderWidth = 1.0
        layer.cornerRadius = 5.0
    }
    
    func setSetting() {
        
        //delegate = self // без этого кнопка enter не будет работать
        autocorrectionType = .no //автокоррекция отключена
        smartQuotesType = .no //замена типа кавычек
        smartDashesType = .no //замена тире
        smartInsertDeleteType = .no //авто уд./доб. пробелов
        keyboardType = .asciiCapable // отключаем смайлики
        //тип контента - ввод одноразового кода
        textContentType = .oneTimeCode
        //скрытые символы при вводе
        //isSecureTextEntry = secureText
        
        //бар, который отображается над клавиатурой, nil - скрываем.
        //Может не скрываться, если isSecureTextEntry = false и
        //textContentType не равно .oneTimeCode и при не заданном keyboardType = .asciiCapable
        inputAccessoryView = nil
        
        setBorderColor()
    }
    
    func alarm() {
        
        let feedbackGenerator = UINotificationFeedbackGenerator()
        feedbackGenerator.notificationOccurred(.error) // вибр
        
        self.becomeFirstResponder() // фокус
        // цвет рамки с анимацией
        UIView.animate(withDuration: 0.5) {
            self.layer.borderColor = UIColor.red.cgColor
            self.layer.borderWidth = 1.0
            self.layer.cornerRadius = 5.0
        }
        // возврат к исходному цвету
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            UIView.animate(withDuration: 0.5) {
                self.setBorderColor()
            }
        }
    }
}
