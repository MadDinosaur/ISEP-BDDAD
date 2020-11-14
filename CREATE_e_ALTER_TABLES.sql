
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
    dataReserva         Date Constraint nnReservaDataReserva         NOT NULL,
    numeroPessoas       Integer Constraint nnReservaNrPessoas        NOT NULL,
    dataCancelamento    Date,
    custoCancelamento   Integer,
    numeroAndar         Integer Constraint nnReservaNrAndar         NOT NULL,
    numeroSequencial    Integer Constraint nnReservaNrSequencial    NOT NULL,
    estado              Varchar(30) Constraint nnReservaEstado      NOT NULL,
    clienteNif          Integer Constraint nnReservaClienteNIF      NOT NULL,
    CONSTRAINT ck_datas CHECK(dataSaída > dataEntrada),
    CONSTRAINT ck_entrada UNIQUE(dataEntrada, numeroAndar, numeroSequencial),
    CONSTRAINT ck_saida UNIQUE(dataSaida, numeroAndar, numeroSequencial)
);

Create Table Quarto (
    numeroAndar         Integer Constraint nnQuartoNrAndar         NOT NULL,
    numeroSequencial    Integer Constraint nnQuartoNrSequencial    NOT NULL,
    tipoQuarto          Varchar(10) Constraint nnQuartoTipoQuarto  NOT NULL,
    lotacaoMax          Integer Constraint nnQuartoLotacaoMax      NOT NULL,
    Constraint pkQuartoNumeroAndarNumeroSequencial  PRIMARY KEY (numeroAndar,numeroSequencial)
);
Create Table Andar (
    numeroAndar         Integer     CONSTRAINT pkAndarNumeroAndar           PRIMARY KEY,
                                    CONSTRAINT nnAndarNrAndar               NOT NULL,
    nome                Varchar(30) CONSTRAINT nnAndarNome                  NOT NULL
);
Create Table TipoQuarto (
    tipoQuarto          Varchar(10)     CONSTRAINT pkTipoQuarto                 PRIMARY KEY,
                                        CONSTRAINT nnTipoQuarto                 NOT NULL
);
Create Table PrecoReserva(
    tipoQuarto          Varchar(10) Constraint nnPrecoReservaTipoQuarto NOT NULL,
    nomeEpoca           Varchar(10) Constraint nnPrecoReservaNomeEpoca  NOT NULL,
    Constraint pkPrecoReservaTipoQuartoNomeEpoca    PRIMARY KEY (tipoQuarto,nomeEpoca)
);
Create Table EpocaAno (
    nomeEpoca           Varchar(10)     Constraint pkEpocaAnoNomeEpoca          PRIMARY KEY,
                                        Constraint nnEpocaAnoNomeEpoca          NOT NULL,
    dataInicio          Date            Constraint ukEpocaAnoDataInicio         UNIQUE,
                                        Constraint nnEpocaAnoDataInicio         NOT NULL,
    dataFim             Date            Constraint ukEpocaAnoDataFim            UNIQUE,
                                        Constraint nnEpocaAnoDataFim            NOT NULL,
    CONSTRAINT ck_datas CHECK(dataFim > dataInicio)
);
Create Table Conta (
    nrConta             Integer     Constraint pkContaNrConta               PRIMARY KEY,
                                    Constraint nnContaNrConta               NOT NULL,
    dataAbertura        Date        Constraint nnContaDataAbertura          NOT NULL,
    codReserva          Integer     Constraint nnContaCodReserva            NOT NULL
);
Create Table Consumos (
    dataConsumos        Date        Constraint pkConsumosDataConsumos       PRIMARY KEY,
                                    Constraint nnConsumosDataConsumos       NOT NULL, 
    produto             Varchar(30) Constraint nnConsumosProduto            NOT NULL,     
    custo               Integer     Constraint nnConsumosCusto              NOT NULL,
    nrConta             Integer     Constraint nnConsumosNrConta            NOT NULL
);
Create Table Cliente (
    NIF                 Integer     Constraint pkClienteNIF                 PRIMARY KEY,
                                    Constraint nnClienteNIF                 NOT NULL,
    nome                Varchar(50) Constraint nnClienteNome                NOT NULL,
    email               Varchar(50) Constraint nnClienteEmail               NOT NULL,
    telefone            Integer     Constraint nnClienteTelefone            NOT NULL,
    localidade          Varchar(50) Constraint nnClienteLocalidade          NOT NULL,
    concelho            Varchar(50) Constraint nnClienteConcelho            NOT NULL
);
Create Table Fatura (
    nrFatura            Integer     Constraint pkFaturaNrFatura             PRIMARY KEY,
                                    Constraint nnFaturaNrFatura             NOT NULL,
    codReserva          Integer     Constraint nnCodReserva                 NOT NULL
);
Create Table PagamentoFatura (
    nrFatura            Integer     Constraint nnPagamentoFaturaNrFatura    NOT NULL,
    designacao          Varchar(30) Constraint nnPagamentoFaturaDesignacao  NOT NULL,
    Constraint pkPAgamentoFAturaNrFaturaDesignacao PRIMARY KEY (nrFatura,designacao)
);
Create Table TipoPagamento (
    designacao          Varchar(30) Constraint pkTipoPagamentoDesignacao   PRIMARY KEY,
                                    Constraint nnTipoPagamentoDesignacao    NOT NULL
);
Create Table EstadoReserva (
    descricao           Varchar(30) Constraint  pkEstadoReservaDescricao    PRIMARY KEY,
                                    Constraint nnEstadoReservaDescricao     NOT NULL
);
Create Table Manutencao (
    numeroAndar         Integer Constraint nnManutancaoNrAndar           NOT NULL,
    numeroSequencial    Integer Constraint nnManutancaoNrSequencial      NOT NULL,
    funcionarioNIF      Integer Constraint nnManutancaoFuncionarioNIF    NOT NULL,
    equipamento         Varchar(10) Constraint nnManutancaoEquipamento   NOT NULL,
    data                Timestamp Constraint nnManutancaoData            NOT NULL,
    estado              Varchar(10) Constraint nnManutancaoEstado        NOT NULL,
    Constraint pkManutencao PRIMARY KEY (numeroAndar,numeroSequencial,funcionarioNIF,data)
);
Create Table Limpeza (
    numeroAndar         Integer Constraint nnLimpezaNrAndar         NOT NULL,
    numeroSequencial    Integer Constraint nnLimpezaNrSequecial     NOT NULL,
    funcionarioNIF      Integer Constraint nnLimpezaFuncionarioNIF  NOT NULL,
    data                Timestamp Constraint nnLimpezaData          NOT NULL,
    Constraint pkLimpeza PRIMARY KEY (numeroAndar,numeroSequencial,funcionarioNIF,data)
);
Create Table Funcionario(
    NIF      INTEGER     Constraint pkFuncionarioNIF                PRIMARY KEY,
                         Constraint nnFuncionarioNIF                NOT NULL,
    nome                Varchar(50) Constraint nnFuncionarioNome    NOT NULL,
    morada              Varchar(50),
    telefone            Integer Constraint nnFuncionarioTelefone    NOT NULL,
    email               Varchar(50) Constraint nnFuncionarioEmail   NOT NULL
);
Create Table FuncionarioCamareira (
    funcionarioNIF      INTEGER     Constraint pkFuncionarioCamareiraNIF             PRIMARY KEY,
                                    Constraint nnFuncionarioCamareiraNIF             NOT NULL
);
Create Table FuncionarioManutencao (
    funcionarioNIF      INTEGER     Constraint pkFuncionarioManutencaoNIF             PRIMARY KEY,
                                    Constraint nnFuncionarioManutencaoNIF             NOT NULL,
    telefoneServico     Integer     Constraint nnFuncionarioManutencaoTelefone        NOT NULL,
    chefeNIF            Integer
);
Create Table FuncionarioRestaurante (
    funcionarioNIF      INTEGER     Constraint pkFuncionarioRestauranteNIF             PRIMARY KEY,
                                    Constraint nnFuncionarioRestauranteNIF             NOT NULL
);
Create Table FuncionarioRececao (
    funcionarioNIF      INTEGER     Constraint pkFuncionarioRececaoNIF             PRIMARY KEY,
                                    Constraint nnFuncionarioRececaoNIF             NOT NULL
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