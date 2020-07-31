import XCTest

class DataFilterTests: XCTestCase {

    var gists: [Gists] = []

    override func setUp() {
        gists.append(TestUtils().getFakeGist(fileName: "Aaa"))
        gists.append(TestUtils().getFakeGist(fileName: "BBB"))
        gists.append(TestUtils().getFakeGist(fileName: "Ccc"))
        gists.append(TestUtils().getFakeGist(fileName: "DDD"))
        gists.append(TestUtils().getFakeGist(fileName: "eEE"))
        gists.append(TestUtils().getFakeGist(fileName: "fff"))
        gists.append(TestUtils().getFakeGist(fileName: "ggg"))
        gists.append(TestUtils().getFakeGist(fileName: "Aha"))
        gists.append(TestUtils().getFakeGist(fileName: "AIA"))
        gists.append(TestUtils().getFakeGist(fileName: "TTT"))
        gists.append(TestUtils().getFakeGist(fileName: "SSS"))
        gists.append(TestUtils().getFakeGist(fileName: "ZZZ"))

    }

    override func tearDown() {
        gists = []
    }

    func testResumesSearchFilter_lowercase() {
        let result = DataFilter.searchResults(gists, "a")
        XCTAssertEqual(result.count, 2)
    }

    func testResumesSearchFilter_uppercase() {
        let result = DataFilter.searchResults(gists, "A")
        XCTAssertEqual(result.count, 2)
    }

    func testResumesSearchFilter_emptyString() {
        let result = DataFilter.searchResults(gists, "")
        XCTAssertEqual(result.count, 0)
    }

    func testResumesSearchFilter_justSpace() {
        let result = DataFilter.searchResults(gists, " ")
        XCTAssertEqual(result.count, 0)
    }

    func testResumesSearchFilter_randomChar() {
        let result = DataFilter.searchResults(gists, ";")
        XCTAssertEqual(result.count, 0)
    }

    func testResumesSearchFilter_emptyArray() {
        let resumesSubset = [Gists]()

        let result = DataFilter.searchResults(resumesSubset, "a")
        XCTAssertEqual(result.count, 0)
    }

    func testResumesLimitFilter_positive() {
        let result = DataFilter.limitResults(gists)
        XCTAssertEqual(result.count, 10)
    }

    func testResumesLimitFilter_lessThan10() {
        let resumesSubset = Array(gists.prefix(5))
        let result = DataFilter.limitResults(resumesSubset)
        XCTAssertEqual(result.count, 5)
    }

    func testResumesLimitFilter_emptyArray() {
        let resumesSubset = [Gists]()
        let result = DataFilter.limitResults(resumesSubset)
        XCTAssertEqual(result.count, 0)
    }

}
