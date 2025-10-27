-- Taller Final: Diseño e Implementación de Base de Datos
-- Escenario: Biblioteca (versión simplificada)

-- ================================
-- 1. CREACIÓN DE TABLAS
-- ================================
CREATE TABLE Autor (
  id_autor SERIAL PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL
);

CREATE TABLE Libro (
  id_libro SERIAL PRIMARY KEY,
  titulo VARCHAR(150) NOT NULL,
  anio INT,
  id_autor INT REFERENCES Autor(id_autor)
);

CREATE TABLE Socio (
  id_socio SERIAL PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  email VARCHAR(100)
);

CREATE TABLE Prestamo (
  id_prestamo SERIAL PRIMARY KEY,
  id_libro INT REFERENCES Libro(id_libro),
  id_socio INT REFERENCES Socio(id_socio),
  fecha_prestamo DATE DEFAULT CURRENT_DATE,
  fecha_devolucion DATE
);

-- ================================
-- 2. DATOS DE EJEMPLO
-- ================================
INSERT INTO Autor(nombre) VALUES
('Gabriel García Márquez'),
('Isabel Allende'),
('Stephen King');

INSERT INTO Libro(titulo, anio, id_autor) VALUES
('Cien años de soledad', 1967, 1),
('La casa de los espíritus', 1982, 2),
('It', 1986, 3);

INSERT INTO Socio(nombre, email) VALUES
('Ana Pérez', 'ana@example.com'),
('Carlos Ruiz', 'carlos@example.com');

INSERT INTO Prestamo(id_libro, id_socio, fecha_prestamo, fecha_devolucion) VALUES
(1, 1, '2025-10-01', '2025-10-10'),
(2, 2, '2025-10-15', NULL);

-- ================================
-- 3. CONSULTAS COMPLEJAS
-- ================================

-- 1. Mostrar los libros prestados y a quién
SELECT L.titulo, S.nombre AS socio, P.fecha_prestamo, P.fecha_devolucion
FROM Prestamo P
JOIN Libro L ON P.id_libro = L.id_libro
JOIN Socio S ON P.id_socio = S.id_socio;

-- 2. Contar cuántos libros tiene cada autor
SELECT A.nombre, COUNT(L.id_libro) AS cantidad_libros
FROM Autor A
LEFT JOIN Libro L ON A.id_autor = L.id_autor
GROUP BY A.nombre;

-- 3. Libros que aún no se han devuelto
SELECT L.titulo, S.nombre AS socio
FROM Prestamo P
JOIN Libro L ON P.id_libro = L.id_libro
JOIN Socio S ON P.id_socio = S.id_socio
WHERE P.fecha_devolucion IS NULL;
