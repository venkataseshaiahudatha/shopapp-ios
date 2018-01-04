//
//  AddressFormViewModel.swift
//  ShopClient
//
//  Created by Evgeniy Antonov on 11/21/17.
//  Copyright © 2017 Evgeniy Antonov. All rights reserved.
//

import RxSwift

typealias AddressFormCompletion = (_ address: Address, _ isDefaultAddress: Bool) -> ()

class AddressFormViewModel: BaseViewModel {
    var countryText = Variable<String>("")
    var firstNameText = Variable<String>("")
    var lastNameText = Variable<String>("")
    var addressText = Variable<String>("")
    var addressOptionalText = Variable<String>("")
    var cityText = Variable<String>("")
    var stateText = Variable<String>("")
    var zipText = Variable<String>("")
    var phoneText = Variable<String>("")
    var useDefaultShippingAddress = Variable<Bool>(false)
    var addressSubmitted = PublishSubject<()>()

    
    var address: Address?
    var completion: AddressFormCompletion?
    
    private var requiredTextFields: [Observable<String>] {
        get {
            return [countryText, firstNameText, lastNameText, addressText, cityText, zipText, phoneText].map({ $0.asObservable() })
        }
    }
    
    var isAddressValid: Observable<Bool> {
        return Observable.combineLatest(requiredTextFields, { (textFields) in
            return textFields.map({ $0.isEmpty == false }).filter({ $0 == false }).count == 0
        })
    }
    
    var submitTapped: AnyObserver<()> {
        return AnyObserver { [weak self] event in
            self?.submitAction()
        }
    }
    
    var useDefaultAddressTapped: AnyObserver<()> {
        return AnyObserver { [weak self] event in
            self?.updateCheckbox()
        }
    }
    
    // MARK: - public
    public func updateFields() {
        countryText.value = address?.country ?? String()
        firstNameText.value = address?.firstName ?? String()
        lastNameText.value = address?.lastName ?? String()
        addressText.value = address?.address ?? String()
        addressOptionalText.value = address?.secondAddress ?? String()
        cityText.value = address?.city ?? String()
        stateText.value = address?.state ?? String()
        zipText.value = address?.zip ?? String()
        phoneText.value = address?.phone ?? String()
    }
    
    // MARK: - private
    private func submitAction() {
        completion?(getAddress(), useDefaultShippingAddress.value)
        addressSubmitted.onNext()
    }
    
    private func updateCheckbox() {
        useDefaultShippingAddress.value = !useDefaultShippingAddress.value
    }
 
    private func getAddress() -> Address {
        let address = Address()
        address.id = self.address?.id ?? String()
        address.country = countryText.value.trimmingCharacters(in: .whitespaces)
        address.firstName = firstNameText.value.trimmingCharacters(in: .whitespaces)
        address.lastName = lastNameText.value.trimmingCharacters(in: .whitespaces)
        address.address = addressText.value.trimmingCharacters(in: .whitespaces)
        address.secondAddress = addressOptionalText.value.trimmingCharacters(in: .whitespaces)
        address.city = cityText.value.trimmingCharacters(in: .whitespaces)
        address.state = stateText.value.trimmingCharacters(in: .whitespaces)
        address.zip = zipText.value.trimmingCharacters(in: .whitespaces)
        address.phone = phoneText.value.trimmingCharacters(in: .whitespaces)

        return address
    }
}