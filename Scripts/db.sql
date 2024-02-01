CREATE USER 'web'@'%' IDENTIFIED BY 'Password&1';
CREATE DATABASE gestione_progetti;
GRANT ALL PRIVILEGES ON gestione_progetti.* TO 'web'@'%';
FLUSH PRIVILEGES;

USE gestione_progetti;
CREATE TABLE IF NOT EXISTS Project(
    id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(255),
    description VARCHAR(255),
    startedAt DATE,archived TINYINT(1),
    Creator_id INT NOT NULL,
    Contributor_id INT NOT NULL,
    PRIMARY KEY(id)
);
CREATE TABLE IF NOT EXISTS ProjectState(
    id INT NOT NULL AUTO_INCREMENT,
    state ENUM('assigned','ongoing','testing','finished'),
    updatedAt DATETIME,
    Project_id INT NOT NULL,
    PRIMARY KEY(id)
);
CREATE TABLE IF NOT EXISTS User(
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(50),
    surname VARCHAR(50),
    email VARCHAR(255),
    phoneNumber VARCHAR(22),
    role ENUM('contributor','admin','superadmin'),
    password CHAR(64),
    disabled TINYINT(1) DEFAULT 0,
    PRIMARY KEY(id)
);
ALTER TABLE ProjectState 
    ADD CONSTRAINT Progetti_ProjectState FOREIGN KEY (Project_id) REFERENCES Project(id);
ALTER TABLE Project 
    ADD CONSTRAINT Contributor_Progetti FOREIGN KEY (Contributor_id) REFERENCES User(id),
    ADD CONSTRAINT Creator_progetto FOREIGN KEY (Creator_id) REFERENCES User(id);

INSERT INTO User (name,surname,email,phoneNumber,role,password,disabled) VALUES("root","root","root@gmail.com","+41761111111","superadmin","$2y$10$Qjt428VOjY57np/r.QsTy.N0mH4nm92v1PzMZjWlnf6imBaaa1jBy",0);