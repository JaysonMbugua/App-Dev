import Foundation
import SwiftUI

class BusinessListViewModel: ObservableObject {
    @Published var searchTerm: String = ""
    @Published var radius: Int = 1
    
    @Published var businesses: [Business] = []
    @Published var highestRatedId: String? = nil
    
    @Published var errorMessage: String = ""
    @Published var showError: Bool = false
    @Published var isLoading: Bool = false
    
    func getBestRestaurantId(Businesses: [Business]) -> String?{
        var highest = Businesses[0]
        for i in businesses{
            if (i.rating > highest.rating){
                highest = i
            }
        }
        return highest.id
    }
    
    func getPlaces() {
        // MARK: Add logic to clear businesses array and return from function here
        
        if searchTerm == ""{
            businesses.removeAll()
            return
        }
        
        YelpService.getBusinesses(term: searchTerm, radius: radius) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                
                switch result {
                case .success(let businesses):
                    self.businesses = businesses
                    // self.highestRatedId = self.getBestRestaurantId(businesses: businesses)
                case .failure(let error):
                    self.errorMessage = error.rawValue
                    self.showError = true
                }
            }
        }
    }
    
    
    
    // MARK: Write your function here
}
