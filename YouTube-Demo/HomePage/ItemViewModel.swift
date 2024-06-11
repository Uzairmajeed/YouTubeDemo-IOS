//  ItemViewModel.swift
//  YouTube-Demo
//
//  Created by Uzair Majeed on 09/06/24.
//

import Foundation
import Alamofire
import Combine

class ItemViewModel: ObservableObject {
    
    // Observable property to hold the fetched items
    @Published var items: [Item] = []

    // Property to store cancellables for Combine subscriptions
    public var cancellables: Set<AnyCancellable> = []

    func fetchData() {
        // Example URL for your API endpoint
        let apiUrl = "https://rapi.ifood.tv/recipes.php?searchType=new-qid&keys=33769&appId=4&siteId=1095&auth-token=1212551&version=sv6.0&sort_type=&order=1&deviceModel=&country=US&rowType=new-qid&gridstyle=flat-movie&dltype=1&akp=2411-76947."
        
        AF.request(apiUrl).responseDecodable(of: ItemsResponse.self) { response in
            switch response.result {
            case .success(let data):
                self.items = data.results
            case .failure(let error):
                print("Error fetching data: \(error)")
            }
        }
    }
}
