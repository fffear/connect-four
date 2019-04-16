# This is a method object for 'vertical_win' to determine all possible victory conditions that occur vertically
class VerticalWin
  attr_reader :current_vertex, :vertex_list, :current_pointer_in_adjacency_list, :adjacency_list, :count, :idx_num

  def initialize(vertex_list, adjacency_list)
    @vertex_list = vertex_list
    @adjacency_list = adjacency_list
  end

  def compute
    (0..6).each do |n|
      set_variables_to_search_column(n)
      (current_marker_blank?) ? next : @count += 1

      until current_marker_blank?
        @current_pointer_in_adjacency_list.each(&count_marker_and_move_to_vertex_above)
        break if column_without_4_in_a_row? || current_marker_blank?
        return true if column_with_4_in_a_row?
      end
    end
    false
  end

  private
  def find_idx_num_of_tile_above(vertex)
    @idx_num = @vertex_list.index(vertex)
  end

  def update_current_vertex_and_adjacency_list_pointer
    @current_vertex = @vertex_list[idx_num]
    @current_pointer_in_adjacency_list = @adjacency_list[idx_num]
  end

  def update_count(vertex)
    @count += 1 if @current_vertex.marker == vertex.marker
    @count = 1 if @current_vertex.marker != vertex.marker
  end

  def vertex_above_current_vertex(vertex)
    vertex.coordinates[1] == @current_vertex.coordinates[1] + 1 && vertex.coordinates[0] == @current_vertex.coordinates[0]
  end

  def count_marker_and_move_to_vertex_above
    lambda do |vertex|
      if vertex_above_current_vertex(vertex)
        update_count(vertex)
        find_idx_num_of_tile_above(vertex)
        update_current_vertex_and_adjacency_list_pointer
        break
      end
    end
  end

  def reached_top_row?
    @vertex_list.index(@current_vertex) >= 35
  end

  def column_without_4_in_a_row?
    reached_top_row? && @count != 4
  end

  def column_with_4_in_a_row?
    @count == 4
  end

  def current_marker_blank?
    @current_vertex.marker == " "
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