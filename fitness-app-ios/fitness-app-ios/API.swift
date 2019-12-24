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

public struct RoutineInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(id: Swift.Optional<Double?> = nil, name: String, exercises: [ExerciseInput]) {
    graphQLMap = ["id": id, "name": name, "exercises": exercises]
  }

  public var id: Swift.Optional<Double?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<Double?> ?? Swift.Optional<Double?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var name: String {
    get {
      return graphQLMap["name"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "name")
    }
  }

  public var exercises: [ExerciseInput] {
    get {
      return graphQLMap["exercises"] as! [ExerciseInput]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "exercises")
    }
  }
}

public struct ExerciseInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(id: Swift.Optional<Double?> = nil, name: String, sets: [SetInput]) {
    graphQLMap = ["id": id, "name": name, "sets": sets]
  }

  public var id: Swift.Optional<Double?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<Double?> ?? Swift.Optional<Double?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var name: String {
    get {
      return graphQLMap["name"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "name")
    }
  }

  public var sets: [SetInput] {
    get {
      return graphQLMap["sets"] as! [SetInput]
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "sets")
    }
  }
}

public struct SetInput: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(id: Swift.Optional<Double?> = nil, kg: Double, reps: Double) {
    graphQLMap = ["id": id, "kg": kg, "reps": reps]
  }

  public var id: Swift.Optional<Double?> {
    get {
      return graphQLMap["id"] as? Swift.Optional<Double?> ?? Swift.Optional<Double?>.none
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "id")
    }
  }

  public var kg: Double {
    get {
      return graphQLMap["kg"] as! Double
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "kg")
    }
  }

  public var reps: Double {
    get {
      return graphQLMap["reps"] as! Double
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "reps")
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
            id
            userId
            name
            exercises {
              __typename
              routineId
              name
              sets {
                __typename
                exerciseId
                kg
                reps
              }
            }
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
            GraphQLField("id", type: .nonNull(.scalar(Int.self))),
            GraphQLField("userId", type: .nonNull(.scalar(Int.self))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
            GraphQLField("exercises", type: .list(.nonNull(.object(Exercise.selections)))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int, userId: Int, name: String, exercises: [Exercise]? = nil) {
            self.init(unsafeResultMap: ["__typename": "Routine", "id": id, "userId": userId, "name": name, "exercises": exercises.flatMap { (value: [Exercise]) -> [ResultMap] in value.map { (value: Exercise) -> ResultMap in value.resultMap } }])
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

          public var userId: Int {
            get {
              return resultMap["userId"]! as! Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "userId")
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

          public var exercises: [Exercise]? {
            get {
              return (resultMap["exercises"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [Exercise] in value.map { (value: ResultMap) -> Exercise in Exercise(unsafeResultMap: value) } }
            }
            set {
              resultMap.updateValue(newValue.flatMap { (value: [Exercise]) -> [ResultMap] in value.map { (value: Exercise) -> ResultMap in value.resultMap } }, forKey: "exercises")
            }
          }

          public struct Exercise: GraphQLSelectionSet {
            public static let possibleTypes = ["Exercise"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("routineId", type: .nonNull(.scalar(Int.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
              GraphQLField("sets", type: .list(.nonNull(.object(Set.selections)))),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(routineId: Int, name: String, sets: [Set]? = nil) {
              self.init(unsafeResultMap: ["__typename": "Exercise", "routineId": routineId, "name": name, "sets": sets.flatMap { (value: [Set]) -> [ResultMap] in value.map { (value: Set) -> ResultMap in value.resultMap } }])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var routineId: Int {
              get {
                return resultMap["routineId"]! as! Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "routineId")
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

            public var sets: [Set]? {
              get {
                return (resultMap["sets"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [Set] in value.map { (value: ResultMap) -> Set in Set(unsafeResultMap: value) } }
              }
              set {
                resultMap.updateValue(newValue.flatMap { (value: [Set]) -> [ResultMap] in value.map { (value: Set) -> ResultMap in value.resultMap } }, forKey: "sets")
              }
            }

            public struct Set: GraphQLSelectionSet {
              public static let possibleTypes = ["ExerciseSet"]

              public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("exerciseId", type: .nonNull(.scalar(Int.self))),
                GraphQLField("kg", type: .nonNull(.scalar(Double.self))),
                GraphQLField("reps", type: .nonNull(.scalar(Double.self))),
              ]

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(exerciseId: Int, kg: Double, reps: Double) {
                self.init(unsafeResultMap: ["__typename": "ExerciseSet", "exerciseId": exerciseId, "kg": kg, "reps": reps])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              public var exerciseId: Int {
                get {
                  return resultMap["exerciseId"]! as! Int
                }
                set {
                  resultMap.updateValue(newValue, forKey: "exerciseId")
                }
              }

              public var kg: Double {
                get {
                  return resultMap["kg"]! as! Double
                }
                set {
                  resultMap.updateValue(newValue, forKey: "kg")
                }
              }

              public var reps: Double {
                get {
                  return resultMap["reps"]! as! Double
                }
                set {
                  resultMap.updateValue(newValue, forKey: "reps")
                }
              }
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

public final class GetRoutinesQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    query getRoutines {
      getRoutines {
        __typename
        routines {
          __typename
          name
          userId
          exercises {
            __typename
            name
            routineId
            sets {
              __typename
              exerciseId
              kg
              reps
            }
          }
        }
        errors {
          __typename
          message
        }
      }
    }
    """

  public let operationName = "getRoutines"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("getRoutines", type: .nonNull(.object(GetRoutine.selections))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getRoutines: GetRoutine) {
      self.init(unsafeResultMap: ["__typename": "Query", "getRoutines": getRoutines.resultMap])
    }

    public var getRoutines: GetRoutine {
      get {
        return GetRoutine(unsafeResultMap: resultMap["getRoutines"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "getRoutines")
      }
    }

    public struct GetRoutine: GraphQLSelectionSet {
      public static let possibleTypes = ["RoutineResponse"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("routines", type: .list(.nonNull(.object(Routine.selections)))),
        GraphQLField("errors", type: .list(.nonNull(.object(Error.selections)))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(routines: [Routine]? = nil, errors: [Error]? = nil) {
        self.init(unsafeResultMap: ["__typename": "RoutineResponse", "routines": routines.flatMap { (value: [Routine]) -> [ResultMap] in value.map { (value: Routine) -> ResultMap in value.resultMap } }, "errors": errors.flatMap { (value: [Error]) -> [ResultMap] in value.map { (value: Error) -> ResultMap in value.resultMap } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
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

      public var errors: [Error]? {
        get {
          return (resultMap["errors"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [Error] in value.map { (value: ResultMap) -> Error in Error(unsafeResultMap: value) } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Error]) -> [ResultMap] in value.map { (value: Error) -> ResultMap in value.resultMap } }, forKey: "errors")
        }
      }

      public struct Routine: GraphQLSelectionSet {
        public static let possibleTypes = ["Routine"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("userId", type: .nonNull(.scalar(Int.self))),
          GraphQLField("exercises", type: .list(.nonNull(.object(Exercise.selections)))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(name: String, userId: Int, exercises: [Exercise]? = nil) {
          self.init(unsafeResultMap: ["__typename": "Routine", "name": name, "userId": userId, "exercises": exercises.flatMap { (value: [Exercise]) -> [ResultMap] in value.map { (value: Exercise) -> ResultMap in value.resultMap } }])
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

        public var userId: Int {
          get {
            return resultMap["userId"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "userId")
          }
        }

        public var exercises: [Exercise]? {
          get {
            return (resultMap["exercises"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [Exercise] in value.map { (value: ResultMap) -> Exercise in Exercise(unsafeResultMap: value) } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Exercise]) -> [ResultMap] in value.map { (value: Exercise) -> ResultMap in value.resultMap } }, forKey: "exercises")
          }
        }

        public struct Exercise: GraphQLSelectionSet {
          public static let possibleTypes = ["Exercise"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
            GraphQLField("routineId", type: .nonNull(.scalar(Int.self))),
            GraphQLField("sets", type: .list(.nonNull(.object(Set.selections)))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(name: String, routineId: Int, sets: [Set]? = nil) {
            self.init(unsafeResultMap: ["__typename": "Exercise", "name": name, "routineId": routineId, "sets": sets.flatMap { (value: [Set]) -> [ResultMap] in value.map { (value: Set) -> ResultMap in value.resultMap } }])
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

          public var routineId: Int {
            get {
              return resultMap["routineId"]! as! Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "routineId")
            }
          }

          public var sets: [Set]? {
            get {
              return (resultMap["sets"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [Set] in value.map { (value: ResultMap) -> Set in Set(unsafeResultMap: value) } }
            }
            set {
              resultMap.updateValue(newValue.flatMap { (value: [Set]) -> [ResultMap] in value.map { (value: Set) -> ResultMap in value.resultMap } }, forKey: "sets")
            }
          }

          public struct Set: GraphQLSelectionSet {
            public static let possibleTypes = ["ExerciseSet"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("exerciseId", type: .nonNull(.scalar(Int.self))),
              GraphQLField("kg", type: .nonNull(.scalar(Double.self))),
              GraphQLField("reps", type: .nonNull(.scalar(Double.self))),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(exerciseId: Int, kg: Double, reps: Double) {
              self.init(unsafeResultMap: ["__typename": "ExerciseSet", "exerciseId": exerciseId, "kg": kg, "reps": reps])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var exerciseId: Int {
              get {
                return resultMap["exerciseId"]! as! Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "exerciseId")
              }
            }

            public var kg: Double {
              get {
                return resultMap["kg"]! as! Double
              }
              set {
                resultMap.updateValue(newValue, forKey: "kg")
              }
            }

            public var reps: Double {
              get {
                return resultMap["reps"]! as! Double
              }
              set {
                resultMap.updateValue(newValue, forKey: "reps")
              }
            }
          }
        }
      }

      public struct Error: GraphQLSelectionSet {
        public static let possibleTypes = ["FieldError"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("message", type: .nonNull(.scalar(String.self))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(message: String) {
          self.init(unsafeResultMap: ["__typename": "FieldError", "message": message])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
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

public final class AddRoutineMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    mutation AddRoutine($input: RoutineInput!) {
      addRoutine(input: $input) {
        __typename
        routine {
          __typename
          name
          exercises {
            __typename
            name
            sets {
              __typename
              kg
              reps
            }
          }
        }
        errors {
          __typename
          message
        }
      }
    }
    """

  public let operationName = "AddRoutine"

  public var input: RoutineInput

  public init(input: RoutineInput) {
    self.input = input
  }

  public var variables: GraphQLMap? {
    return ["input": input]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("addRoutine", arguments: ["input": GraphQLVariable("input")], type: .nonNull(.object(AddRoutine.selections))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(addRoutine: AddRoutine) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "addRoutine": addRoutine.resultMap])
    }

    public var addRoutine: AddRoutine {
      get {
        return AddRoutine(unsafeResultMap: resultMap["addRoutine"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "addRoutine")
      }
    }

    public struct AddRoutine: GraphQLSelectionSet {
      public static let possibleTypes = ["RoutineResponse"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("routine", type: .object(Routine.selections)),
        GraphQLField("errors", type: .list(.nonNull(.object(Error.selections)))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(routine: Routine? = nil, errors: [Error]? = nil) {
        self.init(unsafeResultMap: ["__typename": "RoutineResponse", "routine": routine.flatMap { (value: Routine) -> ResultMap in value.resultMap }, "errors": errors.flatMap { (value: [Error]) -> [ResultMap] in value.map { (value: Error) -> ResultMap in value.resultMap } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var routine: Routine? {
        get {
          return (resultMap["routine"] as? ResultMap).flatMap { Routine(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "routine")
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

      public struct Routine: GraphQLSelectionSet {
        public static let possibleTypes = ["Routine"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("exercises", type: .list(.nonNull(.object(Exercise.selections)))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(name: String, exercises: [Exercise]? = nil) {
          self.init(unsafeResultMap: ["__typename": "Routine", "name": name, "exercises": exercises.flatMap { (value: [Exercise]) -> [ResultMap] in value.map { (value: Exercise) -> ResultMap in value.resultMap } }])
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

        public var exercises: [Exercise]? {
          get {
            return (resultMap["exercises"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [Exercise] in value.map { (value: ResultMap) -> Exercise in Exercise(unsafeResultMap: value) } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Exercise]) -> [ResultMap] in value.map { (value: Exercise) -> ResultMap in value.resultMap } }, forKey: "exercises")
          }
        }

        public struct Exercise: GraphQLSelectionSet {
          public static let possibleTypes = ["Exercise"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
            GraphQLField("sets", type: .list(.nonNull(.object(Set.selections)))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(name: String, sets: [Set]? = nil) {
            self.init(unsafeResultMap: ["__typename": "Exercise", "name": name, "sets": sets.flatMap { (value: [Set]) -> [ResultMap] in value.map { (value: Set) -> ResultMap in value.resultMap } }])
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

          public var sets: [Set]? {
            get {
              return (resultMap["sets"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [Set] in value.map { (value: ResultMap) -> Set in Set(unsafeResultMap: value) } }
            }
            set {
              resultMap.updateValue(newValue.flatMap { (value: [Set]) -> [ResultMap] in value.map { (value: Set) -> ResultMap in value.resultMap } }, forKey: "sets")
            }
          }

          public struct Set: GraphQLSelectionSet {
            public static let possibleTypes = ["ExerciseSet"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("kg", type: .nonNull(.scalar(Double.self))),
              GraphQLField("reps", type: .nonNull(.scalar(Double.self))),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(kg: Double, reps: Double) {
              self.init(unsafeResultMap: ["__typename": "ExerciseSet", "kg": kg, "reps": reps])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var kg: Double {
              get {
                return resultMap["kg"]! as! Double
              }
              set {
                resultMap.updateValue(newValue, forKey: "kg")
              }
            }

            public var reps: Double {
              get {
                return resultMap["reps"]! as! Double
              }
              set {
                resultMap.updateValue(newValue, forKey: "reps")
              }
            }
          }
        }
      }

      public struct Error: GraphQLSelectionSet {
        public static let possibleTypes = ["FieldError"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("message", type: .nonNull(.scalar(String.self))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(message: String) {
          self.init(unsafeResultMap: ["__typename": "FieldError", "message": message])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
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

public final class DeleteRoutineMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    mutation deleteRoutine($input: Float!) {
      deleteRoutine(input: $input)
    }
    """

  public let operationName = "deleteRoutine"

  public var input: Double

  public init(input: Double) {
    self.input = input
  }

  public var variables: GraphQLMap? {
    return ["input": input]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("deleteRoutine", arguments: ["input": GraphQLVariable("input")], type: .nonNull(.scalar(Bool.self))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(deleteRoutine: Bool) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "deleteRoutine": deleteRoutine])
    }

    public var deleteRoutine: Bool {
      get {
        return resultMap["deleteRoutine"]! as! Bool
      }
      set {
        resultMap.updateValue(newValue, forKey: "deleteRoutine")
      }
    }
  }
}

public final class GetRoutineByIdQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    query getRoutineById($input: Float!) {
      getRoutine(input: $input) {
        __typename
        routine {
          __typename
          id
          name
          exercises {
            __typename
            name
            sets {
              __typename
              kg
              reps
            }
          }
        }
        errors {
          __typename
          message
        }
      }
    }
    """

  public let operationName = "getRoutineById"

  public var input: Double

  public init(input: Double) {
    self.input = input
  }

  public var variables: GraphQLMap? {
    return ["input": input]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("getRoutine", arguments: ["input": GraphQLVariable("input")], type: .nonNull(.object(GetRoutine.selections))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(getRoutine: GetRoutine) {
      self.init(unsafeResultMap: ["__typename": "Query", "getRoutine": getRoutine.resultMap])
    }

    public var getRoutine: GetRoutine {
      get {
        return GetRoutine(unsafeResultMap: resultMap["getRoutine"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "getRoutine")
      }
    }

    public struct GetRoutine: GraphQLSelectionSet {
      public static let possibleTypes = ["RoutineResponse"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("routine", type: .object(Routine.selections)),
        GraphQLField("errors", type: .list(.nonNull(.object(Error.selections)))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(routine: Routine? = nil, errors: [Error]? = nil) {
        self.init(unsafeResultMap: ["__typename": "RoutineResponse", "routine": routine.flatMap { (value: Routine) -> ResultMap in value.resultMap }, "errors": errors.flatMap { (value: [Error]) -> [ResultMap] in value.map { (value: Error) -> ResultMap in value.resultMap } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var routine: Routine? {
        get {
          return (resultMap["routine"] as? ResultMap).flatMap { Routine(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "routine")
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

      public struct Routine: GraphQLSelectionSet {
        public static let possibleTypes = ["Routine"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(Int.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("exercises", type: .list(.nonNull(.object(Exercise.selections)))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int, name: String, exercises: [Exercise]? = nil) {
          self.init(unsafeResultMap: ["__typename": "Routine", "id": id, "name": name, "exercises": exercises.flatMap { (value: [Exercise]) -> [ResultMap] in value.map { (value: Exercise) -> ResultMap in value.resultMap } }])
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

        public var name: String {
          get {
            return resultMap["name"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        public var exercises: [Exercise]? {
          get {
            return (resultMap["exercises"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [Exercise] in value.map { (value: ResultMap) -> Exercise in Exercise(unsafeResultMap: value) } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Exercise]) -> [ResultMap] in value.map { (value: Exercise) -> ResultMap in value.resultMap } }, forKey: "exercises")
          }
        }

        public struct Exercise: GraphQLSelectionSet {
          public static let possibleTypes = ["Exercise"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
            GraphQLField("sets", type: .list(.nonNull(.object(Set.selections)))),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(name: String, sets: [Set]? = nil) {
            self.init(unsafeResultMap: ["__typename": "Exercise", "name": name, "sets": sets.flatMap { (value: [Set]) -> [ResultMap] in value.map { (value: Set) -> ResultMap in value.resultMap } }])
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

          public var sets: [Set]? {
            get {
              return (resultMap["sets"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [Set] in value.map { (value: ResultMap) -> Set in Set(unsafeResultMap: value) } }
            }
            set {
              resultMap.updateValue(newValue.flatMap { (value: [Set]) -> [ResultMap] in value.map { (value: Set) -> ResultMap in value.resultMap } }, forKey: "sets")
            }
          }

          public struct Set: GraphQLSelectionSet {
            public static let possibleTypes = ["ExerciseSet"]

            public static let selections: [GraphQLSelection] = [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("kg", type: .nonNull(.scalar(Double.self))),
              GraphQLField("reps", type: .nonNull(.scalar(Double.self))),
            ]

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(kg: Double, reps: Double) {
              self.init(unsafeResultMap: ["__typename": "ExerciseSet", "kg": kg, "reps": reps])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var kg: Double {
              get {
                return resultMap["kg"]! as! Double
              }
              set {
                resultMap.updateValue(newValue, forKey: "kg")
              }
            }

            public var reps: Double {
              get {
                return resultMap["reps"]! as! Double
              }
              set {
                resultMap.updateValue(newValue, forKey: "reps")
              }
            }
          }
        }
      }

      public struct Error: GraphQLSelectionSet {
        public static let possibleTypes = ["FieldError"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("message", type: .nonNull(.scalar(String.self))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(message: String) {
          self.init(unsafeResultMap: ["__typename": "FieldError", "message": message])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
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

public final class UpdateRoutineMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    mutation updateRoutine($input: RoutineInput!) {
      updateRoutine(input: $input)
    }
    """

  public let operationName = "updateRoutine"

  public var input: RoutineInput

  public init(input: RoutineInput) {
    self.input = input
  }

  public var variables: GraphQLMap? {
    return ["input": input]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("updateRoutine", arguments: ["input": GraphQLVariable("input")], type: .nonNull(.scalar(Bool.self))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(updateRoutine: Bool) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "updateRoutine": updateRoutine])
    }

    public var updateRoutine: Bool {
      get {
        return resultMap["updateRoutine"]! as! Bool
      }
      set {
        resultMap.updateValue(newValue, forKey: "updateRoutine")
      }
    }
  }
}
