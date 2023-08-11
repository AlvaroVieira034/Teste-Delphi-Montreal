unit UCadVenda;

interface

{$REGION 'Uses'}
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, ProdutoController, ClienteController, VendaController, VendaItensController,
  Datasnap.DBClient;
{$ENDREGION}

type
  TOperacao = (opNovo, opAlterar, opNavegar);
  TFrmCadVenda = class(TForm)

{$REGION 'Componentes'}
    PnlDados: TPanel;
    GbxDados: TGroupBox;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label2: TLabel;
    BtnAdicionaItens: TSpeedButton;
    BtnLimpaCampos: TSpeedButton;
    EdtCodVenda: TEdit;
    EdtCodCliente: TEdit;
    LCbxCliente: TDBLookupComboBox;
    EdtTotalVenda: TEdit;
    EdtDataVenda: TEdit;
    PnlItens: TPanel;
    GbxItens: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    BtnAddItemGrid: TSpeedButton;
    BtnDelItemGrid: TSpeedButton;
    EdtQuantidade: TEdit;
    EdtPrecoUnit: TEdit;
    EdtPrecoTotal: TEdit;
    PnlDbGrid: TPanel;
    LCbxProdutos: TDBLookupComboBox;
    RdgStatus: TRadioGroup;
    DsVendaItem: TDataSource;
    DsVenda: TDataSource;
    DbGridItensPedido: TDBGrid;
    BtnGravar: TSpeedButton;
    BtnCancelar: TSpeedButton;
    BtnSair: TSpeedButton;
    CdsVendaItem: TClientDataSet;
    CdsVendaItemID_ITEM: TIntegerField;
    CdsVendaItemCOD_VENDA: TIntegerField;
    CdsVendaItemCOD_PRODUTO: TIntegerField;
    CdsVendaItemDES_DESCRICAO: TStringField;
    CdsVendaItemVAL_PRECO_UNITARIO: TFloatField;
    CdsVendaItemVAL_QUANTIDADE: TIntegerField;
    CdsVendaItemVAL_TOTAL_VENDA: TFloatField;
{$ENDREGION}

    procedure BtnCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EdtCodClienteExit(Sender: TObject);
    procedure EdtCodClienteKeyPress(Sender: TObject; var Key: Char);
    procedure BtnAdicionaItensClick(Sender: TObject);
    procedure LCbxClienteClick(Sender: TObject);
    procedure EdtDataVendaKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnSairClick(Sender: TObject);
    procedure BtnAddItemGridClick(Sender: TObject);
    procedure BtnDelItemGridClick(Sender: TObject);


  private
    ValoresOriginais: array of string;
    procedure CarregarVendas;
    procedure InserirVendas;
    procedure AlterarVendas;
    procedure InserirVendaItens;
    procedure AlterarVendaItens;
    function ValidarDados(tipoDados: string): Boolean;
    procedure GravarDados;
    procedure GravarDadosVenda;
    procedure GravarDadosItens;
    procedure LimpaCamposPedido;
    procedure LimpaCamposItens;
    procedure PesquisarProdutosAtivos;
    procedure PesquisarClientesAtivos;
    procedure PreencheCdsVendaItem;


  public
    FOperacao: TOperacao;
    Venda: TVenda;
    VendaItens: TVendaItens;

  end;

var
  FrmCadVenda: TFrmCadVenda;

implementation

{$R *.dfm}

uses UMain, UDmTabelas;


procedure TFrmCadVenda.FormCreate(Sender: TObject);
begin
  Venda := TVenda.Create;
  VendaItens := TVendaItens.Create;
  PesquisarProdutosAtivos();
  PesquisarClientesAtivos();
  SetLength(ValoresOriginais, 5);
  CdsVendaItem.CreateDataSet;
end;

procedure TFrmCadVenda.FormShow(Sender: TObject);
begin
  DbGridItensPedido.Columns[0].Width := 290;
  DbGridItensPedido.Columns[1].Width := 80;
  DbGridItensPedido.Columns[2].Width := 85;
  DbGridItensPedido.Columns[3].Width := 85;

  if FOperacao = opAlterar then
  begin
    CarregarVendas();
    ValoresOriginais[0] := EdtCodVenda.Text;
    ValoresOriginais[1] := IntToStr(RdgStatus.ItemIndex);
    ValoresOriginais[2] := EdtDataVenda.Text;
    ValoresOriginais[3] := EdtCodCliente.Text;
    ValoresOriginais[4] := EdtTotalVenda.Text;
    EdtCodClienteExit(Sender);
    EdtDataVenda.SetFocus;
  end
  else
  if FOperacao = opNovo then
  begin
    LimpaCamposPedido();
    EdtCodCliente.Text := '0';
    EdtTotalVenda.Text := '0';
    EdtDataVenda.SetFocus;
  end
  else
  begin
    LimpaCamposPedido();
    EdtDataVenda.SetFocus;
  end;
  GbxItens.Enabled := False;
end;

procedure TFrmCadVenda.CarregarVendas;
begin
  CdsVendaItem.Close;
  CdsVendaItem.CreateDataSet;

  Venda.Carregar(Venda, DsVenda.DataSet.FieldByName('COD_VENDA').AsInteger);

  with Venda do
  begin
    RdgStatus.ItemIndex := Cod_Status;
    EdtDataVenda.Text := DateToStr(Dta_Venda);
    EdtCodVenda.Text := IntToStr(Cod_Venda);
    EdtCodCliente.Text := IntToStr(Cod_Cliente);
    EdtTotalVenda.Text := FormatFloat('##,###,##0.00', Val_Total_Venda);
  end;

  VendaItens.Carregar(VendaItens, DsVenda.DataSet.FieldByName('COD_VENDA').AsInteger);

  with DmTabelas.QryPesquisarItens do
  begin
    while not DmTabelas.QryPesquisarItens.eof do
    begin
      CdsVendaItem.Append;
      CdsVendaItemCOD_PRODUTO.AsInteger := FieldByName('COD_PRODUTO').AsInteger;
      CdsVendaItemDES_DESCRICAO.AsString := FieldByName('DES_DESCRICAO').AsString;
      CdsVendaItemVAL_QUANTIDADE.AsInteger := FieldByName('VAL_QUANTIDADE').AsInteger;
      CdsVendaItemVAL_PRECO_UNITARIO.AsFloat := FieldByName('VAL_PRECO_UNITARIO').AsFloat;
      CdsVendaItemVAL_TOTAL_VENDA.AsFloat := FieldByName('VAL_TOTAL_VENDA').AsFloat;
      CdsVendaItem.Post;
      DmTabelas.QryPesquisarItens.Next;
    end;
  end;
end;

procedure TFrmCadVenda.EdtCodClienteExit(Sender: TObject);
begin
  if EdtCodCliente.Text <> '' then
    LCbxCliente.KeyValue := StrToInt(EdtCodCliente.Text);
end;

procedure TFrmCadVenda.EdtCodClienteKeyPress(Sender: TObject; var Key: Char);
begin
  if not( key in['0'..'9',#08] ) then
    key:=#0;
end;

procedure TFrmCadVenda.EdtDataVendaKeyPress(Sender: TObject; var Key: Char);
begin
  if not( key in['0'..'9',#08, '/'] ) then
    key:=#0;
end;

procedure TFrmCadVenda.InserirVendas;
//var Venda : TVenda;
var sErro: String;
begin
  //Venda := TVenda.Create;
  try
    with Venda do
    begin
      Cod_Status := RdgStatus.ItemIndex;
      Cod_Cliente := StrToInt(EdtCodCliente.Text);
      Dta_Venda := StrToDate(EdtDataVenda.Text);
      Val_Total_Venda := StrToFloat(EdtTotalVenda.Text);

      if Venda.Inserir(Venda, sErro) = false then
        raise Exception.Create(sErro)
      else
        MessageDlg('Registro incluido com sucesso !!', mtInformation, [mbOk], 0);

      //BtnSair.Click
    end;
  finally
    //FreeAndNil(Venda);
  end;

end;

procedure TFrmCadVenda.InserirVendaItens;
begin

end;



procedure TFrmCadVenda.AlterarVendas;
var Venda : TVenda;
    sErro: String;
begin
  Venda := TVenda.Create;
  try
    with Venda do
    begin
      Cod_Status := RdgStatus.ItemIndex;
      Dta_Venda := StrToDate(EdtDataVenda.Text);
      Cod_Cliente := StrToInt(EdtCodCliente.Text);
      Val_Total_Venda := StrToFloat(EdtTotalVenda.Text);
    end;

    if Venda.Alterar(Venda, StrToInt(EdtCodVenda.Text), sErro) = False then
      raise Exception.Create(sErro)
    else
      MessageDlg('Registro alterado com sucesso !!', mtInformation, [mbOK], 0);

    //BtnSair.Click;
  finally
    FreeAndNil(Venda);
  end;

end;

procedure TFrmCadVenda.AlterarVendaItens;
begin

end;


function TFrmCadVenda.ValidarDados(tipoDados: string): Boolean;
begin
  Result := False;
  if tipoDados = 'Venda' then
  begin
    if EdtDataVenda.Text = '' then
    begin
      MessageDlg('A data do pedido deve ser informada!', mtInformation, [mbOK], 0);
      EdtDataVenda.SetFocus;
      Exit;
    end;

    if StrToFloat(EdtCodCliente.Text) = 0 then
    begin
      MessageDlg('O cliente deve ser informado!', mtInformation, [mbOK], 0);
      EdtCodCliente.SetFocus;
      Exit;
    end;
  end;

  if tipoDados = 'Item' then
  begin

  end;

  Result := True;
end;

procedure TFrmCadVenda.GravarDados;
var Venda : TVenda;
begin
  Venda := TVenda.Create;
  try
    case FOperacao of
      opNovo    : InserirVendas();
      opAlterar : AlterarVendas();
    end;
  finally
    FreeAndNil(Venda);
  end;
end;

procedure TFrmCadVenda.GravarDadosItens;
begin


  {
  with DmTabelas.QryPesquisarItens do
  begin
    while not DmTabelas.QryPesquisarItens.eof do
    begin
      CdsVendaItem.Append;
      CdsVendaItemCOD_PRODUTO.AsInteger := FieldByName('COD_PRODUTO').AsInteger;
      CdsVendaItemDES_DESCRICAO.AsString := FieldByName('DES_DESCRICAO').AsString;
      CdsVendaItemVAL_QUANTIDADE.AsInteger := FieldByName('VAL_QUANTIDADE').AsInteger;
      CdsVendaItemVAL_PRECO_UNITARIO.AsFloat := FieldByName('VAL_PRECO_UNITARIO').AsFloat;
      CdsVendaItemVAL_TOTAL_VENDA.AsFloat := FieldByName('VAL_TOTAL_VENDA').AsFloat;
      CdsVendaItem.Post;
      PreencheCdsVendaItem();
      DmTabelas.QryPesquisarItens.Next;
    end;
  end;
  }


end;

procedure TFrmCadVenda.GravarDadosVenda;
begin
  case FOperacao of
    opNovo    : InserirVendas();
    opAlterar : AlterarVendas();
  end;
end;

procedure TFrmCadVenda.PesquisarProdutosAtivos;
var Produto: TProduto;
    campoIndice: string;
begin
  Produto := TProduto.Create;
  campoIndice := 'DES_DESCRICAO';
  try
    Produto.Pesquisar('', campoIndice, 'Ativos');
  finally
    FreeAndNil(Produto);
  end;
end;


procedure TFrmCadVenda.PesquisarClientesAtivos;
var Cliente: TCliente;
    campoIndice: string;
begin
  Cliente := TCliente.Create;
  campoIndice := 'DES_NOME';
  try
    Cliente.Pesquisar('', campoIndice, 'Ativos');
  finally
    FreeAndNil(Cliente);
  end;
end;

procedure TFrmCadVenda.BtnAdicionaItensClick(Sender: TObject);
begin
  if not ValidarDados('Venda') then
  begin
    Exit;
  end;

  GbxDados.Enabled := False;
  GbxItens.Enabled := True;
  BtnGravar.Enabled := True;
  BtnCancelar.Enabled := True;
  LCbxProdutos.SetFocus;

end;

procedure TFrmCadVenda.BtnAddItemGridClick(Sender: TObject);
begin
  if not ValidarDados('Item') then
  begin
    Exit;
  end
  else
  begin
    PreencheCdsVendaItem();
    LimpaCamposItens;
    LCbxProdutos.SetFocus;
  end;
end;

procedure TFrmCadVenda.BtnDelItemGridClick(Sender: TObject);
begin
  CdsVendaItem.Delete;
  CdsVendaItem.Post;
  CdsVendaItem.Refresh;
end;




procedure TFrmCadVenda.LCbxClienteClick(Sender: TObject);
begin
  if LCbxCliente.KeyValue > 0 then
    EdtCodCliente.Text := IntToStr(LCbxCliente.KeyValue)
end;

procedure TFrmCadVenda.LimpaCamposPedido;
begin
  EdtCodVenda.Text := EmptyStr;
  EdtDataVenda.Text := EmptyStr;
  EdtCodCliente.Text := EmptyStr;
  EdtCodCliente.Text := EmptyStr;
  EdtTotalVenda.Text := EmptyStr;
end;

procedure TFrmCadVenda.LimpaCamposItens;
begin
  EdtQuantidade.Text := EmptyStr;
  EdtPrecoUnit.Text := EmptyStr;
  EdtPrecoTotal.Text := EmptyStr;
end;

procedure TFrmCadVenda.BtnCancelarClick(Sender: TObject);
begin
  GbxDados.Enabled := True;
  GbxItens.Enabled := False;
  BtnGravar.Enabled := False;
  BtnCancelar.Enabled := False;
  EdtDataVenda.SetFocus;
end;

procedure TFrmCadVenda.PreencheCdsVendaItem;
begin
  with CdsVendaItem do
  begin
    CdsVendaItem.Append;
    CdsVendaItemCOD_PRODUTO.AsInteger := LCbxProdutos.KeyValue;
    CdsVendaItemDES_DESCRICAO.AsString := LCbxProdutos.Text;
    CdsVendaItemVAL_QUANTIDADE.AsInteger := StrToInt(EdtQuantidade.Text);
    CdsVendaItemVAL_PRECO_UNITARIO.AsFloat := StrToFloat(EdtPrecoUnit.Text);
    CdsVendaItemVAL_TOTAL_VENDA.AsFloat := StrToFloat(EdtPrecoTotal.Text);
    CdsVendaItem.Post;
  end;
end;


procedure TFrmCadVenda.BtnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmCadVenda.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Venda.Free;
  VendaItens.Free;
end;

end.
