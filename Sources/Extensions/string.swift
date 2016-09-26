import Foundation
import Rexy

public extension String {
    /*
    * Returns the count of characters in the string.
    */
    var count: Int {
        return self.characters.count
    }
    /*
    * Converts each character to an array.
    */
    func toArray() -> [String] {
        return self.characters.map { String($0) }
    }
   /*
   * Returns the position of the first occurrence of a specified value in a string.
   */
    func indexOf(_ string: String) -> Int? {
        return self.toArray().indexOf(string)
    }
    /*
    * Determines whether a string exists.
    */
    func has(_ string: String) -> Bool {
        return self.indexOf(string) != nil
    }
    /*
    * Determines whether a pattern exists.
    */
    func test(_ pattern: String) -> Bool {
        do { 
          let regex = try Regex(pattern)
          return regex.matches(self).count > 0
        } catch { return false }
    }
    /*
    * Replaces a string that matches a string or pattern with a given string.
    */
    func replace(_ pattern: String, _ with: String) -> String {
        let regex = try! Regex(pattern)
        return regex.replace(self, with: with)
    }
    /*
    * Splits the string into an array with a given pattern.
    */
    func split(_ pattern: String) -> [String] {
      do { 
        let regex = try Regex(pattern)
        var temp = self
        for match in regex.matches(self) {
            if match != " " {
                temp = temp.replace(match, " ")
            }
        }
        return temp.components(separatedBy: " ")
      } catch { return [] }
    }

    subscript (_ i: Int) -> String? {
        let count = self.characters.count;
        let value = Array(self.characters);
        return i >= 0 && i < count ? String(value[i]) : nil
    }

    subscript (_ i: Int) -> Character? {
        let count = self.characters.count;
        let value = Array(self.characters);
        return i >= 0 && i < count ? value[i] : nil
    }
}