unit VendaItensController;

interface

uses
  System.SysUtils, UDmTabelas, UDmConexao;

Type
  TVendaItens = class
  private
    FCod_Venda: Integer;
    FCod_Produto: Integer;
    FDes_Descricao: string;
    FVal_Preco_Unitario: Double;
    FVal_Quantidade: Integer;
    FVal_Total_Venda: Double;
    procedure SetCod_Produto(const Value: Integer);

  public
    procedure Carregar(VendaItens: TVendaItens;  iCodigo: Integer);
    function Inserir(VendaItens: TVendaItens; out sErro: String): Boolean;
    function Alterar(VendaItens: TVendaItens; iCodigo: Integer; out sErro: String): Boolean;
    function Excluir(iCodigo: Integer; out sErro : String): Boolean;

    property Cod_Venda: Integer read FCod_Venda write FCod_Venda;
    property Cod_Produto: Integer read FCod_Produto write SetCod_Produto;
    property Des_Descricao: string read FDes_Descricao write FDes_Descricao;
    property Val_Preco_Unitario: Double read FVal_Preco_Unitario write FVal_Preco_Unitario;
    property Val_Quantidade: Integer read FVal_Quantidade write FVal_Quantidade;
    property Val_Total_Venda: Double read FVal_Total_Venda write FVal_Total_Venda;

  end;

implementation

uses
  FireDAC.Comp.Client, FireDAC.Stan.Error;

{ TVendaItens }


procedure TVendaItens.Carregar(VendaItens: TVendaItens; iCodigo: Integer);
//var QryVenda : TFDQuery;
begin
  with DmTabelas.QryPesquisarItens, VendaItens do
  begin
    Close;
    SQL.Clear;
    Connection := DMConexao.FDConnection;
    SQL.Clear;
    SQL.Add('SELECT COD_VENDA');
    SQL.Add(',COD_PRODUTO');
    SQL.Add(',DES_DESCRICAO');
    SQL.Add(',VAL_PRECO_UNITARIO');
    SQL.Add(',VAL_QUANTIDADE');
    SQL.Add(',VAL_TOTAL_VENDA');
    SQL.Add('FROM TAB_VENDA_ITENS');
    SQL.Add('WHERE COD_VENDA = :COD_VENDA');
    ParamByName('COD_VENDA').AsInteger := iCodigo;
    Open;

  end;


  {QryVenda := TFDQuery.Create(nil);
  try
    with QryVenda do
    begin
      Connection := DMConexao.FDConnection;
      SQL.Clear;
      SQL.Add('SELECT COD_VENDA');
      SQL.Add(',COD_PRODUTO');
      SQL.Add(',DES_DESCRICAO');
      SQL.Add(',VAL_PRECO_UNITARIO');
      SQL.Add(',VAL_QUANTIDADE');
      SQL.Add(',VAL_TOTAL_VENDA');
      SQL.Add('FROM TAB_VENDA_ITENS');
      SQL.Add('WHERE COD_VENDA = :COD_VENDA');
      ParamByName('COD_VENDA').AsInteger := iCodigo;
      Open;

      VendaItens.Cod_Venda := FieldByName('COD_VENDA').AsInteger;
      VendaItens.Cod_Produto := FieldByName('COD_PRODUTO').AsInteger;
      VendaItens.Des_Descricao := FieldByName('DES_DESCRICAO').AsString;
      VendaItens.Val_Preco_Unitario := FieldByName('VAL_PRECO_UNITARIO').AsFloat;
      VendaItens.Val_Quantidade := FieldByName('VAL_QUANTIDADE').AsInteger;
      VendaItens.Val_Total_Venda := FieldByName('VAL_TOTAL_VENDA').AsFloat;
    end;
  finally
    FreeAndNil(QryVenda);
  end;}
end;

function TVendaItens.Inserir(VendaItens: TVendaItens; out sErro: String): Boolean;
begin
  with DmTabelas.QryInserir, VendaItens do
  begin
    Close;
    SQL.Clear;
    SQL.Add('INSERT INTO TAB_VENDA_ITENS( ');
    SQL.Add(',COD_VENDA ');
    SQL.Add(',COD_PRODUTO ');
    SQL.Add(',DES_DESCRICAO ');
    SQL.Add(',VAL_PRECO_UNITARIO ');
    SQL.Add(',VAL_QUANTIDADE ');
    SQL.Add(',VAL_TOTAL_VENDA) ');
    SQL.Add('VALUES (:COD_VENDA, ');
    SQL.Add(',:COD_PRODUTO ');
    SQL.Add(',:DES_DESCRICAO ');
    SQL.Add(',:VAL_PRECO_UNITARIO ');
    SQL.Add(',:VAL_QUANTIDADE ');
    SQL.Add(',:VAL_TOTAL_VENDA) ');

    ParamByName('COD_VENDA').AsInteger := Cod_Venda;
    ParamByName('COD_PRODUTO').AsInteger := Cod_Produto;
    ParamByName('DES_DESCRICAO').AsString := Des_Descricao;
    ParamByName('VAL_PRECO_UNITARIO').AsFloat := Val_Preco_Unitario;
    ParamByName('VAL_QUANTIDADE').AsInteger := Val_Quantidade;
    ParamByName('VAL_TOTAL_VENDA').AsFloat := Val_Total_Venda;

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
        sErro := 'Ocorreu um erro ao inserir um novo item da venda!' + sLineBreak + E.Message;
        DMConexao.FDConnection.Rollback;
        raise;
      end;
    end;
  end;
end;

function TVendaItens.Alterar(VendaItens: TVendaItens; iCodigo: Integer; out sErro: String): Boolean;
begin
  with DmTabelas.QryAlterar, VendaItens do
  begin
    Result := False;
    Close;
    SQL.Clear;
    SQL.Add('UPDATE TAB_VENDA_ITENS SET ');
    Sql.Add('COD_PRODUTO = :COD_PRODUTO ');
    SQL.Add(',DES_DESCRICAO = :DES_DESCRICAO');
    SQL.Add(',VAL_PRECO_UNITARIO = :VAL_PRECO_UNITARIO');
    SQL.Add(',VAL_QUANTIDADE = :VAL_QUANTIDADE');
    SQL.Add(',VAL_TOTAL_VENDA = :VAL_TOTAL_VENDA');
    SQL.Add('WHERE COD_VENDA = :COD_VENDA');

    ParamByName('COD_PRODUTO').AsInteger := Cod_Produto;
    ParamByName('DES_DESCRICAO').AsString := Des_Descricao;
    ParamByName('VAL_PRECO_UNITARIO').AsFloat := Val_Preco_Unitario;
    ParamByName('VAL_QUANTIDADE').AsInteger := Val_Quantidade;
    ParamByName('VAL_TOTAL_VENDA').AsFloat := Val_Total_Venda;
    ParamByName('COD_VENDA').AsInteger := iCodigo;

    // Inicia Transação
    DMConexao.FDConnection.StartTransaction;

    try
      Prepared := True;
      ExecSQL();
    except on E: Exception do
      begin
        sErro := 'Ocorreu um erro ao alterar o item da venda!' + sLineBreak + E.Message;
        DMConexao.FDConnection.Rollback;
        Result := False;
        raise;
      end;
    end;
    Result:= True;
    DMConexao.FDConnection.Commit;
  end;
end;

function TVendaItens.Excluir(iCodigo: Integer; out sErro: String): Boolean;
begin
  with DmTabelas.QryExcluir do
  begin
    Close;
    SQL.Clear;
    SQL.Text := 'DELETE FROM TAB_VENDA_ITENS WHERE COD_VENDA = :COD_VENDA';
    ParamByName('COD_VENDA').AsInteger := iCodigo;

    // Inicia Transação
    DMConexao.FDConnection.StartTransaction;

    try
      Prepared := True;
      ExecSQL();
      Result := True;
      DMConexao.FDConnection.Commit;
    except on E: Exception do
      begin
        sErro := 'Ocorreu um erro ao excluir o item da venda !' + sLineBreak + E.Message;
        Result := False;
        DMConexao.FDConnection.Rollback;
        raise;
      end;
    end;
  end;
end;

procedure TVendaItens.SetCod_Produto(const Value: Integer);
begin
  if Value = 0 then
    raise EArgumentException.Create('O campo ''Código do Produto'' precisa ser preenchido !');

  FCod_Produto := Value;
end;

end.
