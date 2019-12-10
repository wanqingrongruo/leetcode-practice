//: [Previous](@previous)

import Foundation

var str = "Hello, 爬楼梯"

/* No. 70
 假设你正在爬楼梯。需要 n 阶你才能到达楼顶。

每次你可以爬 1 或 2 个台阶。你有多少种不同的方法可以爬到楼顶呢？

注意：给定 n 是一个正整数。

示例 1：

输入： 2
输出： 2
解释： 有两种方法可以爬到楼顶。
1.  1 阶 + 1 阶
2.  2 阶
示例 2：

输入： 3
输出： 3
解释： 有三种方法可以爬到楼顶。
1.  1 阶 + 1 阶 + 1 阶
2.  1 阶 + 2 阶
3.  2 阶 + 1 阶

来源：力扣（LeetCode）
链接：https://leetcode-cn.com/problems/climbing-stairs
著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */


/*
 * 问题分析: 拆解 第 n 阶 可能是从第 n-1 阶跨一步到达的,也可能是从第 n-2 阶跨两n步到达的, 以此类推
 * f(0) = 0, f(1) = 1, .... f(n) = f(n-1) + f(n-2)
 */

class Solution {
    func climbStairs(_ n: Int) -> Int {
        if n < 3 {
            return n
        }
        var elements = [0, 1, 2]
        for i in 3...n {
            elements.append(elements[i - 1] + elements[i - 2])
        }
        return elements[n]
    }
}

let n = Solution().climbStairs(4)





/* No. 120
 给定一个三角形，找出自顶向下的最小路径和。每一步只能移动到下一行中相邻的结点上。

 例如，给定三角形：

 [
 [2],
 [3,4],
 [6,5,7],
 [4,1,8,3]
 ]
 自顶向下的最小路径和为 11（即，2 + 3 + 5 + 1 = 11）。

 说明：

 如果你可以只使用 O(n) 的额外空间（n 为三角形的总行数）来解决这个问题，那么你的算法会很加分。



 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/triangle
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

/*思路
 * 1. 问题拆解: 按从上往下走, 经过 [i][j] 元素一定经过了 [i-1][j] 或 [i-1][j-1] 元素, 因此经过一个元素的路径和可以通过这个元素上面的一个或者两个元素的路径和得到(注: 当上一个元素是顶点时,就为一个)
 * 2. 状态定义: 状态的定义一般会和问题需要求解的答案联系起来. 因为元素的值是不变的, 因此自上而下和自下而上都可以
 * 2.1 自上而下: 那么 第 i 行决定了第 i-1 行的元素. 当元素是 i 行最左边的元素, 第 i-1 行的元素 就必须是 [i-i][j](注: j=0), 当元素是 i 行最右边的元素, 第 i-1 行元素就必须是 [i-1][j-1], 中间的元素都可.
 * 2.2 自下而上: 那么第 i 行元素最短路径和由 [i+1][j] 或 [i+1][j-1] 的元素路径和 + [i][j] 决定,
 * 即 sum[i][j] = min(sum[i+1][j], sum[i+1][j+1]) +  triangle[i][j]
 * 且 对于[0][0] 元素, 最后状态表示就是我们的最终答案
 */


extension Solution {
    func minimumTotal(_ triangle: [[Int]]) -> Int {
        if triangle.count < 2 {
            return triangle[0][0]
        }

        var pathSum = triangle.compactMap { (rows) -> [Int] in
            return rows.map { _ in return 0 }
        }
        let rows = triangle.count
        // 保留最后一行值, 因为最后一行的值就是自下而上的第一行的最短路径和
        let lastRows = triangle[rows-1]
        for (index, value) in lastRows.enumerated() {
            pathSum[rows-1][index] = value
        }

        let startIndex = rows - 2
        for index in 0...startIndex {
            let iIndex = startIndex - index
            let iRow = triangle[iIndex]
            for jIndex in 0..<iRow.count {
                pathSum[iIndex][jIndex] = min(pathSum[iIndex + 1][jIndex], pathSum[iIndex + 1][jIndex + 1]) + iRow[jIndex]
            }
        }

        return pathSum[0][0]
    }
}

let triangle = [[-10]]
let tri = Solution().minimumTotal(triangle)

/* N0. 53
 给定一个整数数组 nums ，找到一个具有最大和的连续子数组（子数组最少包含一个元素），返回其最大和。

 示例:

 输入: [-2,1,-3,4,-1,2,1,-5,4],
 输出: 6
 解释: 连续子数组 [4,-1,2,1] 的和最大，为 6。
 进阶:

 如果你已经实现复杂度为 O(n) 的解法，尝试使用更为精妙的分治法求解。

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/maximum-subarray
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */


/*思路
 * 1. 问题拆解: 最大和连续子串是一个区间, 存在起点和终点, 首先我们得确定一个点去找另一个点, 因为我们是要寻找最大和, 所以确定终点是个不错的选择.
 *  假设终点 i, 那么最大和子串 就是 i-1 为终点的最大子串和 + a[i] 或者 a[i] 就是最大
 * 2. 状态定义: 直接以"以 i 为结尾的最大子串和" 为状态 => sum[i] = max(sum[i-1], 0) + a[i]
 */
extension Solution {
    func maxSubArray(_ nums: [Int]) -> Int {
        if nums.isEmpty {
            return 0
        }
        var sum = Array(repeating: 0, count: nums.count)
        sum[0] = nums[0]
        var maxValue = sum[0]
        for index in 1..<nums.count {
            sum[index] = max(sum[index - 1], 0) + nums[index]
            maxValue = max(maxValue, sum[index])
        }

        return maxValue
    }
}

let s = Solution().maxSubArray([-2,1,-3,4,-1,2,1,-5,4])

//: [Next](@next)
