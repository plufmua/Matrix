class Matrix

  # method to initialize new matrix
  def initialize matrix
    @matrix = matrix

  end

  # method to get count of matrix rows
  def row_count
    @matrix.size
  end

  # method to get count of matrix columns
  def column_count
    @matrix[0].size
  end

  # method to add matrix row
  # row - string to add
  # row_index - number of the row
  def add_row (row, row_index = 2)
    @matrix.to_a.insert(row_index, row)
  end

  # method to add matrix column
  # column - column to add
  # column_index - number of the column
  def add_column (column, column_index = 2)
    @matrix.transpose.to_a.insert(column_index, column).transpose
  end

  # method to remove matrix row
  # row_index - number of the row
  def remove_row row_index
    @matrix.to_a.delete_at(row_index)
  end

  # method to remove matrix column
  # column_index - number of the column
  def remove_column column_index
    @matrix.transpose.to_a.delete_at(column_index).transpose
  end

  # method to count determinant of matrix
  def determinant
    m = @matrix
    case row_count
      when 0
        1
      when 1
        m[0][0]
      when 2
        m[0][0] * m[1][1] - m[0][1] * m[1][0]
      when 3
        + m[0][0] * m[1][1] * m[2][2] + m[0][1] * m[1][2] * m[2][0]
        + m[0][2] * m[1][0] * m[2][1] - m[0][0] * m[1][2] * m[2][1]
        - m[0][1] * m[1][0] * m[2][2] - m[0][2] * m[1][1] * m[2][0]
    end
  end

  # method to get inversed matrix
  def inverce

  end

  # method to inverse current matrix
  def inverce_current_matrix

  end

  # method to get transposed matrix
  def transpose
    @matrix.transpose
  end

  # method to transpose current matrix
  def transpose_current_matrix
    @matrix = @matrix.transpose
  end

  # method to get matrix section
  # x1, y1 - first coordinate
  # x2, y2 - second coordinate
  def section (x1, y1, x2, y2)
    new_matrix = @matrix[x1, x2].collect{ |row|
      row[y1, y2]
    }
  end

  # overload + for matrix addition
  def + m

  end

  # overload * for matrix multiplication
  def * m

  end

end
