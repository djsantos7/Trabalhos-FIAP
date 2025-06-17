CREATE TABLE contato (
    id_contato NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nm_primeiro VARCHAR2(50) NOT NULL,
    nm_sobrenome VARCHAR2(50),
    apelido VARCHAR2(30),
    foto BLOB,
    dt_criacao TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    dt_ultima_atualizacao TIMESTAMP
);

CREATE TABLE telefone (
    id_telefone NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_contato NUMBER NOT NULL,
    numero VARCHAR2(20) NOT NULL,
    tipo VARCHAR2(15) CHECK (tipo IN ('CELULAR', 'RESIDENCIAL', 'TRABALHO', 'OUTRO')),
    principal CHAR(1) DEFAULT 'N' CHECK (principal IN ('S', 'N')),
    FOREIGN KEY (id_contato) REFERENCES contato(id_contato) ON DELETE CASCADE
);

CREATE TABLE email (
    id_email NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_contato NUMBER NOT NULL,
    endereco_email VARCHAR2(100) NOT NULL,
    tipo VARCHAR2(15) CHECK (tipo IN ('PESSOAL', 'PROFISSIONAL', 'OUTRO')),
    principal CHAR(1) DEFAULT 'N' CHECK (principal IN ('S', 'N')),
    FOREIGN KEY (id_contato) REFERENCES contato(id_contato) ON DELETE CASCADE
);

CREATE TABLE endereco (
    id_endereco NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_contato NUMBER NOT NULL,
    logradouro VARCHAR2(100),
    numero VARCHAR2(10),
    complemento VARCHAR2(50),
    bairro VARCHAR2(50),
    cidade VARCHAR2(50),
    uf VARCHAR2(2),
    cep VARCHAR2(10),
    tipo VARCHAR2(15) CHECK (tipo IN ('RESIDENCIAL', 'COMERCIAL', 'OUTRO')),
    FOREIGN KEY (id_contato) REFERENCES contato(id_contato) ON DELETE CASCADE
);

CREATE TABLE grupo (
    id_grupo NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nm_grupo VARCHAR2(50) NOT NULL,
    descricao VARCHAR2(200)
);

CREATE TABLE contato_grupo_assoc (
    id_contato NUMBER NOT NULL,
    id_grupo NUMBER NOT NULL,
    PRIMARY KEY (id_contato, id_grupo),
    FOREIGN KEY (id_contato) REFERENCES contato(id_contato) ON DELETE CASCADE,
    FOREIGN KEY (id_grupo) REFERENCES grupo(id_grupo) ON DELETE CASCADE
);


INSERT INTO contato (nm_primeiro, nm_sobrenome, apelido, dt_criacao) 
VALUES ('João', 'Silva', 'Jão', SYSTIMESTAMP);

INSERT INTO contato (nm_primeiro, nm_sobrenome, dt_criacao) 
VALUES ('Maria', 'Santos', SYSTIMESTAMP);

INSERT INTO contato (nm_primeiro, nm_sobrenome, dt_criacao) 
VALUES ('Carlos', 'Oliveira', SYSTIMESTAMP);


INSERT INTO telefone (id_contato, numero, tipo, principal)
VALUES (1, '(11) 99999-9999', 'CELULAR', 'S');

INSERT INTO telefone (id_contato, numero, tipo)
VALUES (1, '(11) 2222-2222', 'RESIDENCIAL');

INSERT INTO telefone (id_contato, numero, tipo, principal)
VALUES (2, '(21) 98888-8888', 'CELULAR', 'S');


INSERT INTO email (id_contato, endereco_email, tipo, principal)
VALUES (1, 'joao.silva@email.com', 'PESSOAL', 'S');

INSERT INTO email (id_contato, endereco_email, tipo)
VALUES (1, 'joao@empresa.com', 'PROFISSIONAL');

INSERT INTO email (id_contato, endereco_email, tipo, principal)
VALUES (2, 'maria.santos@email.com', 'PESSOAL', 'S');


INSERT INTO endereco (id_contato, logradouro, numero, bairro, cidade, uf, cep, tipo)
VALUES (1, 'Rua das Flores', '100', 'Centro', 'São Paulo', 'SP', '01001-000', 'RESIDENCIAL');

INSERT INTO endereco (id_contato, logradouro, numero, bairro, cidade, uf, cep, tipo)
VALUES (2, 'Avenida Brasil', '2000', 'Copacabana', 'Rio de Janeiro', 'RJ', '22021-000', 'RESIDENCIAL');


INSERT INTO grupo (nm_grupo, descricao)
VALUES ('Família', 'Membros da família');

INSERT INTO grupo (nm_grupo, descricao)
VALUES ('Trabalho', 'Colegas de trabalho');

INSERT INTO grupo (nm_grupo, descricao)
VALUES ('Amigos', 'Amigos próximos');


INSERT INTO contato_grupo_assoc (id_contato, id_grupo)
VALUES (1, 3);  

INSERT INTO contato_grupo_assoc (id_contato, id_grupo)
VALUES (2, 1);  

INSERT INTO contato_grupo_assoc (id_contato, id_grupo)
VALUES (2, 2);  


CREATE INDEX idx_contato_nome ON contato(nm_primeiro, nm_sobrenome);
CREATE INDEX idx_telefone_numero ON telefone(numero);
CREATE INDEX idx_email_endereco ON email(endereco_email);
CREATE INDEX idx_grupo_nome ON grupo(nm_grupo);


CREATE OR REPLACE TRIGGER trg_contato_update
BEFORE UPDATE ON contato
FOR EACH ROW
BEGIN
    :NEW.dt_ultima_atualizacao := SYSTIMESTAMP;
END;
/


CREATE OR REPLACE TRIGGER trg_telefone_principal
BEFORE INSERT OR UPDATE OF principal ON telefone
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    IF :NEW.principal = 'S' THEN
        SELECT COUNT(*) INTO v_count
        FROM telefone
        WHERE id_contato = :NEW.id_contato
        AND principal = 'S'
        AND id_telefone != NVL(:NEW.id_telefone, 0);
        
        IF v_count > 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'Apenas um telefone pode ser marcado como principal por contato');
        END IF;
    END IF;
END;
/

COMMIT;
