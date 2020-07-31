public struct Resume: Decodable {
    let firstName: String
    let lastName: String
    let address: String
    let dateOfBirth: String
    let phoneNumber: String
    let email: String
    let gender: String
    let summary: String
    let photoUrl: String
    
    enum CodingKeys: String, CodingKey {
        case firstName
        case lastName
        case address
        case dateOfBirth = "dob"
        case phoneNumber
        case email
        case gender
        case summary
        case photoUrl
    }
}
