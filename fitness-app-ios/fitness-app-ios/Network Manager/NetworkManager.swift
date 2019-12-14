import Foundation
import Apollo
import ApolloWebSocket
import SwiftKeychainWrapper

class NetworkManager {
    static let shared = NetworkManager()
    
    private(set) lazy var apollo = ApolloClient(url: URL(string: Constants.graphEndpoint)!)
    
    var loggedInUser: User?
    
    private init (){
    }
    
    func setApolloClient(accessToken: String?) {
        if let accessToken = accessToken {
            self.apollo = {
            let authPayloads = ["Authorization": "Bearer \(accessToken)"]
            let configuration = URLSessionConfiguration.default
            configuration.httpAdditionalHeaders = authPayloads
            return ApolloClient(networkTransport: HTTPNetworkTransport(url: URL(string: Constants.graphEndpoint)!, session: URLSession.init(configuration: configuration)))
            }()
        } else {
            self.apollo = {
                return ApolloClient(url: URL(string: Constants.graphEndpoint)!)
            }()
        }
    }
    
    var currentAuthToken: String? = {
        return KeychainWrapper.standard.string(forKey: Constants.accessTokenKey)
    }()

    func isLoggedIn() -> Bool {
       if currentAuthToken != nil {
           return true
       }
       return false
    }
    
    func logUserIn(accessToken: String) {
        KeychainWrapper.standard.set(accessToken, forKey: Constants.accessTokenKey)
        setApolloClient(accessToken: accessToken)
    }
    
    func logUserOut() {
        KeychainWrapper.standard.removeObject(forKey: Constants.accessTokenKey)
        setApolloClient(accessToken: nil)
        loggedInUser = nil
    }
    
    func getLoggedInUser() -> User? {
        if isLoggedIn() {
            return loggedInUser
        } else {
            return nil
        }
    }
}
