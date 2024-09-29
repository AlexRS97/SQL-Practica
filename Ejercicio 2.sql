DROP TABLE IF EXISTS PAYMENT;
DROP TABLE IF EXISTS STUDENT;
DROP TABLE IF EXISTS MODULE;
DROP TABLE IF EXISTS TEACHER;
DROP TABLE IF EXISTS BOOTCAMP;

CREATE TABLE BOOTCAMP (
    bootcamp_id SERIAL PRIMARY KEY,
    bootcamp_name CHAR(80) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL
);

CREATE TABLE TEACHER (
    teacher_id SERIAL PRIMARY KEY,
    teacher_name CHAR(50) NOT NULL,
    teacher_surname CHAR(50) NOT NULL,
    teacher_mail CHAR(50) NOT NULL,
    teacher_phone CHAR(50) NOT NULL,
    teacher_contract CHAR(50) NOT NULL
);

CREATE TABLE MODULE (
    module_id SERIAL PRIMARY KEY,
    teacher_id INT NOT NULL,
    bootcamp_id INT NOT NULL,
    module_name CHAR(50) NOT NULL,
    module_year DATE NOT NULL,
    module_start_date DATE NOT NULL,
    module_end_date DATE NOT NULL,
    FOREIGN KEY (teacher_id) REFERENCES TEACHER(teacher_id),
    FOREIGN KEY (bootcamp_id) REFERENCES BOOTCAMP(bootcamp_id)
);

CREATE TABLE STUDENT (
    student_id SERIAL PRIMARY KEY,
    student_name CHAR(50) NOT NULL,
    student_surname CHAR(50) NOT NULL,
    student_phone CHAR(50) NOT NULL,
    student_address CHAR(50) NOT NULL,
    student_birthdate DATE NOT NULL,
    student_registration DATE NOT NULL,
    student_status CHAR(50) NOT NULL,
    student_dni CHAR(50) NOT NULL,
    student_mail CHAR(250) NOT NULL,
    bootcamp_id INT NOT NULL,
    FOREIGN KEY (bootcamp_id) REFERENCES BOOTCAMP(bootcamp_id)
);

CREATE TABLE PAYMENT (
    payment_id SERIAL PRIMARY KEY,
    student_id INT NOT NULL,
    bootcamp_id INT NOT NULL,
    pay_method CHAR(25) NOT NULL,
    remaining_pay CHAR(25) NOT NULL,
    pay_status CHAR(25) NOT NULL,
    FOREIGN KEY (student_id) REFERENCES STUDENT(student_id),
    FOREIGN KEY (bootcamp_id) REFERENCES BOOTCAMP(bootcamp_id)
);

--DATOS:

INSERT INTO BOOTCAMP (bootcamp_name, start_date, end_date) VALUES
('DESARROLLO WEB', '2024-01-10', '2024-06-10'),
('BIG DATA, IA & MACHINE LEARNING', '2024-02-01', '2024-07-01'),
('BLOCKCHAIN', '2024-03-01', '2024-08-01'),
('DEVOPS & CLOUD COMPUTING', '2024-04-01', '2024-09-01'),
('INTELIGENCIA ARTIFICIAL', '2024-05-01', '2024-10-01');

INSERT INTO TEACHER (teacher_name, teacher_surname, teacher_mail, teacher_phone, teacher_contract) VALUES
('Carlos', 'Gómez', 'cgomez@mail.com', '654321987', 'Full-Time'),
('Marta', 'López', 'mlopez@mail.com', '612345678', 'Part-Time'),
('David', 'Pérez', 'dperez@mail.com', '622334455', 'Full-Time'),
('Laura', 'Sánchez', 'lsanchez@mail.com', '634567890', 'Full-Time'),
('Sergio', 'Fernández', 'sfernandez@mail.com', '644556677', 'Part-Time'),
('Ana', 'Ruiz', 'aruiz@mail.com', '655667788', 'Full-Time'),
('Jorge', 'Moreno', 'jmoreno@mail.com', '622345678', 'Full-Time'),
('Raquel', 'Martín', 'rmartin@mail.com', '699887766', 'Part-Time'),
('Alberto', 'Hernández', 'ahernandez@mail.com', '677889900', 'Full-Time'),
('Sonia', 'Díaz', 'sdiaz@mail.com', '611223344', 'Full-Time');

INSERT INTO MODULE (teacher_id, bootcamp_id, module_name, module_year, module_start_date, module_end_date) VALUES
(1, 1, 'HTML & CSS', '2024-01-10', '2024-01-10', '2024-02-10'),
(2, 1, 'JavaScript', '2024-01-10', '2024-02-11', '2024-03-10'),
(3, 2, 'Python para Big Data', '2024-02-01', '2024-02-01', '2024-03-01'),
(4, 2, 'Introducción a Machine Learning', '2024-02-01', '2024-03-02', '2024-04-01'),
(5, 3, 'Fundamentos de Blockchain', '2024-03-01', '2024-03-01', '2024-04-01'),
(6, 4, 'Infraestructura en la nube', '2024-04-01', '2024-04-01', '2024-05-01'),
(7, 4, 'Automatización con Docker', '2024-04-01', '2024-05-02', '2024-06-01'),
(8, 5, 'Redes neuronales y deep learning', '2024-05-01', '2024-05-01', '2024-06-01'),
(9, 5, 'Procesamiento de lenguaje natural', '2024-05-01', '2024-06-02', '2024-07-01');

INSERT INTO STUDENT (student_name, student_surname, student_phone, student_address, student_birthdate, student_registration, student_status, student_dni, student_mail, bootcamp_id) VALUES
('Juan', 'Martínez', '654987321', 'Calle Falsa 123', '1990-05-20', '2024-01-10', 'Enrolled', '12345678A', 'juan.martinez@mail.com', 1),
('Lucía', 'García', '612345678', 'Avenida Siempreviva 321', '1992-11-15', '2024-01-15', 'Enrolled', '87654321B', 'lucia.garcia@mail.com', 1),
('Pedro', 'López', '622334455', 'Calle Mayor 456', '1988-03-05', '2024-02-01', 'Enrolled', '11223344C', 'pedro.lopez@mail.com', 2),
('Ana', 'Pérez', '634567890', 'Avenida de la Paz 789', '1991-07-10', '2024-02-05', 'Enrolled', '44332211D', 'ana.perez@mail.com', 2),
('Javier', 'González', '644556677', 'Calle del Sol 321', '1990-10-20', '2024-03-01', 'Enrolled', '55667788E', 'javier.gonzalez@mail.com', 3),
('Sara', 'Rodríguez', '655667788', 'Calle Luna 789', '1994-12-25', '2024-03-10', 'Enrolled', '33445566F', 'sara.rodriguez@mail.com', 3),
('Manuel', 'Fernández', '622345678', 'Avenida Estrella 456', '1989-08-08', '2024-04-01', 'Enrolled', '99887766G', 'manuel.fernandez@mail.com', 4),
('Paula', 'Moreno', '699887766', 'Calle Nube 987', '1993-04-15', '2024-04-10', 'Enrolled', '77665544H', 'paula.moreno@mail.com', 4),
('Luis', 'Santos', '677889900', 'Calle Río 123', '1995-09-05', '2024-05-01', 'Enrolled', '11224433I', 'luis.santos@mail.com', 5),
('Laura', 'Díaz', '611223344', 'Avenida Mar 654', '1992-02-25', '2024-05-05', 'Enrolled', '22331144J', 'laura.diaz@mail.com', 5),
('Alberto', 'Jiménez', '622345678', 'Calle del Viento 231', '1990-06-22', '2024-01-10', 'Enrolled', '34567890K', 'alberto.jimenez@mail.com', 1),
('Teresa', 'Martínez', '654321987', 'Avenida Central 789', '1991-09-10', '2024-02-01', 'Enrolled', '98765432L', 'teresa.martinez@mail.com', 2),
('Pablo', 'Vega', '622334455', 'Calle Norte 456', '1990-11-20', '2024-03-01', 'Enrolled', '99887711M', 'pablo.vega@mail.com', 3),
('Mónica', 'Ramírez', '655667788', 'Avenida Sur 987', '1993-03-15', '2024-04-01', 'Enrolled', '22331144N', 'monica.ramirez@mail.com', 4),
('Héctor', 'Gil', '699887766', 'Calle Este 456', '1991-01-05', '2024-05-01', 'Enrolled', '44556677O', 'hector.gil@mail.com', 5);

INSERT INTO PAYMENT (student_id, bootcamp_id, pay_method, remaining_pay, pay_status) VALUES
(1, 1, 'Credit Card', '2000', 'Pending'),
(2, 1, 'Bank Transfer', '1000', 'Partial'),
(3, 2, 'Credit Card', '1500', 'Pending'),
(4, 2, 'PayPal', '3000', 'Pending'),
(5, 3, 'Credit Card', '500', 'Partial'),
(6, 3, 'Bank Transfer', '0', 'Paid'),
(7, 4, 'PayPal', '2500', 'Pending'),
(8, 4, 'Bank Transfer', '1000', 'Partial'),
(9, 5, 'Credit Card', '4000', 'Pending'),
(10, 5, 'PayPal', '2000', 'Partial');

