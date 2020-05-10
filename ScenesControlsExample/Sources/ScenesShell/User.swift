import Igis
import Scenes

class User : Equatable {
    static var nextUserId = 1
    let privateId : Int
    var publicId : String? = nil

    init() {
        privateId = User.nextUserId
        User.nextUserId += 1
    }

    static func == (lhs:User, rhs:User) -> Bool {
        return lhs.privateId == rhs.privateId
    }
}
