unit ClienteController;

interface

uses
  System.SysUtils, UDmTabelas, UDmConexao;

Type
  TCliente = class
  private
    FCod_Cliente: Integer;
    FCod_Status: Integer;
    FDes_Nome: string;
    FDes_CPF: string;
    FDta_Nascimento: TDateTime;
    procedure SetDes_Nome(const Value: String);

  public
    procedure Pesquisar(sNome, campoIndice, filtro: String);
    procedure Carregar(Cliente: TCliente;  iCodigo: Integer);
    function Inserir(Cliente: TCliente; out sErro: String): Boolean;
    function Alterar(Cliente: TCliente; iCodigo: Integer; out sErro: String): Boolean;
    function Excluir(iCodigo: Integer; out sErro : String): Boolean;
    function VerificaCPFExistente(sCPF: string; out sErro : String): Boolean;

    property Cod_Cliente: Integer read FCod_Cliente write FCod_Cliente;
    property Cod_Status: Integer read FCod_Status write FCod_Status;
    property Des_Nome: string read FDes_Nome write SetDes_Nome;
    property Des_CPF: string read FDes_CPF write FDes_CPF;
    property Dta_Nascimento: TDateTime read FDta_Nascimento write FDta_Nascimento;

  end;

implementation

uses
  FireDAC.Comp.Client, FireDAC.Stan.Error;

{ TCliente }

procedure TCliente.Pesquisar(sNome, campoIndice, filtro: String);
begin
  with DmTabelas.TblClientes do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT COD_CLIENTE');
    SQL.Add(',COD_STATUS');
    SQL.Add(',DES_NOME');
    SQL.Add(',DES_CPF');
    SQL.Add(',DTA_NASCIMENTO');
    SQL.Add('FROM TAB_CLIENTE');
    SQL.Add('WHERE ' + campoIndice + ' like :pNOME');
    if filtro = 'Ativos' then
      SQL.Add('AND COD_STATUS = 0 ');

    SQL.Add('ORDER BY ' + campoIndice);
    ParamByName('PNOME').AsString := sNome + '%';
    Prepared := True;
    Open();
  end;
end;

procedure TCliente.Carregar(Cliente: TCliente; iCodigo: Integer);
var QryCliente : TFDQuery;
begin
  QryCliente := TFDQuery.Create(nil);
  try
    with QryCliente do
    begin
      Connection := DMConexao.FDConnection;
      SQL.Clear;
      SQL.Add('SELECT COD_CLIENTE');
      SQL.Add(',COD_STATUS');
      SQL.Add(',DES_NOME');
      SQL.Add(',DES_CPF');
      SQL.Add(',DTA_NASCIMENTO');
      SQL.Add('FROM TAB_CLIENTE');
      SQL.Add('WHERE COD_CLIENTE = :COD_CLIENTE');
      ParamByName('COD_CLIENTE').AsInteger := iCodigo;
      Open;

      Cliente.Cod_Cliente := FieldByName('COD_CLIENTE').AsInteger;
      Cliente.Cod_Status := FieldByName('COD_STATUS').AsInteger;
      Cliente.Des_Nome := FieldByName('DES_NOME').AsString;
      Cliente.Des_CPF := FieldByName('DES_CPF').AsString;
      Cliente.Dta_Nascimento := FieldByName('DTA_NASCIMENTO').AsDateTime;

    end;
  finally
    FreeAndNil(QryCliente);
  end;

end;

function TCliente.Inserir(Cliente: TCliente; out sErro: String): Boolean;
begin
  with DmTabelas.QryInserir, Cliente do
  begin

    Close;
    SQL.Clear;
    SQL.Add('INSERT INTO TAB_CLIENTE( ');
    SQL.Add('COD_STATUS');
    SQL.Add(',DES_NOME');
    SQL.Add(',DES_CPF');
    SQL.Add(',DTA_NASCIMENTO) ');
    SQL.Add('VALUES (:COD_STATUS, ');
    SQL.Add(':DES_NOME');
    SQL.Add(',:DES_CPF');
    SQL.Add(',:DTA_NASCIMENTO)');

    ParamByName('COD_STATUS').AsInteger := Cod_Status;
    ParamByName('DES_NOME').AsString := Des_Nome;
    ParamByName('DES_CPF').AsString := Des_CPF;
    ParamByName('DTA_NASCIMENTO').AsDate := Dta_Nascimento;

    // Inicia Transação
    DMConexao.FDConnection.StartTransaction;

    try
      Prepared := True;
      ExecSQL;
      Result := True;
      DMConexao.FDConnection.Commit;
    except
      on E: Exception do
      begin
        Result := False;
        sErro := 'Ocorreu um erro ao inserir um novo cliente !' + sLineBreak + E.Message;
        DMConexao.FDConnection.Rollback;
        raise;
      end;
    end;
  end;
end;

function TCliente.Alterar(Cliente: TCliente; iCodigo: Integer; out sErro: String): Boolean;
begin
  with DmTabelas.QryAlterar, Cliente do
  begin
    Result := False;
    Close;
    SQL.Clear;
    SQL.Add('UPDATE TAB_CLIENTE SET ');
    Sql.Add('COD_STATUS = :COD_STATUS ');
    SQL.Add(',DES_NOME = :DES_NOME');
    SQL.Add(',DES_CPF = :DES_CPF');
    SQL.Add(',DTA_NASCIMENTO = :DTA_NASCIMENTO');
    SQL.Add('WHERE COD_CLIENTE = :COD_CLIENTE');

    ParamByName('COD_STATUS').AsInteger := Cod_Status;
    ParamByName('DES_NOME').AsString := Des_Nome;
    ParamByName('DES_CPF').AsString := Des_CPF;
    ParamByName('DTA_NASCIMENTO').AsDate := Dta_Nascimento;
    ParamByName('COD_CLIENTE').AsInteger := iCodigo;

    // Inicia Transação
    DMConexao.FDConnection.StartTransaction;

    try
      Prepared := True;
      ExecSQL();
    except on E: Exception do
      begin
        sErro := 'Ocorreu um erro ao alterar os dados do cliente !' + sLineBreak + E.Message;
        DMConexao.FDConnection.Rollback;
        Result := False;
        raise;
      end;
    end;
    Result:= True;
    DMConexao.FDConnection.Commit;
  end;
end;

function TCliente.Excluir(iCodigo: Integer; out sErro: String): Boolean;
begin
  with DmTabelas.QryExcluir do
  begin
    Close;
    SQL.Clear;
    SQL.Text := 'DELETE FROM TAB_CLIENTE WHERE COD_CLIENTE = :COD_CLIENTE';
    ParamByName('COD_CLIENTE').AsInteger := iCodigo;

    // Inicia Transação
    DMConexao.FDConnection.StartTransaction;

    try
      Prepared := True;
      ExecSQL();
      Result := True;
      DMConexao.FDConnection.Commit;
    except on E: Exception do
      begin
        sErro := 'Ocorreu um erro ao excluir o cliente !' + sLineBreak + E.Message;
        Result := False;
        DMConexao.FDConnection.Rollback;
        raise;
      end;
    end;
  end;
end;

function TCliente.VerificaCPFExistente(sCPF: string;  out sErro: String): Boolean;
var QryTemp : TFDQuery;
begin
  QryTemp := TFDQuery.Create(nil);
  Result := False;
  try
    with QryTemp do
    begin
      Connection := DMConexao.FDConnection;
      SQL.Clear;
      SQL.Add('SELECT COUNT(*) AS QUANT');
      SQL.Add('FROM TAB_CLIENTE');
      SQL.Add('WHERE DES_CPF = :DES_CPF');
      ParamByName('DES_CPF').AsString := sCPF;
      Open;
      if FieldByName('QUANT').AsInteger = 0 then
        Result := True;
    end;
  finally
    FreeAndNil(QryTemp);
  end;
end;

procedure TCliente.SetDes_Nome(const Value: String);
begin
  if Value = EmptyStr then
    raise EArgumentException.Create('O campo ''Descrição'' precisa ser preenchido !');

  FDes_Nome := Value;
end;


end.
