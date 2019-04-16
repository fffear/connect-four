class DiagonalUpRightWin
  attr_reader :current_vertex, :vertex_list, :current_pointer_in_adjacency_list, :adjacency_list, :count, :idx_num

  def initialize(vertex_list, adjacency_list)
    @vertex_list = vertex_list
    @adjacency_list = adjacency_list
  end

  def compute
    search_half_of_board_for_4_in_a_row([0, 7, 14], &at_top_row?)
    return true if @count == 4
    search_half_of_board_for_4_in_a_row([1, 2, 3], &at_last_column?)
    return true if @count == 4
    false
  end

  private
  def search_half_of_board_for_4_in_a_row(positions, &block)
    positions.each do |n|
      set_variables_to_search_column(n)
      @count += 1 if current_vertex.marker != " "

      until yield
        current_pointer_in_adjacency_list.each(&count_marker_and_move_to_diagonal_vertex)
        return true if @count == 4
      end
    end
  end

  def at_top_row?
    lambda { vertex_list.index(current_vertex) >= 35 }
  end

  def at_last_column?
    lambda { vertex_list.index(current_vertex) % 7 == 6 }
  end

  def count_marker_and_move_to_diagonal_vertex
    lambda do |vertex|
      if vertex.coordinates[1] == current_vertex.coordinates[1] + 1 && vertex.coordinates[0] == current_vertex.coordinates[0] + 1
        update_marker_count(vertex)
        find_idx_num_of_adjacent_diagonal_top_right_tile(vertex)
        update_current_vertex_and_adjacency_list_pointer
        break
      end
    end
  end

  def update_marker_count(vertex)
    @count += 1 if current_vertex.marker == vertex.marker && vertex.marker != " "
    @count = 1 if current_vertex.marker != vertex.marker
  end

  def find_idx_num_of_adjacent_diagonal_top_right_tile(vertex)
    @idx_num = vertex_list.index(vertex)
  end

  def update_current_vertex_and_adjacency_list_pointer
    @current_vertex = vertex_list[idx_num]
    @current_pointer_in_adjacency_list = adjacency_list[idx_num]
  end

  def restart_count
    @count = 0
  end

  def set_current_vertex_to_bottom_of_column(n)
    @current_vertex = @vertex_list[n]
  end
  
  def set_pointer_in_adjacency_list_to_bottom_of_column(n)
    @current_pointer_in_adjacency_list = @adjacency_list[n]
  end

  def set_variables_to_search_column(n)
    restart_count
    set_current_vertex_to_bottom_of_column(n)
    set_pointer_in_adjacency_list_to_bottom_of_column(n)
  end
end