-- Gerado por Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   em:        2024-10-12 19:03:22 BRT
--   site:      Oracle Database 11g
--   tipo:      Oracle Database 11g



DROP TABLE t_alertas CASCADE CONSTRAINTS;

DROP TABLE t_aplicacao CASCADE CONSTRAINTS;

DROP TABLE t_cultura CASCADE CONSTRAINTS;

DROP TABLE t_irrigacao CASCADE CONSTRAINTS;

DROP TABLE t_leitura CASCADE CONSTRAINTS;

DROP TABLE t_sensor CASCADE CONSTRAINTS;

DROP TABLE t_tipo_produto CASCADE CONSTRAINTS;

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE t_alertas (
    cd_alerta INTEGER NOT NULL,
    ds_tipo   VARCHAR2(100 CHAR) NOT NULL,
    dt_alerta DATE NOT NULL,
    cd_sensor INTEGER NOT NULL
);

COMMENT ON TABLE t_alertas IS
    'Armazena os alertas gerados com base nas leituras dos sensores.';

COMMENT ON COLUMN t_alertas.cd_alerta IS
    'Código único do alerta.';

COMMENT ON COLUMN t_alertas.ds_tipo IS
    'Tipo de alerta (umidade baixa, pH fora do normal).';

COMMENT ON COLUMN t_alertas.dt_alerta IS
    'Data e hora do alerta.';

COMMENT ON COLUMN t_alertas.cd_sensor IS
    'Referencia o sensor que gerou o alerta.';

ALTER TABLE t_alertas ADD CONSTRAINT pk_t_alertas PRIMARY KEY ( cd_alerta,
                                                                cd_sensor );

CREATE TABLE t_aplicacao (
    cd_aplicacao           INTEGER NOT NULL,
    dt_aplicacao           DATE NOT NULL,
    vl_quantidade_aplicada NUMBER(10, 2) NOT NULL,
    cd_cultura             INTEGER NOT NULL,
    cd_tipo_produto        INTEGER NOT NULL
);

ALTER TABLE t_aplicacao ADD CHECK ( vl_quantidade_aplicada > 0 );

COMMENT ON TABLE t_aplicacao IS
    'Armazena informações sobre as aplicações de produtos nas culturas.';

COMMENT ON COLUMN t_aplicacao.cd_aplicacao IS
    'Código único da aplicação.';

COMMENT ON COLUMN t_aplicacao.dt_aplicacao IS
    'Data e hora da aplicação.';

COMMENT ON COLUMN t_aplicacao.vl_quantidade_aplicada IS
    'Quantidade aplicada.';

COMMENT ON COLUMN t_aplicacao.cd_cultura IS
    'Referencia a cultura que recebeu a aplicação.';

COMMENT ON COLUMN t_aplicacao.cd_tipo_produto IS
    'Referencia o tipo de produto aplicado.';

ALTER TABLE t_aplicacao ADD CONSTRAINT ck_aplicacao_qtde CHECK ( vl_quantidade_aplicada > 0 );

ALTER TABLE t_aplicacao ADD CONSTRAINT pk_t_aplicacao PRIMARY KEY ( cd_aplicacao,
                                                                    cd_tipo_produto );

CREATE TABLE t_cultura (
    cd_cultura      INTEGER NOT NULL,
    nm_cultura      VARCHAR2(100 CHAR) NOT NULL,
    dt_plantio      DATE,
    vl_area_cultivo NUMBER(10, 2) NOT NULL
);

COMMENT ON TABLE t_cultura IS
    'Armazena informações sobre as culturas plantadas';

COMMENT ON COLUMN t_cultura.cd_cultura IS
    'Código único da cultura.';

COMMENT ON COLUMN t_cultura.nm_cultura IS
    'Nome da cultura.';

COMMENT ON COLUMN t_cultura.dt_plantio IS
    'Data de plantio da cultura.';

COMMENT ON COLUMN t_cultura.vl_area_cultivo IS
    'Área de cultivo.';

ALTER TABLE t_cultura ADD CONSTRAINT pk_t_cultura PRIMARY KEY ( cd_cultura );

ALTER TABLE t_cultura ADD CONSTRAINT un_t_cultura_nm_cultura UNIQUE ( nm_cultura );

CREATE TABLE t_irrigacao (
    cd_irrigacao                INTEGER NOT NULL,
    dt_irrigacao                DATE NOT NULL,
    vl_quantidade_agua_aplicada NUMBER(10, 2) NOT NULL,
    cd_cultura                  INTEGER NOT NULL
);

COMMENT ON TABLE t_irrigacao IS
    'Armazena os eventos de irrigação das culturas.';

COMMENT ON COLUMN t_irrigacao.cd_irrigacao IS
    'Código único da irrigação.';

COMMENT ON COLUMN t_irrigacao.dt_irrigacao IS
    'Data e hora da irrigação.';

COMMENT ON COLUMN t_irrigacao.vl_quantidade_agua_aplicada IS
    'Quantidade de água aplicada.';

COMMENT ON COLUMN t_irrigacao.cd_cultura IS
    'Referencia a cultura irrigada.';

ALTER TABLE t_irrigacao ADD CONSTRAINT pk_t_irrigacao PRIMARY KEY ( cd_irrigacao );

CREATE TABLE t_leitura (
    cd_leitura       INTEGER NOT NULL,
    dt_leitura       DATE DEFAULT current_timestamp NOT NULL,
    vl_valor_leitura NUMBER(10, 2) NOT NULL,
    cd_sensor        INTEGER NOT NULL
);

COMMENT ON TABLE t_leitura IS
    'Armazena as leituras realizadas pelos sensores.';

COMMENT ON COLUMN t_leitura.cd_leitura IS
    'Código único da leitura.';

COMMENT ON COLUMN t_leitura.dt_leitura IS
    'Data e hora da leitura.';

COMMENT ON COLUMN t_leitura.vl_valor_leitura IS
    'Valor da leitura (umidade, pH, nutrientes).';

COMMENT ON COLUMN t_leitura.cd_sensor IS
    'Referencia o sensor que realizou a leitura.';

ALTER TABLE t_leitura ADD CONSTRAINT pk_t_leitura PRIMARY KEY ( cd_leitura,
                                                                cd_sensor );

CREATE TABLE t_sensor (
    cd_sensor           INTEGER NOT NULL,
    ds_tipo_sensor      VARCHAR2(50 CHAR) NOT NULL,
    vl_latitude_sensor  NUMBER(9, 6) NOT NULL,
    vl_longitude_sensor NUMBER(9, 6) NOT NULL,
    cd_cultura          INTEGER NOT NULL
);

COMMENT ON TABLE t_sensor IS
    'Armazena informações sobre os sensores utilizados para monitoramento das condições do solo.';

COMMENT ON COLUMN t_sensor.cd_sensor IS
    'Código único do sensor.';

COMMENT ON COLUMN t_sensor.ds_tipo_sensor IS
    'Tipo do sensor (umidade, pH, nutrientes).';

COMMENT ON COLUMN t_sensor.vl_latitude_sensor IS
    'Latitude da localização do sensor.';

COMMENT ON COLUMN t_sensor.vl_longitude_sensor IS
    'Longitude da localização do sensor.';

COMMENT ON COLUMN t_sensor.cd_cultura IS
    'Referencia a cultura monitorada pelo sensor.';

ALTER TABLE t_sensor
    ADD CONSTRAINT ck_sensor_latitude CHECK ( vl_latitude_sensor BETWEEN - 90 AND 90 );

ALTER TABLE t_sensor
    ADD CONSTRAINT ck_sensor_longitude CHECK ( vl_longitude_sensor BETWEEN - 180 AND 180 );

ALTER TABLE t_sensor ADD CONSTRAINT pk_t_sensor PRIMARY KEY ( cd_sensor );

CREATE TABLE t_tipo_produto (
    cd_tipo_produto   INTEGER NOT NULL,
    ds_tipo_produto   VARCHAR2(100 CHAR) NOT NULL,
    ds_unidade_medida VARCHAR2(20 CHAR) NOT NULL
);

COMMENT ON TABLE t_tipo_produto IS
    'Armazena os tipos de produtos aplicados nas culturas, como fertilizantes, pesticidas e água.';

COMMENT ON COLUMN t_tipo_produto.cd_tipo_produto IS
    'Código único do tipo de produto.';

COMMENT ON COLUMN t_tipo_produto.ds_tipo_produto IS
    'Descrição do tipo de produto.';

COMMENT ON COLUMN t_tipo_produto.ds_unidade_medida IS
    'Unidade de medida padrão (litros, quilos, etc.).';

ALTER TABLE t_tipo_produto ADD CONSTRAINT pk_t_tipo_produto PRIMARY KEY ( cd_tipo_produto );

ALTER TABLE t_alertas
    ADD CONSTRAINT fk_t_alertas_t_sensor FOREIGN KEY ( cd_sensor )
        REFERENCES t_sensor ( cd_sensor );

ALTER TABLE t_aplicacao
    ADD CONSTRAINT fk_t_aplicacao_t_cultura FOREIGN KEY ( cd_cultura )
        REFERENCES t_cultura ( cd_cultura );

ALTER TABLE t_aplicacao
    ADD CONSTRAINT fk_t_aplicacao_t_tipo_produto FOREIGN KEY ( cd_tipo_produto )
        REFERENCES t_tipo_produto ( cd_tipo_produto );

ALTER TABLE t_irrigacao
    ADD CONSTRAINT fk_t_irrigacao_t_cultura FOREIGN KEY ( cd_cultura )
        REFERENCES t_cultura ( cd_cultura );

ALTER TABLE t_leitura
    ADD CONSTRAINT fk_t_leitura_t_sensor FOREIGN KEY ( cd_sensor )
        REFERENCES t_sensor ( cd_sensor );

ALTER TABLE t_sensor
    ADD CONSTRAINT fk_t_sensor_t_cultura FOREIGN KEY ( cd_cultura )
        REFERENCES t_cultura ( cd_cultura );



-- Relatório do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             7
-- CREATE INDEX                             0
-- ALTER TABLE                             18
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
