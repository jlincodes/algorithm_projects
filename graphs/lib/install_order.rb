# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` works.

# Import any files you need to



def install_order(arr)
  max = 0
  arr.each { |tuple| max = tuple[0] if tuple[0] > max }
  vertices = (1..max).map { |package_id| Vertex.new(package_id) }
  arr.each { |tuple| Edge.new(vertices[tuple[1] - 1], vertices[tuple[0] - 1]) }
  topological_sort(vertices).map(&:value)
end
