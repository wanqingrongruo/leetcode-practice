//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

/*
 给定一个字符串，请你找出其中不含有重复字符的 最长子串 的长度。

 示例 1:

 输入: "abcabcbb"
 输出: 3
 解释: 因为无重复字符的最长子串是 "abc"，所以其长度为 3。
 示例 2:

 输入: "bbbbb"
 输出: 1
 解释: 因为无重复字符的最长子串是 "b"，所以其长度为 1。
 示例 3:

 输入: "pwwkew"
 输出: 3
 解释: 因为无重复字符的最长子串是 "wke"，所以其长度为 3。
           请注意，你的答案必须是 子串 的长度，"pwke" 是一个子序列，不是子串。


 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/longest-substring-without-repeating-characters
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

import Foundation

class Solution {

    // 思路一: 遍历 - 存储值 - 清理重复值之前的所有, 得到最后不同的字符串
    func lengthOfLongestSubstring(_ s: String) -> Int {
        var result: Int = 0
        var hashContainer = [Character]()
        s.forEach { (char) in
            if !hashContainer.contains(char) {
                hashContainer.append(char)
            } else {
                let count = hashContainer.count
                result = max(result, count)
                if let last = hashContainer.split(separator: char, maxSplits: 2, omittingEmptySubsequences: false).last {
                    hashContainer = Array(last)
                } else {
                    hashContainer = []
                }

                hashContainer.append(char)
            }
        }

        result = max(result, hashContainer.count)

        return result
    }

    // 学习了别人的思路 https://leetcode-cn.com/problems/longest-substring-without-repeating-characters/solution/wu-zhong-fu-zi-fu-de-zui-chang-zi-chuan-swift-by-c/
    // 其本质是求两个相同字符串之间的 最大间隔 + 1
    func lengthOfLongestSubstring02(_ s: String) -> Int {
        var distance = 0, start = 0, end = 0
        let characters = Array(s)
        let length = characters.count
        var cache = [Character: Int]()
        while start < length && end < length {
            let char = characters[end]
            if let value = cache[char] {
                start = max(value, start)
            }

            end += 1
            distance = max(distance, end - start)
            cache[char] = end
        }

        return distance
    }


}

let res = Solution().lengthOfLongestSubstring("pwwkew")


//: [Next](@next)
