unit ProdutoController;

interface

uses
  System.SysUtils, UDmTabelas, UDmConexao;

Type
  TProduto = class
  private
    FCod_Produto: Integer;
    FCod_Status: Integer;
    FDes_Descricao: string;
    FVal_Preco_Unitario: Double;
    FCod_Fornecedor: Integer;
    procedure SetDes_Descricao(const Value: String);

  public
    procedure Pesquisar(sNome, campoIndice, filtro: String);
    procedure Carregar(Produto: TProduto;  iCodigo: Integer);
    function Inserir(Produto: TProduto; out sErro: String): Boolean;
    function Alterar(Produto: TProduto; iCodigo: Integer; out sErro: String): Boolean;
    function Excluir(iCodigo: Integer; out sErro : String): Boolean;
    function RetornaValorUnitario(iCodigo: integer): Double;

    property Cod_Produto: Integer read FCod_Produto write FCod_Produto;
    property Cod_Status: Integer read FCod_Status write FCod_Status;
    property Des_Descricao: string read FDes_Descricao write SetDes_Descricao;
    property Val_Preco_Unitario: Double read FVal_Preco_Unitario write FVal_Preco_Unitario;
    property Cod_Fornecedor: Integer read FCod_Fornecedor write FCod_Fornecedor;

  end;

implementation

uses
  FireDAC.Comp.Client, FireDAC.Stan.Error;

{ TProduto }

procedure TProduto.Pesquisar(sNome, campoIndice, filtro: String);
begin
  with DmTabelas.TblProdutos do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT PRD.COD_PRODUTO');
    SQL.Add(',PRD.COD_STATUS');
    SQL.Add(',PRD.DES_DESCRICAO');
    SQL.Add(',PRD.VAL_PRECO_UNITARIO');
    SQL.Add(',PRD.COD_FORNECEDOR');
    SQL.Add(',FRN.DES_NOME_FANTASIA');
    SQL.Add('FROM TAB_PRODUTO PRD');
    SQL.Add('INNER JOIN TAB_FORNECEDOR FRN ON PRD.COD_FORNECEDOR = FRN.COD_FORNECEDOR');
    SQL.Add('WHERE ' + campoIndice + ' like :pNOME');
    if filtro = 'Ativos' then
      SQL.Add('AND PRD.COD_STATUS = 0 ');

    SQL.Add('ORDER BY ' + campoIndice);
    ParamByName('PNOME').AsString := sNome + '%';
    Prepared := True;
    Open();
  end;
end;

procedure TProduto.Carregar(Produto: TProduto; iCodigo: Integer);
var QryProduto : TFDQuery;
begin
  QryProduto := TFDQuery.Create(nil);
  try
    with QryProduto do
    begin
      Connection := DMConexao.FDConnection;
      SQL.Clear;
      SQL.Add('SELECT COD_PRODUTO');
      SQL.Add(',COD_STATUS');
      SQL.Add(',DES_DESCRICAO');
      SQL.Add(',VAL_PRECO_UNITARIO');
      SQL.Add(',COD_FORNECEDOR');
      SQL.Add('FROM TAB_PRODUTO');
      SQL.Add('WHERE COD_PRODUTO = :COD_PRODUTO');
      ParamByName('COD_PRODUTO').AsInteger := iCodigo;
      Open;

      Produto.Cod_Produto := FieldByName('COD_PRODUTO').AsInteger;
      Produto.Cod_Status := FieldByName('COD_STATUS').AsInteger;
      Produto.Des_Descricao := FieldByName('DES_DESCRICAO').AsString;
      Produto.Val_Preco_Unitario := FieldByName('VAL_PRECO_UNITARIO').AsFloat;
      Produto.Cod_Fornecedor := FieldByName('COD_FORNECEDOR').AsInteger;

    end;
  finally
    FreeAndNil(QryProduto);
  end;
end;

function TProduto.Inserir(Produto: TProduto; out sErro: String): Boolean;
begin
  with DmTabelas.QryInserir, Produto do
  begin
    Close;
    SQL.Clear;
    SQL.Add('INSERT INTO TAB_PRODUTO( ');
    SQL.Add('COD_STATUS');
    SQL.Add(',DES_DESCRICAO');
    SQL.Add(',VAL_PRECO_UNITARIO');
    SQL.Add(',COD_FORNECEDOR) ');
    SQL.Add('VALUES (:COD_STATUS, ');
    SQL.Add(':DES_DESCRICAO');
    SQL.Add(',:VAL_PRECO_UNITARIO');
    SQL.Add(',:COD_FORNECEDOR)');

    ParamByName('COD_STATUS').AsInteger := Cod_Status;
    ParamByName('DES_DESCRICAO').AsString := Des_Descricao;
    ParamByName('VAL_PRECO_UNITARIO').AsFloat := Val_Preco_Unitario;
    ParamByName('COD_FORNECEDOR').AsInteger := Cod_Fornecedor;

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
        sErro := 'Ocorreu um erro ao inserir um novo produto!' + sLineBreak + E.Message;
        DMConexao.FDConnection.Rollback;
        raise;
      end;
    end;
  end;
end;

function TProduto.Alterar(Produto: TProduto; iCodigo: Integer; out sErro: String): Boolean;
begin
  with DmTabelas.QryAlterar, Produto do
  begin
    Result := False;
    Close;
    SQL.Clear;
    SQL.Add('UPDATE TAB_PRODUTO SET ');
    Sql.Add('COD_STATUS = :COD_STATUS ');
    SQL.Add(',DES_DESCRICAO = :DES_DESCRICAO');
    SQL.Add(',VAL_PRECO_UNITARIO = :VAL_PRECO_UNITARIO');
    SQL.Add(',COD_FORNECEDOR = :COD_FORNECEDOR');
    SQL.Add('WHERE COD_PRODUTO = :COD_PRODUTO');

    ParamByName('COD_STATUS').AsInteger := Cod_Status;
    ParamByName('DES_DESCRICAO').AsString := Des_Descricao;
    ParamByName('VAL_PRECO_UNITARIO').AsFloat := Val_Preco_Unitario;
    ParamByName('COD_FORNECEDOR').AsInteger := Cod_Fornecedor;
    ParamByName('COD_PRODUTO').AsInteger := iCodigo;

    // Inicia Transação
    DMConexao.FDConnection.StartTransaction;

    try
      Prepared := True;
      ExecSQL();
    except on E: Exception do
      begin
        sErro := 'Ocorreu um erro ao alterar os dados do produto!' + sLineBreak + E.Message;
        DMConexao.FDConnection.Rollback;
        Result := False;
        raise;
      end;
    end;
    Result:= True;
    DMConexao.FDConnection.Commit;
  end;
end;

function TProduto.Excluir(iCodigo: Integer; out sErro: String): Boolean;
begin
  with DmTabelas.QryExcluir do
  begin
    Close;
    SQL.Clear;
    SQL.Text := 'DELETE FROM TAB_PRODUTO WHERE COD_PRODUTO = :COD_PRODUTO';
    ParamByName('COD_PRODUTO').AsInteger := iCodigo;

    // Inicia Transação
    DMConexao.FDConnection.StartTransaction;

    try
      Prepared := True;
      ExecSQL();
      Result := True;
      DMConexao.FDConnection.Commit;
    except on E: Exception do
      begin
        sErro := 'Ocorreu um erro ao excluir o produto !' + sLineBreak + E.Message;
        Result := False;
        DMConexao.FDConnection.Rollback;
        raise;
      end;
    end;
  end;
end;

function TProduto.RetornaValorUnitario(iCodigo: integer): Double;
var QryTemp : TFDQuery;
begin
  QryTemp := TFDQuery.Create(nil);
  Result := 0;
  try
    with QryTemp do
    begin
      Connection := DMConexao.FDConnection;
      SQL.Clear;
      SQL.Add('SELECT COD_PRODUTO');
      SQL.Add(',VAL_PRECO_UNITARIO');
      SQL.Add('FROM TAB_PRODUTO');
      SQL.Add('WHERE COD_PRODUTO = :COD_PRODUTO');
      ParamByName('COD_PRODUTO').AsInteger := iCodigo;
      Open;
      Result := FieldByName('VAL_PRECO_UNITARIO').AsFloat
    end;
  finally
    FreeAndNil(QryTemp);
  end;

end;

procedure TProduto.SetDes_Descricao(const Value: String);
begin
  if Value = EmptyStr then
    raise EArgumentException.Create('O campo ''Descrição'' precisa ser preenchido !');

  FDes_Descricao := Value;
end;


end.
