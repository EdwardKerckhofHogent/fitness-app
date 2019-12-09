import Foundation
import Apollo
import SwiftKeychainWrapper

class Network {
  static let shared = Network()
  static let key = "accessToken"
    
  private(set) lazy var apollo = ApolloClient(url: URL(string: "http://localhost:4000/graphql")!)
    
    static func getAccessToken() -> String? {
        return KeychainWrapper.standard.string(forKey: key)
    }
    
    static func logUserOut() {
        KeychainWrapper.standard.removeObject(forKey: key)
    }
}
