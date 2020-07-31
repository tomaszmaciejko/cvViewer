public struct File: Decodable {
    let filename: String
    let type: String
    let language: String
    let size: Int
    let content: String?
}
