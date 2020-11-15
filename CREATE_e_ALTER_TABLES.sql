
DROP TABLE Reserva                  CASCADE CONSTRAINTS PURGE;
DROP TABLE Quarto                   CASCADE CONSTRAINTS PURGE;
DROP TABLE Andar                    CASCADE CONSTRAINTS PURGE;
DROP TABLE TipoQuarto               CASCADE CONSTRAINTS PURGE;
DROP TABLE PrecoReserva             CASCADE CONSTRAINTS PURGE;
DROP TABLE EpocaAno                 CASCADE CONSTRAINTS PURGE;
DROP TABLE Conta                    CASCADE CONSTRAINTS PURGE;
DROP TABLE Consumos                 CASCADE CONSTRAINTS PURGE;
DROP TABLE Cliente                  CASCADE CONSTRAINTS PURGE;
DROP TABLE Fatura                   CASCADE CONSTRAINTS PURGE;
DROP TABLE PagamentoFatura          CASCADE CONSTRAINTS PURGE;
DROP TABLE TipoPagamento            CASCADE CONSTRAINTS PURGE;
DROP TABLE EstadoReserva            CASCADE CONSTRAINTS PURGE;
DROP TABLE Manutencao               CASCADE CONSTRAINTS PURGE;
DROP TABLE Limpeza                  CASCADE CONSTRAINTS PURGE;
DROP TABLE Funcionario              CASCADE CONSTRAINTS PURGE;
DROP TABLE FuncionarioCamareira     CASCADE CONSTRAINTS PURGE;
DROP TABLE FuncionarioManutencao    CASCADE CONSTRAINTS PURGE;
DROP TABLE FuncionarioRestaurante   CASCADE CONSTRAINTS PURGE;
DROP TABLE FuncionarioRececao       CASCADE CONSTRAINTS PURGE;

Create Table Reserva (
    codReserva          Integer GENERATED ALWAYS AS IDENTITY CONSTRAINT pkReservaCodReserva     PRIMARY KEY,
    dataEntrada         Date Constraint nnReservaDataEntrada         NOT NULL,
    dataSaida           Date Constraint nnReservaDataSaida           NOT NULL,
    tipoQuarto          Varchar(10) Constraint nnReservaTipoQuarto   NOT NULL,
    dataReserva         Timestamp Constraint nnReservaDataReserva         NOT NULL,
    numeroPessoas       Integer Constraint nnReservaNrPessoas        NOT NULL,
    dataCancelamento    Date,
    custoCancelamento   Integer,
    numeroAndar         Integer Constraint nnReservaNrAndar         NOT NULL,
    numeroSequencial    Integer Constraint nnReservaNrSequencial    NOT NULL,
    estado              Varchar(30) DEFAULT 'reservada',
    clienteNif          Integer Constraint nnReservaClienteNIF      NOT NULL,
    CONSTRAINT ck_datas CHECK(dataSaida > dataEntrada),
    CONSTRAINT ck_entrada UNIQUE(dataEntrada, numeroAndar, numeroSequencial),
    CONSTRAINT ck_saida UNIQUE(dataSaida, numeroAndar, numeroSequencial),
    CONSTRAINT ck_dataReserva CHECK(dataReserva < dataEntrada),
    CONSTRAINT ck_cliente UNIQUE(dataEntrada, clienteNif)
);

Create Table Quarto (
    numeroAndar         Integer Constraint nnQuartoNrAndar         NOT NULL,
    numeroSequencial    Integer GENERATED ALWAYS AS IDENTITY,
    tipoQuarto          Varchar(10) Constraint nnQuartoTipoQuarto  NOT NULL,
    lotacaoMax          Integer Constraint nnQuartoLotacaoMax      NOT NULL,
    Constraint pkQuartoNumeroAndarNumeroSequencial  PRIMARY KEY (numeroAndar,numeroSequencial)
);
Create Table Andar (
    numeroAndar         Integer     CONSTRAINT pkAndarNumeroAndar           PRIMARY KEY,
    nome                Varchar(30) CONSTRAINT nnAndarNome                  NOT NULL
);
Create Table TipoQuarto (
    tipoQuarto          Varchar(10)     CONSTRAINT pkTipoQuarto                 PRIMARY KEY
);
Create Table PrecoReserva(
    tipoQuarto          Varchar(10) Constraint nnPrecoReservaTipoQuarto NOT NULL,
    nomeEpoca           Varchar(10) Constraint nnPrecoReservaNomeEpoca  NOT NULL,
    Constraint pkPrecoReservaTipoQuartoNomeEpoca    PRIMARY KEY (tipoQuarto,nomeEpoca)
);
Create Table EpocaAno (
    nomeEpoca           Varchar(10)     Constraint pkEpocaAnoNomeEpoca          PRIMARY KEY,
    dataInicio          Date            Constraint ukEpocaAnoDataInicio         UNIQUE,
    dataFim             Date            Constraint ukEpocaAnoDataFim            UNIQUE,
    CONSTRAINT ck_datas_epoca CHECK(dataFim > dataInicio)
);
Create Table Conta (
    nrConta             Integer     GENERATED ALWAYS AS IDENTITY Constraint pkContaNrConta               PRIMARY KEY,
    dataAbertura        Date        Constraint nnContaDataAbertura          NOT NULL,
    codReserva          Integer     Constraint nnContaCodReserva            NOT NULL
);
Create Table Consumos (
    dataConsumos        Date        Constraint pkConsumosDataConsumos       PRIMARY KEY,
    produto             Varchar(30) Constraint nnConsumosProduto            NOT NULL,     
    custo               Integer     Constraint nnConsumosCusto              NOT NULL,
    nrConta             Integer     Constraint nnConsumosNrConta            NOT NULL
);
Create Table Cliente (
    NIF                 Integer     Constraint pkClienteNIF                 PRIMARY KEY,
                                    Constraint check_NIF    check(REGEXP_LIKE(NIF, '^\d{9}$')),
    nome                Varchar(50) Constraint nnClienteNome                NOT NULL,
    email               Varchar(50) Constraint check_email check(REGEXP_LIKE(email, '@{1}')),
    telefone            Integer     Constraint check_telefone    check(REGEXP_LIKE(telefone, '^\d{9}$')),
    localidade          Varchar(50) Constraint nnClienteLocalidade          NOT NULL,
    concelho            Varchar(50) Constraint nnClienteConcelho            NOT NULL
);
Create Table Fatura (
    nrFatura            Integer     GENERATED ALWAYS AS IDENTITY Constraint pkFaturaNrFatura             PRIMARY KEY,
    codReserva          Integer     Constraint nnFaturaCodReserva                 NOT NULL,
    total               Integer     Constraint nnFaturaTotal                      NOT NULL
);
Create Table PagamentoFatura (
    nrFatura            Integer     Constraint nnPagamentoFaturaNrFatura    NOT NULL,
    designacao          Varchar(30) Constraint nnPagamentoFaturaDesignacao  NOT NULL,
    Constraint pkPAgamentoFAturaNrFaturaDesignacao PRIMARY KEY (nrFatura,designacao)
);
Create Table TipoPagamento (
    designacao          Varchar(30) Constraint pkTipoPagamentoDesignacao   PRIMARY KEY
);
Create Table EstadoReserva (
    descricao           Varchar(30) Constraint  pkEstadoReservaDescricao    PRIMARY KEY
);
Create Table Manutencao (
    idManutencao        Integer GENERATED ALWAYS AS IDENTITY Constraint pkManutencao PRIMARY KEY,
    numeroAndar         Integer Constraint nnManutancaoNrAndar           NOT NULL,
    numeroSequencial    Integer Constraint nnManutancaoNrSequencial      NOT NULL,
    funcionarioNIF      Integer Constraint nnManutancaoFuncionarioNIF    NOT NULL,
    equipamento         Varchar(50) Constraint nnManutancaoEquipamento   NOT NULL,
    data                Timestamp,
    Constraint check_manutencao UNIQUE (numeroAndar, numeroSequencial, funcionarioNIF, data)
);
Create Table Limpeza (
    numeroAndar         Integer Constraint nnLimpezaNrAndar         NOT NULL,
    numeroSequencial    Integer Constraint nnLimpezaNrSequecial     NOT NULL,
    funcionarioNIF      Integer Constraint nnLimpezaFuncionarioNIF  NOT NULL,
    data                Timestamp Constraint nnLimpezaData          NOT NULL,
    Constraint pkLimpeza PRIMARY KEY (numeroAndar,numeroSequencial,funcionarioNIF,data)
);
Create Table Funcionario(
    NIF      INTEGER    Constraint pkFuncionarioNIF                PRIMARY KEY,
                        Constraint check_NIF_funcionario            check(REGEXP_LIKE(NIF, '^\d{9}$')),
    nome                Varchar(50) Constraint nnFuncionarioNome    NOT NULL,
    morada              Varchar(50),
    telefone            Integer Constraint nnFuncionarioTelefone    NOT NULL,
                                Constraint check_telefone_funcionario   check(REGEXP_LIKE(telefone, '^\d{9}$')),
    email               Varchar(50) Constraint nnFuncionarioEmail   NOT NULL,
                                    Constraint check_email_funcionario check(REGEXP_LIKE(email, '@{1}'))
);
Create Table FuncionarioCamareira (
    funcionarioNIF      INTEGER     Constraint pkFuncionarioCamareiraNIF             PRIMARY KEY,
                                    Constraint check_NIF_camareira          check(REGEXP_LIKE(funcionarioNIF, '^\d{9}$'))
);
Create Table FuncionarioManutencao (
    funcionarioNIF      INTEGER     Constraint pkFuncionarioManutencaoNIF             PRIMARY KEY,
                                    Constraint check_NIF_manutencao          check(REGEXP_LIKE(funcionarioNIF, '^\d{9}$')),
    telefoneServico     Integer     Constraint nnFuncionarioManutencaoTelefone        NOT NULL,
                                    Constraint check_telefone_manutencao   check(REGEXP_LIKE(telefoneServico, '^\d{9}$')),
    chefeNIF            Integer
);
Create Table FuncionarioRestaurante (
    funcionarioNIF      INTEGER     Constraint pkFuncionarioRestauranteNIF             PRIMARY KEY,
                                     Constraint check_NIF_restaurante         check(REGEXP_LIKE(funcionarioNIF, '^\d{9}$'))
);
Create Table FuncionarioRececao (
    funcionarioNIF      INTEGER     Constraint pkFuncionarioRececaoNIF             PRIMARY KEY,
                                    Constraint check_NIF_rececao        check(REGEXP_LIKE(funcionarioNIF, '^\d{9}$'))
);

ALTER TABLE Reserva ADD CONSTRAINT fkReservaNumeroAndarNumeroSequencial FOREIGN KEY (numeroAndar,numeroSequencial) REFERENCES Quarto (numeroAndar,numeroSequencial);
ALTER TABLE Reserva ADD CONSTRAINT fkEstado FOREIGN KEY (estado) REFERENCES  EstadoReserva(descricao);
ALTER TABLE Reserva ADD CONSTRAINT fkReservaClienteNIF FOREIGN KEY (ClienteNIF) REFERENCES Cliente (NIF);

ALTER TABLE Quarto ADD CONSTRAINT fkQuartoNumeroAndar FOREIGN KEY (numeroAndar) REFERENCES Andar (numeroAndar);
ALTER TABLE Quarto ADD CONSTRAINT fkQuartoTipoQuarto FOREIGN KEY (tipoQuarto) REFERENCES TipoQuarto (tipoQuarto);

ALTER TABLE PrecoReserva ADD CONSTRAINT fkPrecoReservaTipoQuarto FOREIGN KEY (tipoQuarto) REFERENCES TipoQuarto (tipoQuarto);
ALTER TABLE PrecoReserva ADD CONSTRAINT fkPrecoReservaNomeEpoca FOREIGN KEY (nomeEpoca) REFERENCES EpocaAno (nomeEpoca);

ALTER TABLE Conta ADD CONSTRAINT fkContaNrConta FOREIGN KEY (codReserva) REFERENCES Reserva (codReserva);

ALTER TABLE Consumos ADD CONSTRAINT fkConsumos FOREIGN KEY (nrConta) REFERENCES Conta (nrConta);

ALTER TABLE Fatura ADD CONSTRAINT fkFaturaCodReserva FOREIGN KEY (codReserva) REFERENCES Reserva (codReserva);

ALTER TABLE PagamentoFatura ADD CONSTRAINT fkPagamentoFaturaNrFatura FOREIGN KEY (nrFatura) REFERENCES Fatura (nrFatura);
ALTER TABLE PagamentoFatura ADD CONSTRAINT fkPagamentoFaturaDesignacao FOREIGN KEY (designacao) REFERENCES TipoPagamento (designacao);

ALTER TABLE Limpeza ADD CONSTRAINT fkLimpezaNumeroAndarNumeroSequencial FOREIGN KEY (numeroAndar,numeroSequencial) REFERENCES Quarto (numeroAndar,numeroSequencial);
ALTER TABLE Limpeza ADD CONSTRAINT fkLimpezaFuncionarioNIF FOREIGN KEY (funcionarioNIF) REFERENCES Funcionario (NIF);

ALTER TABLE Manutencao ADD CONSTRAINT fkMAnutencaoNumeroAndarNumeroSequencial FOREIGN KEY (numeroAndar,numeroSequencial) REFERENCES Quarto (numeroAndar,numeroSequencial);
ALTER TABLE Manutencao ADD CONSTRAINT fkManutencaoFuncionarioNIF FOREIGN KEY (funcionarioNIF) REFERENCES Funcionario (NIF);

ALTER TABLE FuncionarioCamareira ADD CONSTRAINT fkCamareiraFuncionarioNIF FOREIGN KEY (funcionarioNIF) REFERENCES Funcionario (NIF);

ALTER TABLE FuncionarioManutencao ADD CONSTRAINT fkFuncionarioManutencaoFuncionarioNIF FOREIGN KEY (funcionarioNIF) REFERENCES Funcionario (NIF);
ALTER TABLE FuncionarioManutencao ADD CONSTRAINT fkFuncionarioManutencaoChefeNIF FOREIGN KEY (ChefeNIF) REFERENCES FuncionarioManutencao (funcionarioNIF);

ALTER TABLE FuncionarioRestaurante ADD CONSTRAINT fkFuncionarioRestauranteFuncionarioNIF FOREIGN KEY (funcionarioNIF) REFERENCES Funcionario (NIF);

ALTER TABLE FuncionarioRececao ADD CONSTRAINT fkFuncionarioRececaoFuncionarioNIF FOREIGN KEY (funcionarioNIF) REFERENCES Funcionario (NIF);