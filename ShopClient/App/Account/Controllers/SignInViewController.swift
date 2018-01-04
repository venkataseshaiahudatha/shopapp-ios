//
//  SignInViewController.swift
//  ShopClient
//
//  Created by Evgeniy Antonov on 11/14/17.
//  Copyright © 2017 Evgeniy Antonov. All rights reserved.
//

import RxSwift

class SignInViewController: BaseViewController<SignInViewModel> {
    @IBOutlet weak var emailTextFieldView: InputTextFieldView!
    @IBOutlet weak var passwordTextFieldView: InputTextFieldView!
    @IBOutlet weak var forgotButton: UIButton!
    @IBOutlet weak var signInButton: BlackButton!
    
    var delegate: AuthenticationProtocol!
    
    override func viewDidLoad() {
        viewModel = SignInViewModel()
        viewModel.delegate = delegate
        super.viewDidLoad()
        
        setupViews()
        setupViewModel()
    }
    
    private func setupViews() {
        addCloseButton()
        title = NSLocalizedString("ControllerTitle.SignIn", comment: String())
        emailTextFieldView.placeholder = NSLocalizedString("Placeholder.Email", comment: String()).uppercased()
        passwordTextFieldView.placeholder = NSLocalizedString("Placeholder.Password", comment: String()).uppercased()
        forgotButton.setTitle(NSLocalizedString("Button.Forgot", comment: String()), for: .normal)
        signInButton.setTitle(NSLocalizedString("Button.SignIn", comment: String()).uppercased(), for: .normal)
    }
    
    private func setupViewModel() {
        emailTextFieldView.textField.rx.text.map({ $0 ?? String() })
            .bind(to: viewModel.emailText)
            .disposed(by: disposeBag)
        
        passwordTextFieldView.textField.rx.text.map({ $0 ?? String() })
            .bind(to: viewModel.passwordText)
            .disposed(by: disposeBag)
        
        viewModel.emailErrorMessage
            .subscribe(onNext: { [weak self] errorMessage in
                self?.emailTextFieldView.errorMessage = errorMessage
            })
            .disposed(by: disposeBag)
        
        viewModel.passwordErrorMessage
            .subscribe(onNext: { [weak self] errorMessage in
                self?.passwordTextFieldView.errorMessage = errorMessage
            })
            .disposed(by: disposeBag)
        
        signInButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.view.endEditing(true)
            })
            .disposed(by: disposeBag)
        
        signInButton.rx.tap
            .bind(to: viewModel.loginPressed)
            .disposed(by: disposeBag)
        
        viewModel.signInButtonEnabled
            .subscribe(onNext: { [weak self] enabled in
                self?.signInButton.isEnabled = enabled
            })
            .disposed(by: disposeBag)
        
        viewModel.signInSuccess.asObservable()
            .subscribe(onNext: { [weak self] success in
                if success {
                    self?.dismiss(animated: true)
                }
            })
            .disposed(by: disposeBag)
    }
}