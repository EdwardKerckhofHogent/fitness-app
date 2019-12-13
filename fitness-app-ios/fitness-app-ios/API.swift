//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public struct UserInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(password: String, email: String, repeatPassword: Swift.Optional<String?> = nil) {
    graphQLMap = ["password": password, "email": email, "repeatPassword": repeatPassword]
  }

  public var password: String {
    get {
      return graphQLMap["password"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "password")
    }
  }

  public var email: String {
    get {
      return graphQLMap["email"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "email")
    }
  }

  public var repeatPassword: Swift.Optional<String?> {
    get {
      return graphQLMap["repeatPassword"] as? Swift.Optional<String?> ?? Swift.Optional<String?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "repeatPassword")
    }
  }
}

public final class LoginMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    mutation login($input: UserInput!) {
      login(input: $input) {
        __typename
        user {
          __typename
          id
        }
        errors {
          __typename
          path
          message
        }
        accessToken
      }
    }
    """

  public let operationName = "login"

  public var input: UserInput

  public init(input: UserInput) {
    self.input = input
  }

  public var variables: GraphQLMap? {
    return ["input": input]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("login", arguments: ["input": GraphQLVariable("input")], type: .object(Login.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(login: Login? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "login": login.flatMap { (value: Login) -> ResultMap in value.resultMap }])
    }

    public var login: Login? {
      get {
        return (resultMap["login"] as? ResultMap).flatMap { Login(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "login")
      }
    }

    public struct Login: GraphQLSelectionSet {
      public static let possibleTypes = ["UserResponse"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("user", type: .object(User.selections)),
        GraphQLField("errors", type: .list(.nonNull(.object(Error.selections)))),
        GraphQLField("accessToken", type: .scalar(String.self)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(user: User? = nil, errors: [Error]? = nil, accessToken: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "UserResponse", "user": user.flatMap { (value: User) -> ResultMap in value.resultMap }, "errors": errors.flatMap { (value: [Error]) -> [ResultMap] in value.map { (value: Error) -> ResultMap in value.resultMap } }, "accessToken": accessToken])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var user: User? {
        get {
          return (resultMap["user"] as? ResultMap).flatMap { User(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "user")
        }
      }

      public var errors: [Error]? {
        get {
          return (resultMap["errors"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [Error] in value.map { (value: ResultMap) -> Error in Error(unsafeResultMap: value) } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Error]) -> [ResultMap] in value.map { (value: Error) -> ResultMap in value.resultMap } }, forKey: "errors")
        }
      }

      public var accessToken: String? {
        get {
          return resultMap["accessToken"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "accessToken")
        }
      }

      public struct User: GraphQLSelectionSet {
        public static let possibleTypes = ["User"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(Int.self))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int) {
          self.init(unsafeResultMap: ["__typename": "User", "id": id])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: Int {
          get {
            return resultMap["id"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }
      }

      public struct Error: GraphQLSelectionSet {
        public static let possibleTypes = ["FieldError"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("path", type: .nonNull(.scalar(String.self))),
          GraphQLField("message", type: .nonNull(.scalar(String.self))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(path: String, message: String) {
          self.init(unsafeResultMap: ["__typename": "FieldError", "path": path, "message": message])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var path: String {
          get {
            return resultMap["path"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "path")
          }
        }

        public var message: String {
          get {
            return resultMap["message"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "message")
          }
        }
      }
    }
  }
}

public final class LogoutMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    mutation logout($userId: Float!) {
      revokeRefreshToken(userId: $userId)
    }
    """

  public let operationName = "logout"

  public var userId: Double

  public init(userId: Double) {
    self.userId = userId
  }

  public var variables: GraphQLMap? {
    return ["userId": userId]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("revokeRefreshToken", arguments: ["userId": GraphQLVariable("userId")], type: .nonNull(.scalar(Bool.self))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(revokeRefreshToken: Bool) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "revokeRefreshToken": revokeRefreshToken])
    }

    public var revokeRefreshToken: Bool {
      get {
        return resultMap["revokeRefreshToken"]! as! Bool
      }
      set {
        resultMap.updateValue(newValue, forKey: "revokeRefreshToken")
      }
    }
  }
}

public final class RegisterMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    mutation register($input: UserInput!) {
      register(input: $input) {
        __typename
        user {
          __typename
          id
          email
        }
        accessToken
        errors {
          __typename
          path
          message
        }
      }
    }
    """

  public let operationName = "register"

  public var input: UserInput

  public init(input: UserInput) {
    self.input = input
  }

  public var variables: GraphQLMap? {
    return ["input": input]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("register", arguments: ["input": GraphQLVariable("input")], type: .nonNull(.object(Register.selections))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(register: Register) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "register": register.resultMap])
    }

    public var register: Register {
      get {
        return Register(unsafeResultMap: resultMap["register"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "register")
      }
    }

    public struct Register: GraphQLSelectionSet {
      public static let possibleTypes = ["UserResponse"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("user", type: .object(User.selections)),
        GraphQLField("accessToken", type: .scalar(String.self)),
        GraphQLField("errors", type: .list(.nonNull(.object(Error.selections)))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(user: User? = nil, accessToken: String? = nil, errors: [Error]? = nil) {
        self.init(unsafeResultMap: ["__typename": "UserResponse", "user": user.flatMap { (value: User) -> ResultMap in value.resultMap }, "accessToken": accessToken, "errors": errors.flatMap { (value: [Error]) -> [ResultMap] in value.map { (value: Error) -> ResultMap in value.resultMap } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var user: User? {
        get {
          return (resultMap["user"] as? ResultMap).flatMap { User(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "user")
        }
      }

      public var accessToken: String? {
        get {
          return resultMap["accessToken"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "accessToken")
        }
      }

      public var errors: [Error]? {
        get {
          return (resultMap["errors"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [Error] in value.map { (value: ResultMap) -> Error in Error(unsafeResultMap: value) } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Error]) -> [ResultMap] in value.map { (value: Error) -> ResultMap in value.resultMap } }, forKey: "errors")
        }
      }

      public struct User: GraphQLSelectionSet {
        public static let possibleTypes = ["User"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(Int.self))),
          GraphQLField("email", type: .nonNull(.scalar(String.self))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int, email: String) {
          self.init(unsafeResultMap: ["__typename": "User", "id": id, "email": email])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: Int {
          get {
            return resultMap["id"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var email: String {
          get {
            return resultMap["email"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "email")
          }
        }
      }

      public struct Error: GraphQLSelectionSet {
        public static let possibleTypes = ["FieldError"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("path", type: .nonNull(.scalar(String.self))),
          GraphQLField("message", type: .nonNull(.scalar(String.self))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(path: String, message: String) {
          self.init(unsafeResultMap: ["__typename": "FieldError", "path": path, "message": message])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var path: String {
          get {
            return resultMap["path"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "path")
          }
        }

        public var message: String {
          get {
            return resultMap["message"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "message")
          }
        }
      }
    }
  }
}

public final class MeQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    query me {
      me {
        __typename
        user {
          __typename
          id
          email
          routines {
            __typename
            name
          }
        }
        errors {
          __typename
          path
          message
        }
      }
    }
    """

  public let operationName = "me"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("me", type: .object(Me.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(me: Me? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "me": me.flatMap { (value: Me) -> ResultMap in value.resultMap }])
    }

    public var me: Me? {
      get {
        return (resultMap["me"] as? ResultMap).flatMap { Me(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "me")
      }
    }

    public struct Me: GraphQLSelectionSet {
      public static let possibleTypes = ["UserResponse"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("user", type: .object(User.selections)),
        GraphQLField("errors", type: .list(.nonNull(.object(Error.selections)))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(user: User? = nil, errors: [Error]? = nil) {
        self.init(unsafeResultMap: ["__typename": "UserResponse", "user": user.flatMap { (value: User) -> ResultMap in value.resultMap }, "errors": errors.flatMap { (value: [Error]) -> [ResultMap] in value.map { (value: Error) -> ResultMap in value.resultMap } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var user: User? {
        get {
          return (resultMap["user"] as? ResultMap).flatMap { User(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "user")
        }
      }

      public var errors: [Error]? {
        get {
          return (resultMap["errors"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [Error] in value.map { (value: ResultMap) -> Error in Error(unsafeResultMap: value) } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Error]) -> [ResultMap] in value.map { (value: Error) -> ResultMap in value.resultMap } }, forKey: "errors")
        }
      }

      public struct User: GraphQLSelectionSet {
        public static let possibleTypes = ["User"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(Int.self))),
          GraphQLField("email", type: .nonNull(.scalar(String.self))),
          GraphQLField("routines", type: .list(.nonNull(.object(Routine.selections)))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int, email: String, routines: [Routine]? = nil) {
          self.init(unsafeResultMap: ["__typename": "User", "id": id, "email": email, "routines": routines.flatMap { (value: [Routine]) -> [ResultMap] in value.map { (value: Routine) -> ResultMap in value.resultMap } }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: Int {
          get {
            return resultMap["id"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var email: String {
          get {
            return resultMap["email"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "email")
          }
        }

        public var routines: [Routine]? {
          get {
            return (resultMap["routines"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [Routine] in value.map { (value: ResultMap) -> Routine in Routine(unsafeResultMap: value) } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Routine]) -> [ResultMap] in value.map { (value: Routine) -> ResultMap in value.resultMap } }, forKey: "routines")
          }
        }

        public struct Routine: GraphQLSelectionSet {
          public static let possibleTypes = ["Routine"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(name: String) {
            self.init(unsafeResultMap: ["__typename": "Routine", "name": name])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var name: String {
            get {
              return resultMap["name"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }
        }
      }

      public struct Error: GraphQLSelectionSet {
        public static let possibleTypes = ["FieldError"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("path", type: .nonNull(.scalar(String.self))),
          GraphQLField("message", type: .nonNull(.scalar(String.self))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(path: String, message: String) {
          self.init(unsafeResultMap: ["__typename": "FieldError", "path": path, "message": message])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var path: String {
          get {
            return resultMap["path"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "path")
          }
        }

        public var message: String {
          get {
            return resultMap["message"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "message")
          }
        }
      }
    }
  }
}
