require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  sorted = []
  top_queue = []

  vertices.each { |v| top_queue << v if v.in_edges.empty? }

  until top_queue.empty?
    curr_vertex = top_queue.shift
    sorted << curr_vertex
    until curr_vertex.out_edges.empty?
      edge = curr_vertex.out_edges[0]
      to_vertex = edge.to_vertex
      edge.destroy!
      top_queue << to_vertex if to_vertex.in_edges.empty?
    end
  end
  vertices.map { |v| v.in_edges.length + v.out_edges.length }.inject(0, :+) > 0 ? [] : sorted
end
