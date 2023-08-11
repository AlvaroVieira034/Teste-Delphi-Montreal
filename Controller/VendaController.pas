unit VendaController;

interface

uses
  System.SysUtils, UDmTabelas, UDmConexao;

Type
  TVenda = class
  private
    FCod_Venda: Integer;
    FCod_Status: Integer;
    FCod_Cliente: Integer;
    FDta_Venda: TDateTime;
    FVal_Total_Venda: Double;
    procedure SetCod_Cliente(const Value: Integer);

  public
    procedure Pesquisar(sNome, campoIndice: String);
    procedure Carregar(Venda: TVenda;  iCodigo: Integer);
    function Inserir(Venda: TVenda; out sErro: String): Boolean;
    function Alterar(Venda: TVenda; iCodigo: Integer; out sErro: String): Boolean;
    function Excluir(iCodigo: Integer; out sErro : String): Boolean;

    property Cod_Venda: Integer read FCod_Venda write FCod_Venda;
    property Cod_Status: Integer read FCod_Status write FCod_Status;
    property Cod_Cliente: Integer read FCod_Cliente write SetCod_Cliente;
    property Dta_Venda: TDateTime read FDta_Venda write FDta_Venda;
    property Val_Total_Venda: Double read FVal_Total_Venda write FVal_Total_Venda;

  end;

implementation

uses
  FireDAC.Comp.Client, FireDAC.Stan.Error;

{ TVenda }

procedure TVenda.Pesquisar(sNome, campoIndice: String);
begin
  with DmTabelas.TblVendas do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT  VDA.COD_VENDA ');
    SQL.Add(',VDA.COD_CLIENTE ');
    SQL.Add(',CLI.DES_NOME ');
    SQL.Add(',VDA.DTA_VENDA ');
    SQL.Add(',VDA.VAL_TOTAL_VENDA AS VAL_TOT_VENDA ');
    SQL.Add(',VDA.COD_STATUS ');
    SQL.Add(',CASE WHEN VDA.COD_STATUS = 0 then ''0 - EFETIVADA'' ELSE ''1 - PENDENTE'' END AS VDA_STATUS');
    SQL.Add('FROM TAB_VENDA VDA');
    SQL.Add('INNER JOIN TAB_CLIENTE CLI ON VDA.COD_CLIENTE = CLI.COD_CLIENTE');
    SQL.Add('WHERE ' + campoIndice + ' like :pNOME');
    SQL.Add('ORDER BY DTA_VENDA');
    ParamByName('PNOME').AsString := sNome + '%';
    Prepared := True;
    Open();
  end;
end;

procedure TVenda.Carregar(Venda: TVenda; iCodigo: Integer);
var QryVenda : TFDQuery;
begin
  QryVenda := TFDQuery.Create(nil);
  try
    with QryVenda do
    begin
      Connection := DMConexao.FDConnection;
      SQL.Clear;
      SQL.Add('SELECT COD_VENDA');
      SQL.Add(',COD_STATUS');
      SQL.Add(',COD_CLIENTE');
      SQL.Add(',DTA_VENDA');
      SQL.Add(',VAL_TOTAL_VENDA');
      SQL.Add('FROM TAB_VENDA');
      SQL.Add('WHERE COD_VENDA = :COD_VENDA');
      ParamByName('COD_VENDA').AsInteger := iCodigo;
      Open;

      Venda.Cod_Venda := FieldByName('COD_VENDA').AsInteger;
      Venda.Cod_Status := FieldByName('COD_STATUS').AsInteger;
      Venda.Cod_Cliente := FieldByName('COD_CLIENTE').AsInteger;
      Venda.Dta_Venda := FieldByName('DTA_VENDA').AsDateTime;
      Venda.Val_Total_Venda := FieldByName('VAL_TOTAL_VENDA').AsFloat;
    end;
  finally
    FreeAndNil(QryVenda);
  end;
end;

function TVenda.Inserir(Venda: TVenda; out sErro: String): Boolean;
var ultimoCod_Venda: Integer;
begin
  with DmTabelas.QryInserir, Venda do
  begin
    Close;
    SQL.Clear;
    SQL.Add('INSERT INTO TAB_VENDA( ');
    SQL.Add('COD_STATUS');
    SQL.Add(',COD_CLIENTE');
    SQL.Add(',DTA_VENDA');
    SQL.Add(',VAL_TOTAL_VENDA) ');
    SQL.Add('VALUES (:COD_STATUS, ');
    SQL.Add(':COD_CLIENTE');
    SQL.Add(',:DTA_VENDA');
    SQL.Add(',:VAL_TOTAL_VENDA)');

    ParamByName('COD_STATUS').AsInteger := Cod_Status;
    ParamByName('COD_CLIENTE').AsInteger := Cod_Cliente;
    ParamByName('DTA_VENDA').AsDateTime := Dta_Venda;
    ParamByName('VAL_TOTAL_VENDA').AsFloat := Val_Total_Venda;

    // Inicia Transação
    DMConexao.FDConnection.StartTransaction;

    try
      Prepared := True;
      ExecSQL;
      Result := True;
      DMConexao.FDConnection.Commit;

      DmTabelas.QryInserir.Close;
      DmTabelas.QryInserir.SQL.Text := 'SELECT MAX(COD_VENDA) AS ULTIMOID FROM TAB_VENDA ';
      DmTabelas.QryInserir.Open;
      Venda.Cod_Venda := DmTabelas.QryInserir.FieldByName('ULTIMOID').AsInteger;

    except
      on E: Exception do
      begin
        Result := False;
        sErro := 'Ocorreu um erro ao inserir uma nova venda!' + sLineBreak + E.Message;
        DMConexao.FDConnection.Rollback;
        raise;
      end;
    end;
  end;
end;

function TVenda.Alterar(Venda: TVenda; iCodigo: Integer; out sErro: String): Boolean;
begin
  with DmTabelas.QryAlterar, Venda do
  begin
    Result := False;
    Close;
    SQL.Clear;
    SQL.Add('UPDATE TAB_VENDA SET ');
    Sql.Add('COD_STATUS = :COD_STATUS ');
    SQL.Add(',COD_CLIENTE = :COD_CLIENTE');
    SQL.Add(',DTA_VENDA = :DTA_VENDA');
    SQL.Add(',VAL_TOTAL_VENDA = :VAL_TOTAL_VENDA');
    SQL.Add('WHERE COD_VENDA = :COD_VENDA');

    ParamByName('COD_STATUS').AsInteger := Cod_Status;
    ParamByName('COD_CLIENTE').AsInteger := Cod_Cliente;
    ParamByName('DTA_VENDA').AsDateTime := Dta_Venda;
    ParamByName('VAL_TOTAL_VENDA').AsFloat := Val_Total_Venda;
    ParamByName('COD_VENDA').AsInteger := iCodigo;

    // Inicia Transação
    DMConexao.FDConnection.StartTransaction;

    try
      Prepared := True;
      ExecSQL();
    except on E: Exception do
      begin
        sErro := 'Ocorreu um erro ao alterar os dados da venda!' + sLineBreak + E.Message;
        DMConexao.FDConnection.Rollback;
        Result := False;
        raise;
      end;
    end;
    Result:= True;
    DMConexao.FDConnection.Commit;
  end;
end;

function TVenda.Excluir(iCodigo: Integer; out sErro: String): Boolean;
begin
  with DmTabelas.QryExcluir do
  begin
    Close;
    SQL.Clear;
    SQL.Text := 'DELETE FROM TAB_VENDA WHERE COD_VENDA = :COD_VENDA';
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
        sErro := 'Ocorreu um erro ao excluir a venda !' + sLineBreak + E.Message;
        Result := False;
        DMConexao.FDConnection.Rollback;
        raise;
      end;
    end;
  end;
end;

procedure TVenda.SetCod_Cliente(const Value: Integer);
begin
  if Value = 0 then
    raise EArgumentException.Create('O campo ''Código do Cliente'' precisa ser preenchido !');

  FCod_Cliente := Value;
end;


end.
