public struct Gists: Decodable {
    let description: String
    let files: [String: File]
    let gistId: String
    
    enum CodingKeys: String, CodingKey {
        case description
        case files
        case gistId = "id"
    }
}
