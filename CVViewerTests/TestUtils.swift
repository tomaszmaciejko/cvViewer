class TestUtils {

    func getFakeGist(fileName: String = "") -> Gists {
        let file = getFakeFile(fileName: fileName)
        return Gists(description: "fakeDescription", files: [fileName: file], gistId: "fakeId")

    }

    func getFakeFile(fileName: String) -> File {
        return File(filename: fileName, type: "fakeType", language: "fakeLanguage", size: 0, content: "fakeContent")
    }
}
