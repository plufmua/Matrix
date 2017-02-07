Инициализация матрицы должна осуществляться при помощи  инициализатора.
Пример: 
Matrix.new([[1, 2, 3], [4, 5, 6], [7, 8, 9]])

В классе Matrix необходимо реализовать:

Методы для определения количества строк и столбцов матрицы.
Тип возвращаемого значения: число.
	
Методы для добавления новой строки и столбца в матрицу.
Параметры: массив добавляемых значений (обязательный), позиция/индекс (необязательный аргумент; по умолчанию - добавить в конец).

Методы для удаления строки и столбца.
Параметры: позиция/индекс удаляемой строки/столбца.

Метод для нахождения определителя матрицы.
Тип возвращаемого значения: число.

Метод для нахождения обратной матрицы.
Тип возвращаемого значения: новый объект класса Matrix.

Метод для замены текущей матрицы (объекта) новой обратной матрицей.
	
Метод для нахождения транспонированной матрицы.
Тип возвращаемого значения: новый объект класса Matrix.

Метод для замены текущей матрицы (объекта) новой транспонированной матрицей.

Метод для среза части матрицы.
Параметры: 2 параметра, указывающие с какой позиции по какую необходимо произвести срез.
Пример: с позиции [1, 1] по [10, 5] (т.е. с первой строки первого столбца по 10-ю строку и 5-й столбец - в зависимости от выбранной индексации [с нуля или единицы]).
Тип возвращаемого значения: новый объект класса Matrix.

Метод-перегрузка для сложения матрицы с другим объектом класса Matrix.
Параметр: объект класса Matrix.
Тип возвращаемого значения: новый объект класса Matrix.

Метод-перегрузка для умножения матрицы с другим объектом класса Matrix.
Параметр: объект класса Matrix.
Тип возвращаемого значения: новый объект класса Matrix.