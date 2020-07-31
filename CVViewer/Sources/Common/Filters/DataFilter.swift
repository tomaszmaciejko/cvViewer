struct DataFilter {
    
    typealias ResumeSearchFilter = ([Gists], String) -> [Gists]
    typealias ResumeLimitFilter = ([Gists]) -> [Gists]
    
    private static let resumeSearchLimit = 10
    
    public static var searchResults: ResumeSearchFilter = { resumes, text in
        let filteredRepos = resumes.filter({( gist: Gists) -> Bool in
            if let gist = gist.files.keys.first {
                return gist.contains(text.lowercased())
            }
            return false
        })
        return filteredRepos
    }
    
    public static var limitResults: ResumeLimitFilter = { resumes in
        return Array(resumes.prefix(resumeSearchLimit))
    }
    
}
