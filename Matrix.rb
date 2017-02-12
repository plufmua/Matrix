class Matrix
  attr_accessor :rows
  # returns the number of columns
  attr_reader :column_count

  protected :rows

  def initialize(rows, column_count = rows[0].size)
    @rows = rows
    @column_count = column_count
  end

  # method to add matrix row
  # row - string to add
  # row_index - number of the row
  def add_row (row, row_index = nil)
    row_index = row_count if row_index.nil?
    self.rows.to_a.insert(row_index, row)
  end

  # method to add matrix column
  # column - column to add
  # column_index - number of the column
  def add_column (column, column_index = nil)
    column_index = column_count if column_index.nil?
    self.transpose_current_matrix.insert(column_index, column)

    self.transpose_current_matrix
  end

  # method to remove matrix row
  # row_index - number of the row
  def remove_row row_index
    self.rows.to_a.delete_at(row_index)
  end

  # method to remove matrix column
  # column_index - number of the column
  def remove_column column_index
    self.transpose_current_matrix
        .delete_at(column_index)

    self.transpose_current_matrix
  end

  # returns element [i, j] of the matrix
  def [](i, j)
    @rows.fetch(i){return nil}[j]
  end

  # returns the number of rows
  def row_count
    @rows.size
  end

  # returns a section of the matrix
  def minor(*param)
    if param.count == 4
      from_row, from_col, size_row, size_col = param
      return nil if size_row < 0 || size_col < 0
      from_row += row_count if from_row < 0
      from_col += column_count if from_col < 0
    else
      raise ArgumentError, param.inspect
    end
    return nil if from_row > row_count || from_col > column_count || from_row < 0 || from_col < 0
    rows = @rows[from_row, size_row].collect{|row|
      row[from_col, size_col]
    }
    new_matrix rows, [column_count - from_col, size_col].min
  end

  # method to matrix multiplication
  def *(m)
    raise "\#{self.name} dimension mismatch" if column_count != m.row_count

    rows = Array.new(row_count) {|i|
      Array.new(m.column_count) {|j|
        (0 ... column_count).inject(0) do |vij, k|
          vij + self[i, k] * m[k, j]
        end
      }
    }
    return new_matrix rows, m.column_count
  end

  # method to matrix addition
  def +(m)
   raise "\#{self.name} dimension mismatch" unless row_count == m.row_count && column_count == m.column_count

    rows = Array.new(row_count) {|i|
      Array.new(column_count) {|j|
        self[i, j] + m[i, j]
      }
    }
    new_matrix rows, column_count
  end

  # method to inverse of the matrix
  def inverse
    matrix_a = new_matrix(self.rows, self.column_count)
    puts matrix_a.inspect
    matrix_b = row_count.times.map{|row, l| [0]*row_count;}.map.with_index{|row, l| row[l]=1;row}
    for k in (0 .. row_count - 1)
      for i in (k + 1 .. row_count - 1)

        change_rows(matrix_a, matrix_b, k)
        l = k
        l += 1 while matrix_a[k][l] == 0 && l < column_count
        next if l == column_count

        times = matrix_a[i][l] / matrix_a[k][l].to_f
        yield l, i, times rescue nil
        for j in (l .. column_count - 1)
          matrix_a[i][j] -= times * matrix_a[k][j]
        end
        matrix_b[i].map!.with_index{|ele, col| ele - times * matrix_b[k][col]} rescue nil
      end
    end
    for k in (row_count - 1).downto(0)
      next if matrix_a[k].all?{|ele| ele.zero? }
      l = k
      l += 1 while matrix_a[k][l] == 0 && l < column_count
      next if l == column_count
      matrix_b[k].map!{|ele| ele / matrix_a[k][l]} rescue nil

      times = matrix_a[k][l]
      matrix_a[k].map!{|ele| ele / times } rescue nil
      for i in (0 .. k - 1)
        times = matrix_a[i][l] / matrix_a[k][l].to_f
        for j in (l .. column_count - 1)
          matrix_a[i][j] -= times * matrix_a[k][j]
        end
        matrix_b[i].map!.with_index{|ele, col| ele - times * matrix_b[k][col]} rescue nil
      end
    end
    matrix_b
  end

  # method to determinant of the matrix
  def determinant
    raise "\#{self.name} dimension mismatch" unless row_count == column_count
    m = @rows
    case row_count
      when 0
        +1
      when 1
        + m[0][0]
      when 2
        + m[0][0] * m[1][1] - m[0][1] * m[1][0]
      when 3
        m0, m1, m2 = m
        + m0[0] * m1[1] * m2[2] - m0[0] * m1[2] * m2[1] \
        - m0[1] * m1[0] * m2[2] + m0[1] * m1[2] * m2[0] \
        + m0[2] * m1[0] * m2[1] - m0[2] * m1[1] * m2[0]
      else
        puts 'Too big matrix'
    end
  end

  # method to transpose matrix
  def transpose
    return self.class.empty(column_count, 0) if row_count.zero?
    new_matrix @rows.transpose, row_count
  end

  # method to inverse current matrix
    def inverse_current_matrix
      self.rows = self.inverse
    end

  # method to transpose current matrix
    def transpose_current_matrix
      self.rows = self.rows.transpose
    end

  private

  # creates a matrix where each argument is a row
  def Matrix.[](*rows)
    rows(rows)
  end

  # creates a matrix where +rows+ is an array of arrays, each of which is a row of the matrix
  def Matrix.rows(rows)
    rows = convert_to_array(rows)
    rows.map! do |row|
      convert_to_array(row)
    end
    size = (rows[0] || []).size
    rows.each do |row|
      raise "row size differs (#{row.size} should be #{size})" unless row.size == size
    end
    new rows, size
  end

  def new_matrix(rows, column_count = rows[0].size)
    self.class.send(:new, rows, column_count)
  end

  def []=(i, j, v)
    @rows[i][j] = v
  end

  def change_rows(matrix_a, matrix_b, k)
    if matrix_a[k][k] <= 0.0000000001
      (row_count - 1).downto(k + 1) do |l|
        if matrix_a[l][k].abs >= 0.0000000001
          matrix_a[k], matrix_a[l] = matrix_a[l], matrix_a[k]
          matrix_b[k], matrix_b[l] = matrix_b[l], matrix_b[k] rescue nil
          @matrix_c[k], @matrix_c[l] = @matrix_c[l], @matrix_c[k] rescue nil
        end
      end
    end
  end
end
