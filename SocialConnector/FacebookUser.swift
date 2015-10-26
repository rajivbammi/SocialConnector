import UIKit

class FacebookUser: NSObject {
    var id: String?
    var message: String?
    
    init(dictionary: NSDictionary) {
        id = dictionary["id"] as? String
        message = dictionary["message"] as? String
    }
    
    class func fbWithArray(array: NSDictionary) -> [FacebookUser] {
        var facebookUser = [FacebookUser]()
        let count = array["data"]!.count
        let res = array["data"] as! NSArray
        for (var i = 0 ;i < count; i++) {
            let fb: FacebookUser = FacebookUser(dictionary: res[i] as! NSDictionary)
            facebookUser.append(fb)
        }
        print("inside fbWithArray")
        print(facebookUser)
        return facebookUser
    }
    
}
