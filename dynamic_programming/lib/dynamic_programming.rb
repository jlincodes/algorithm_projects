class DynamicProgramming
  attr_accessor :blair_cache, :frog_cache, :super_cache

  def initialize
    @blair_cache = { 1 => 1, 2 => 2 }
    @frog_cache = { 1 => [[1]], 2 => [[1, 1], [2]], 3 => [[1, 1, 1], [1, 2], [2, 1], [3]] }
    @super_cache = { 1 => [[1]], 2 => [[1, 1], [2]], 3 => [[1, 1, 1], [1, 2], [2, 1], [3]] }
    @maze_cache = []
    # @coins = []
  end

  def blair_nums(n)
    blair_builder(n)
    @blair_cache[n]
  end

  def blair_builder(n)
    return @blair_cache unless !@blair_cache[n]
    (3..n).each do |i|
      next_blair = (@blair_cache[i-1] + @blair_cache[i-2]) + 2*i - 1
      @blair_cache[i] = next_blair
    end
    @blair_cache
  end

  def frog_hops_bottom_up(n)
    return @frog_cache[n] unless @frog_cache[n].nil?
    frog_cache_builder(n)
    @frog_cache[n]
  end

  def frog_cache_builder(n)
    last_key = @frog_cache.keys.last
    ((last_key + 1)..n).each do |idx|
      cache_1 = @frog_cache[idx-1].map {|arr| [1] + arr }
      cache_2 = @frog_cache[idx-2].map {|arr| [2] + arr }
      cache_3 = @frog_cache[idx-3].map {|arr| [3] + arr }
      @frog_cache[idx] = cache_1 + cache_2 + cache_3
    end
    @frog_cache
  end

# [[1, 1, 1, 1], [1, 1, 2], [1, 2, 1], [2, 1, 1], [2, 2], [1, 3], [3, 1]]
  def frog_hops_top_down(n)
    return @frog_cache[n] unless @frog_cache[n].nil?
    frog_hops_top_down_helper(n)
  end

  def frog_hops_top_down_helper(n)
    return @frog_cache[n] if @frog_cache[n]
    cache_1 = frog_hops_top_down_helper(n - 1).map { |arr| [1] + arr }
    cache_2 = frog_hops_top_down_helper(n- 2).map { |arr| [2] + arr }
    cache_3 = frog_hops_top_down_helper(n - 3).map { |arr| [3] + arr }
    @frog_cache[n] = cache_1 + cache_2 + cache_3
    @frog_cache[n]
  end

  # n = number of stairs
  # k = max number of hops
  def super_frog_hops(n, k)
    return [[1] * n] if k == 1
    return @super_cache[n] if @super_cache[n]
    # return @super_cache[k] if k <= n
    value = []
    n.downto(2) do |idx|
      if k >= (n - idx + 1)
        value += super_frog_hops(idx - 1, k).map { |arr| arr + [n - idx + 1] }
      end
    end
    @super_cache[n] = value
    @super_cache[n]
  end

  def knapsack(weights, values, capacity)

  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)

  end

  def maze_solver(maze, start_pos, end_pos)
    # @maze_cache << start_pos unless @maze_cache.last == start_pos
    # return end_pos if start_pos == end_pos
    # row,col = start_pos
    # if [" ","F"].include?(maze[row][col+1])
    #   maze[row][col+1] = "V"
    #   maze_solver(maze,[row,col+1],end_pos)
    #
    # elsif [" ","F"].include?(maze[row+1][col])
    #   maze[row+1][col] = "V"
    #   maze_solver(maze, [row+1,col],end_pos)
    #
    # elsif [" ","F"].include?(maze[row][col-1])
    #   maze[row][col-1] = "V"
    #   maze_solver(maze, [row,col-1],end_pos)
    #
    # elsif [" ","F"].include?(maze[row-1][col])
    #   maze[row-1][col] = "V"
    #   maze_solver(maze, [row-1,col],end_pos)
    # else
    #   @maze_cache.pop
    #   maze_solver(maze,@maze_cache.last,end_pos)
    # end
    # @maze_cache

  end
end
