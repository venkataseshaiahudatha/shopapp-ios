//
//  APIInterface.swift
//  ShopClient
//
//  Created by Evgeniy Antonov on 10/23/17.
//  Copyright © 2017 Evgeniy Antonov. All rights reserved.
//

import Foundation

enum SortingValue: Int {
    case createdAt
    case name
    case popular
    
    static let allValues = [NSLocalizedString("SortingValue.CreatedAt", comment: String()),
                            NSLocalizedString("SortingValue.Name", comment: String()),
                            NSLocalizedString("SortingValue.Popular", comment: String())]
}

protocol APIInterface {
    // MARK: - shop
    func getShopInfo(callback: @escaping RepoCallback<Shop>)
    
    // MARK: - products
    func getProductList(perPage: Int, paginationValue: Any?, sortBy: SortingValue?, reverse: Bool, callback: @escaping RepoCallback<[Product]>)
    func getProduct(id: String, callback: @escaping RepoCallback<Product>)
    func searchProducts(perPage: Int, paginationValue: Any?, searchQuery: String, callback: @escaping RepoCallback<[Product]>)
    
    // MARK: - categories
    func getCategoryList(perPage: Int, paginationValue: Any?, sortBy: SortingValue?, reverse: Bool, callback: @escaping RepoCallback<[Category]>)
    func getCategoryDetails(id: String, perPage: Int, paginationValue: Any?, sortBy: SortingValue?, reverse: Bool, callback: @escaping RepoCallback<Category>)
    
    // MARK: - articles
    func getArticleList(perPage: Int, paginationValue: Any?, sortBy: SortingValue?, reverse: Bool, callback: @escaping RepoCallback<[Article]>)
    func getArticle(id: String, callback: @escaping RepoCallback<Article>)
    
    // MARK: - authentification
    func signUp(with email: String, firstName: String?, lastName: String?, password: String, phone: String?, callback: @escaping RepoCallback<Bool>)
    func login(with email: String, password: String, callback: @escaping RepoCallback<Bool>)
    func logout(callback: RepoCallback<Bool>)
    func isLoggedIn() -> Bool
    func resetPassword(with email: String, callback: @escaping RepoCallback<Bool>)
    func getCustomer(callback: @escaping RepoCallback<Customer>)
    
    // MARK: - payments
    func createCheckout(cartProducts: [CartProduct], callback: @escaping RepoCallback<Checkout>)
    func getCheckout(with checkoutId: String, callback: @escaping RepoCallback<Checkout>)
    func updateShippingAddress(with checkoutId: String, address: Address, callback: @escaping RepoCallback<Bool>)
    func updateCustomerDefaultAddress(with addressId: String, callback: @escaping RepoCallback<Bool>)
    func updateCustomerAddress(with address: Address, callback: @escaping RepoCallback<Bool>)
    func addCustomerAddress(with address: Address, callback: @escaping RepoCallback<String>)
    func deleteCustomerAddress(with addressId: String, callback: @escaping RepoCallback<Bool>)
    func getShippingRates(with checkoutId: String, callback: @escaping RepoCallback<[ShippingRate]>)
    func updateCheckout(with rate: ShippingRate, checkout: Checkout, callback: @escaping RepoCallback<Checkout>)
    func pay(with card: CreditCard, checkout: Checkout, billingAddress: Address, callback: @escaping RepoCallback<Bool>)
    
    // MARK: - orders
    func getOrderList(perPage: Int, paginationValue: Any?, callback: @escaping RepoCallback<[Order]>)
    func getOrder(id: String, callback: @escaping RepoCallback<Order>)
}