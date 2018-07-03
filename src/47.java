public class Solution {
    /*
     * @param nums: a list of integers
     * @return: The majority number that occurs more than 1/3
     */
    public int majorityNumber(List<Integer> nums) {
        // write your code here
        Map<Integer,Integer> Helper = new HashMap<Integer,Integer>();
        for (int i = 0;i < nums.size();i++){
            if (Helper.get(nums.get(i)) == null){
                Helper.put(nums.get(i),1);
            } else {
                Helper.put(nums.get(i),Helper.get(nums.get(i)) + 1);
            }
        }
        for (Map.Entry<Integer, Integer> entry : Helper.entrySet()) {
            if (entry.getValue() > nums.size() / 3 )
                return entry.getKey();
        }
        return -1;
    }
}