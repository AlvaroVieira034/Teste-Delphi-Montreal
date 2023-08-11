unit FornecedorController;

interface

uses
  System.SysUtils, UDmTabelas, UDmConexao;

Type
  TFornecedor = class
  private
    FCod_Fornecedor: Integer;
    FCod_Status: Integer;
    FDes_Razao_Social: string;
    FDes_Nome_Fantasia: string;
    FDes_CNPJ: string;
    procedure SetDes_Razao_Social(const Value: String);

  public
    procedure Pesquisar(sNome, campoIndice, filtro: String);
    procedure Carregar(Fornecedor: TFornecedor;  iCodigo: Integer);
    function Inserir(Fornecedor: TFornecedor; out sErro: String): Boolean;
    function Alterar(Fornecedor: TFornecedor; iCodigo: Integer; out sErro: String): Boolean;
    function Excluir(iCodigo: Integer; out sErro : String): Boolean;
    function VerificaCNPJExistente(sCNPJ: string; out sErro : String): Boolean;

    property Cod_Fornecedor: Integer read FCod_Fornecedor write FCod_Fornecedor;
    property Cod_Status: Integer read FCod_Status write FCod_Status;
    property Des_Razao_Social: string read FDes_Razao_Social write SetDes_Razao_Social;
    property Des_Nome_Fantasia: string read FDes_Nome_Fantasia write FDes_Nome_Fantasia;
    property Des_CNPJ: string read FDes_CNPJ write FDes_CNPJ;

  end;

implementation

uses
  FireDAC.Comp.Client, FireDAC.Stan.Error;

{ TFornecedor }

procedure TFornecedor.Pesquisar(sNome, campoIndice, filtro: String);
begin
  with DmTabelas.TblFornecedores do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT COD_FORNECEDOR');
    SQL.Add(',COD_STATUS');
    SQL.Add(',DES_RAZAO_SOCIAL');
    SQL.Add(',DES_NOME_FANTASIA');
    SQL.Add(',DES_CNPJ');
    SQL.Add('FROM TAB_FORNECEDOR');
    SQL.Add('WHERE ' + campoIndice + ' like :pNOME');
    if filtro = 'Ativos' then
      SQL.Add('AND COD_STATUS = 0 ');

    SQL.Add('ORDER BY ' + campoIndice);
    ParamByName('PNOME').AsString := sNome + '%';
    Prepared := True;
    Open();
  end;
end;

procedure TFornecedor.Carregar(Fornecedor: TFornecedor; iCodigo: Integer);
var QryFornecedor : TFDQuery;
begin
  QryFornecedor := TFDQuery.Create(nil);
  try
    with QryFornecedor do
    begin
      Connection := DMConexao.FDConnection;
      SQL.Clear;
      SQL.Add('SELECT COD_FORNECEDOR');
      SQL.Add(',COD_STATUS');
      SQL.Add(',DES_RAZAO_SOCIAL');
      SQL.Add(',DES_NOME_FANTASIA');
      SQL.Add(',DES_CNPJ');
      SQL.Add('FROM TAB_FORNECEDOR');
      SQL.Add('WHERE COD_FORNECEDOR = :COD_FORNECEDOR');

      ParamByName('COD_FORNECEDOR').AsInteger := iCodigo;
      Open;

      Fornecedor.Cod_Fornecedor := FieldByName('COD_FORNECEDOR').AsInteger;
      Fornecedor.Cod_Status := FieldByName('COD_STATUS').AsInteger;
      Fornecedor.Des_Razao_Social := FieldByName('DES_RAZAO_SOCIAL').AsString;
      Fornecedor.Des_Nome_Fantasia := FieldByName('DES_NOME_FANTASIA').AsString;
      Fornecedor.Des_CNPJ := FieldByName('DES_CNPJ').AsString;

    end;
  finally
    FreeAndNil(QryFornecedor);
  end;
end;

function TFornecedor.Inserir(Fornecedor: TFornecedor; out sErro: String): Boolean;
begin
  with DmTabelas.QryInserir, Fornecedor do
  begin

    Close;
    SQL.Clear;
    SQL.Add('INSERT INTO TAB_FORNECEDOR( ');
    SQL.Add('COD_STATUS');
    SQL.Add(',DES_RAZAO_SOCIAL');
    SQL.Add(',DES_NOME_FANTASIA');
    SQL.Add(',DES_CNPJ) ');
    SQL.Add('VALUES (:COD_STATUS, ');
    SQL.Add(':DES_RAZAO_SOCIAL');
    SQL.Add(',:DES_NOME_FANTASIA');
    SQL.Add(',:DES_CNPJ)');

    ParamByName('COD_STATUS').AsInteger := Cod_Status;
    ParamByName('DES_RAZAO_SOCIAL').AsString := Des_Razao_Social;
    ParamByName('DES_NOME_FANTASIA').AsString := Des_Nome_Fantasia;
    ParamByName('DES_CNPJ').AsString := Des_CNPJ;

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
        sErro := 'Ocorreu um erro ao inserir um novo fornecedor !' + sLineBreak + E.Message;
        DMConexao.FDConnection.Rollback;
        raise;
      end;
    end;
  end;
end;

function TFornecedor.Alterar(Fornecedor: TFornecedor; iCodigo: Integer; out sErro: String): Boolean;
begin
  with DmTabelas.QryAlterar, Fornecedor do
  begin
    Result := False;
    Close;
    SQL.Clear;
    SQL.Add('UPDATE TAB_FORNECEDOR SET ');
    Sql.Add('COD_STATUS = :COD_STATUS ');
    SQL.Add(',DES_RAZAO_SOCIAL = :DES_RAZAO_SOCIAL');
    SQL.Add(',DES_NOME_FANTASIA = :DES_NOME_FANTASIA');
    SQL.Add(',DES_CNPJ = :DES_CNPJ');
    SQL.Add('WHERE COD_FORNECEDOR = :COD_FORNECEDOR');

    ParamByName('COD_STATUS').AsInteger := Cod_Status;
    ParamByName('DES_RAZAO_SOCIAL').AsString := Des_Razao_Social;
    ParamByName('DES_NOME_FANTASIA').AsString := Des_Nome_Fantasia;
    ParamByName('DES_CNPJ').AsString := Des_CNPJ;
    ParamByName('COD_FORNECEDOR').AsInteger := iCodigo;

    // Inicia Transação
    DMConexao.FDConnection.StartTransaction;

    try
      Prepared := True;
      ExecSQL();
    except on E: Exception do
      begin
        sErro := 'Ocorreu um erro ao alterar os dados do fornecedor !' + sLineBreak + E.Message;
        DMConexao.FDConnection.Rollback;
        Result := False;
        raise;
      end;
    end;
    Result:= True;
    DMConexao.FDConnection.Commit;
  end;
end;

function TFornecedor.Excluir(iCodigo: Integer; out sErro: String): Boolean;
begin
  with DmTabelas.QryExcluir do
  begin
    Close;
    SQL.Clear;
    SQL.Text := 'DELETE FROM TAB_FORNECEDOR WHERE COD_FORNECEDOR = :COD_FORNECEDOR';
    ParamByName('COD_FORNECEDOR').AsInteger := iCodigo;

    // Inicia Transação
    DMConexao.FDConnection.StartTransaction;

    try
      Prepared := True;
      ExecSQL();
      Result := True;
      DMConexao.FDConnection.Commit;
    except on E: Exception do
      begin
        sErro := 'Ocorreu um erro ao excluir o fornecedor !' + sLineBreak + E.Message;
        Result := False;
        DMConexao.FDConnection.Rollback;
        raise;
      end;
    end;
  end;
end;

function TFornecedor.VerificaCNPJExistente(sCNPJ: string;  out sErro: String): Boolean;
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
      SQL.Add('FROM TAB_FORNECEDOR');
      SQL.Add('WHERE DES_CNPJ = :DES_CNPJ');
      ParamByName('DES_CNPJ').AsString := sCNPJ;
      Open;
      if FieldByName('QUANT').AsInteger = 0 then
        Result := True;
    end;
  finally
    FreeAndNil(QryTemp);
  end;
end;

procedure TFornecedor.SetDes_Razao_Social(const Value: String);
begin
  if Value = EmptyStr then
    raise EArgumentException.Create('O campo ''Razão Social'' precisa ser preenchido !');

  FDes_Razao_Social := Value;
end;


end.
