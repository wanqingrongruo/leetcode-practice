//: Playground - noun: a place where people can play

import UIKit
import Foundation

var str = "Hello, playground"

/*
 给定一个整数数组 nums 和一个目标值 target，请你在该数组中找出和为目标值的那 两个 整数，并返回他们的数组下标。

 你可以假设每种输入只会对应一个答案。但是，你不能重复利用这个数组中同样的元素。

 示例:

 给定 nums = [2, 7, 11, 15], target = 9

 因为 nums[0] + nums[1] = 2 + 7 = 9
 所以返回 [0, 1]

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/two-sum
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */


class Solution {

    // 1.
    // Time Complexity: O(n), Space Complexity: O(n)
    /*
     执行用时 :88 ms, 在所有 Swift 提交中击败了 53.75% 的用户
     内存消耗 :20.9 MB, 在所有 Swift 提交中击败了 5.12% 的用户
     */
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var dict = [Int: Int]()
        for (index, element) in nums.enumerated() {
            if let diff = dict[target - element] {
                return [diff, index]
            }
            dict[element] = index
        }

        fatalError("MMP")
    }

    // 2.Time Complexity: O(n), Space Complexity: O(n)
    // Time Complexity: O(n), Space Complexity: O(n)
    // 改进: enumerated => 耗时
    /*
     执行用时 :48 ms, 在所有 Swift 提交中击败了 96.77% 的用户
     内存消耗 :21.1 MB, 在所有 Swift 提交中击败了 5.12% 的用户
     */
    func twoSum02(_ nums: [Int], _ target: Int) -> [Int] {
        var dict = [Int: Int]()
        for index in 0..<nums.count {
            let element = nums[index]
            if let diff = dict[target - element] {
                return [diff, index]
            }
            dict[element] = index
        }

        fatalError("MMP")
    }

    // 3.
    // 辣鸡---耗时
    func twoSum03(_ nums: [Int], _ target: Int) -> [Int] {
        for index in 0..<nums.count {
            let element = nums[index]
            let diff = target - element
            if nums.contains(diff) ,let aim = nums.lastIndex(of: diff), aim != index {
                return [index, aim]
            }
        }
        
        return []
    }

    // 4.
    // 辣鸡---耗时, 双重循环必然耗时
    func twoSum04(_ nums: [Int], _ target: Int) -> [Int] {
        for i in 0..<nums.count {
            for j in (i+1)..<nums.count {
                if nums[i] + nums[j] == target {
                    return [i, j]
                }
            }

        }

        return []
    }

    // jj
    func twoSum05(_ nums: [Int], _ target: Int) -> [Int] {
        var dict = [Int: Int]()
        var i = -1
        var iterator = nums.makeIterator()
        while let element = iterator.next() {
            i += 1
            if let diff = dict[target - element] {
                return [diff, i]
            }
            dict[element] = i
        }
        fatalError("MMP")
    }
}


let nums = [2, 7, 11, 15]
let results = Solution().twoSum(nums, 9)
let results03 = Solution().twoSum03(nums, 9)
let results04 = Solution().twoSum04(nums, 9)
let results05 = Solution().twoSum05(nums, 9)
