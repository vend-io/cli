/*
* Authors: 
* - @iwatakeshi
* - @azac
* License: MIT
*/
public extension Array {

	//push()	Adds new elements to the end of an array, and returns the new length

	mutating func push(elements: (Element)...) -> [Element] {

		for element in elements { self.append(element) }
		return self
	}

	//pop()	Removes the last element of an array, and returns that element

	mutating func pop() -> Element? {
		if (self.isEmpty) {
			return nil
		} else { return self.removeLast() }
	}


	//shift()	Removes the first element of an array, and returns that element

	mutating func shift () -> Element? {

		if (self.isEmpty) {
			return nil
		} else {
			return self.remove(at: 0)

		}

	}


	//unshift()	Adds new elements to the beginning of an array, and returns the new length

	mutating func unshift (elements: (Element)...) -> Int {

		self = elements + self

		return self.count

	}


	//concat()	Joins two or more arrays, and returns a copy of the joined arrays

	func concat (arrays: [Element]...) -> [Element] {

		var sum = self
		for i in arrays {
			sum = sum + i
		}
		return sum

	}


	//indexOf()	Search the array for an element and returns its position

	func indexOf<T : Equatable>(_ item :T, startIndex: Int = 0) -> Int {

		for i in 0..<self.count {
			if self[i] as! T == item && i>=startIndex {
				return i
			}
		}
		return -1
	}


	//lastIndexOf()	Search the array for an elemet, starting at the end, and returns its position

	func lastIndexOf<T : Equatable>(_ item :T, startIndex: Int = 0) -> Int {

		var found = -1;

		for i in 0..<self.count {
			if self[i] as! T == item && i>=startIndex {
				found=i
			}
		}
		return found
	}




	//join()	Joins all elements of an array into a string

	func join(separator:String=",") -> String{
		var str : String = ""

		for (idx, item) in self.enumerated() {
			str += "\(item)"
			if idx < self.count-1 {
				str += separator
			}
		}
		return str
	}


	// reverse()	Reverses the order of the elements in an array

	// sort of works like JS


	//sort()	Sorts the elements of an array

	// sort of works like JS


	//slice()	Selects a part of an array, and returns the new array

	func slice(bounds:Int...) -> Array<Element> {

		var lowerIndex = bounds[0]

		if (bounds[0] < 0) {lowerIndex = self.count+(bounds[0]);}

		var upperIndex = self.count-1

		if bounds.count==2 {

			upperIndex=bounds[1]-1

			if (upperIndex<0) {upperIndex = self.count-1+(bounds[1]);}

		}

		return Array<Element>(self[lowerIndex...upperIndex])

	}

	//toString()	Converts an array to a string, and returns the result

	func toString() -> String {

		return self.join(separator:",")

	}


	//splice()	Adds/Removes elements from an array

	mutating func splice (_ index:Int, from: Int, elements: (Element)...) -> Array<Element> {

		let midIndex = index+from

		let arr_start = self[0...index-1]

		let cutout = self[index...midIndex-1]

		let arr_end = self[midIndex...(self.count-1)]

		self = arr_start + elements + arr_end

		return Array<Element>(cutout)

	}

}