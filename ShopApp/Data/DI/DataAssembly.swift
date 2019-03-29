//
//  DataAssembly.swift
//  ShopApp
//
//  Created by Mykola Voronin on 2/19/18.
//  Copyright © 2018 RubyGarage. All rights reserved.
//

import Swinject
import ShopApp_Gateway
import ShopApp_Shopify

class DataAssembly: Assembly {
    func assemble(container: Container) {
        
        // MARK: - Data
        
        container.register(DAO.self) { _ in
            return CoreDataDAO()
            }
            .inObjectScope(.container)
        
        // MARK: - Repositories
        
        container.register(API.self) { _ in
            return ShopifyAPI(apiKey: "62761bc137e3dac4c66d1d1a93d8dab3",
                              shopDomain: "porganicworld.myshopify.com",
                              adminApiKey: "1e5f1c6facb67ef0bf9e0c4af642d192",
                              adminPassword: "5c3061bb2e053642fc1422409ccbb89e",
                              applePayMerchantId: "APPLE PAY MERCHANT ID")
            }
            .inObjectScope(.container)
        
        container.register(ArticleRepository.self) { r in
            return ShopAppArticleRepository(api: r.resolve(API.self)!)
            }
            .inObjectScope(.container)
        
        container.register(AuthentificationRepository.self) { r in
            return ShopAppAuthentificationRepository(api: r.resolve(API.self)!)
            }
            .inObjectScope(.container)
        
        container.register(CartRepository.self) { r in
            return ShopAppCartRepository(dao: r.resolve(DAO.self)!)
            }
            .inObjectScope(.container)
        
        container.register(CategoryRepository.self) { r in
            return ShopAppCategoryRepository(api: r.resolve(API.self)!)
            }
            .inObjectScope(.container)
        
        container.register(CustomerRepository.self) { r in
            return ShopAppCustomerRepository(api: r.resolve(API.self)!)
            }
            .inObjectScope(.container)
        
        container.register(OrderRepository.self) { r in
            return ShopAppOrderRepository(api: r.resolve(API.self)!)
            }
            .inObjectScope(.container)
        
        container.register(PaymentsRepository.self) { r in
            return ShopAppPaymentsRepository(api: r.resolve(API.self)!)
            }
            .inObjectScope(.container)
        
        container.register(ProductRepository.self) { r in
            return ShopAppProductRepository(api: r.resolve(API.self)!)
            }
            .inObjectScope(.container)
        
        container.register(ShopRepository.self) { r in
            return ShopAppShopRepository(api: r.resolve(API.self)!)
            }
            .inObjectScope(.container)
    }
}
