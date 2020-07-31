struct ConfigProvider {
    
    public static var userName: String = "tomaszmaciejko"
    public static var owner: String = "tomaszmaciejko"

    public static var baseURL: String {
        return "https://api.github.com/users/\(userName)"
    }
    
    public static var reposUrl: String {
        return "https://api.github.com/repos/\(owner)/"
    }
    
    public static var gistsUrl: String {
        return "https://api.github.com"
    }
}
