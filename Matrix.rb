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

  end

  # method to get inversed matrix
  def inverce

  end

  # method to inverse current matrix
  def inverce_current_matrix

  end

  # method to get transposed matrix
  def transpose
    new_matrix = @matrix.transpose
  end

  # method to transpose current matrix
  def transpose_current_matrix
    @matrix = @matrix.transpose
  end

  # method to get matrix minor
  def minor

  end

  # overload + for matrix addition
  def +(m)
    add(m)
  end

  # overload * for matrix multiplication
  def *(m)
    multiply(m)
  end

end
