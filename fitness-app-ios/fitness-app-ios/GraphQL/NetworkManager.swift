import Foundation
import Apollo
import ApolloWebSocket

class NetworkManager {
    static let shared = NetworkManager()
    
    let graphEndpoint = "http://localhost:4000/graphql"
    var apolloClient : ApolloClient?
    
    private init (){
    }
    
    func setApolloClient(accessToken: String?){
        if let accessToken = accessToken {
            print("ACCESS TOKEN SET \(accessToken)")
            self.apolloClient = {
            let authPayloads = ["Authorization": "Bearer \(accessToken)"]
            let configuration = URLSessionConfiguration.default
            configuration.httpAdditionalHeaders = authPayloads
            let endpointURL = URL(string: graphEndpoint)!
            return ApolloClient(networkTransport: HTTPNetworkTransport(url: endpointURL, session: URLSession.init(configuration: configuration)))
            }()
        } else {
            self.apolloClient = {
            let endpointURL = URL(string: graphEndpoint)!
            return ApolloClient(networkTransport: HTTPNetworkTransport(url: endpointURL))
            }()
        }
    }
}
