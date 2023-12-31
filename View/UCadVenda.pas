unit UCadVenda;

interface

{$REGION 'Uses'}
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, ProdutoController, ClienteController, VendaController, VendaItensController,
  Datasnap.DBClient, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ComCtrls, Vcl.Mask;
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
    EdtCodVenda: TEdit;
    EdtCodCliente: TEdit;
    LCbxCliente: TDBLookupComboBox;
    EdtTotalVenda: TEdit;
    PnlItens: TPanel;
    GbxItens: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    EdtQuantidade: TEdit;
    EdtPrecoUnit: TEdit;
    EdtPrecoTotal: TEdit;
    PnlDbGrid: TPanel;
    LCbxProdutos: TDBLookupComboBox;
    RdgStatus: TRadioGroup;
    DsVendaItem: TDataSource;
    DsVenda: TDataSource;
    BtnGravar: TSpeedButton;
    BtnCancelar: TSpeedButton;
    BtnSair: TSpeedButton;
    MTblVendaItem: TFDMemTable;
    MTblVendaItemID_ITEM: TIntegerField;
    MTblVendaItemCOD_VENDA: TIntegerField;
    MTblVendaItemCOD_PRODUTO: TIntegerField;
    MTblVendaItemDES_DESCRICAO: TStringField;
    MTblVendaItemVAL_PRECO_UNITARIO: TFloatField;
    MTblVendaItemVAL_QUANTIDADE: TIntegerField;
    MTblVendaItemVAL_TOTAL_VENDA: TFloatField;
    DbGridItensPedido: TDBGrid;
    BtnInserirItens: TButton;
    BtnAddItemGrid: TButton;
    BtnDelItemGrid: TButton;
    EdtDataVenda: TEdit;
{$ENDREGION}

    procedure BtnCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EdtCodClienteExit(Sender: TObject);
    procedure EdtCodClienteKeyPress(Sender: TObject; var Key: Char);
    procedure BtnInserirItensClick(Sender: TObject);
    procedure LCbxClienteClick(Sender: TObject);
    procedure EdtDataVendaKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnSairClick(Sender: TObject);
    procedure BtnAddItemGridClick(Sender: TObject);
    procedure BtnDelItemGridClick(Sender: TObject);
    procedure EdtPrecoTotalEnter(Sender: TObject);
    procedure DsVendaItemDataChange(Sender: TObject; Field: TField);
    procedure BtnGravarClick(Sender: TObject);
    procedure DbGridItensPedidoDblClick(Sender: TObject);
    procedure LCbxProdutosExit(Sender: TObject);
    procedure EdtQuantidadeKeyPress(Sender: TObject; var Key: Char);
    procedure EdtPrecoUnitKeyPress(Sender: TObject; var Key: Char);
    procedure EdtPrecoTotalKeyPress(Sender: TObject; var Key: Char);
    procedure EdtDataVendaChange(Sender: TObject);

  private
    ValoresOriginais: array of string;
    procedure CarregarVendas;
    procedure InserirVendas;
    procedure InserirVendaItens;
    procedure AlterarVendas;
    procedure AlterarVendaItens;
    function ValidarDados(tipoDados: string): Boolean;
    procedure LimpaCamposPedido;
    procedure LimpaCamposItens;
    procedure PesquisarProdutosAtivos;
    procedure PesquisarClientesAtivos;
    procedure PreencheCdsVendaItem(FOperacao: TOperacao);

  public
      FOperacao: TOperacao;

  end;

var
  FrmCadVenda: TFrmCadVenda;
  Venda: TVenda;
  VendaItens: TVendaItens;
  totVenda: Double;
  idItem: Integer;

implementation

{$R *.dfm}

uses UMain, UDmTabelas, untFormat, Biblioteca;


procedure TFrmCadVenda.FormCreate(Sender: TObject);
begin
  Venda := TVenda.Create;
  VendaItens := TVendaItens.Create;
  totVenda := 0;
  PesquisarProdutosAtivos();
  PesquisarClientesAtivos();
  SetLength(ValoresOriginais, 5);
  MTblVendaItem.CreateDataSet;
end;

procedure TFrmCadVenda.FormShow(Sender: TObject);
begin
  DbGridItensPedido.Columns[0].Width := 290;
  DbGridItensPedido.Columns[1].Width := 80;
  DbGridItensPedido.Columns[2].Width := 85;
  DbGridItensPedido.Columns[3].Width := 85;
  if FOperacao = opAlterar then
  begin
    BtnInserirItens.Caption := 'Alterar Itens';
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
    BtnInserirItens.Caption := 'Inserir Itens';
    LimpaCamposPedido();
    EdtCodCliente.Text := '0';
    EdtTotalVenda.Text := '0';
    idItem := 1;
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
  MTblVendaItem.Close;
  MTblVendaItem.CreateDataSet;
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
      MTblVendaItem.Append;
      MTblVendaItemCOD_PRODUTO.AsInteger := FieldByName('COD_PRODUTO').AsInteger;
      MTblVendaItemDES_DESCRICAO.AsString := FieldByName('DES_DESCRICAO').AsString;
      MTblVendaItemVAL_QUANTIDADE.AsInteger := FieldByName('VAL_QUANTIDADE').AsInteger;
      MTblVendaItemVAL_PRECO_UNITARIO.AsFloat := FieldByName('VAL_PRECO_UNITARIO').AsFloat;
      MTblVendaItemVAL_TOTAL_VENDA.AsFloat := FieldByName('VAL_TOTAL_VENDA').AsFloat;
      MTblVendaItem.Post;
      DmTabelas.QryPesquisarItens.Next;
    end;
  end;
end;

procedure TFrmCadVenda.DbGridItensPedidoDblClick(Sender: TObject);
var sErro, valorTexto: string;
    totVenda: Double;
begin
  if FOperacao = opAlterar then
  begin
    valorTexto := SoNumeros(EdtTotalVenda.Text);
    totVenda := StrToFloat(valorTexto);
    LCbxProdutos.KeyValue := MTblVendaItem.FieldByName('COD_PRODUTO').AsInteger;
    EdtQuantidade.Text := IntToStr(MTblVendaItem.FieldByName('VAL_QUANTIDADE').AsInteger);
    EdtPrecoUnit.Text := FloatToStr(MTblVendaItem.FieldByName('VAL_PRECO_UNITARIO').AsFloat);
    EdtPrecoTotal.Text := FloatToStr(MTblVendaItem.FieldByName('VAL_TOTAL_VENDA').AsFloat);

    totVenda := totVenda -  MTblVendaItemVAL_TOTAL_VENDA.AsFloat;     ///// Verificar Calculos
    EdtTotalVenda.Text := FloatToStr(totVenda);

    MTblVendaItem.Locate('ID_ITEM', MTblVendaItem.FieldByName('ID_ITEM').AsInteger);
    MTblVendaItem.Delete;
    MTblVendaItem.Refresh;
  end;
end;

procedure TFrmCadVenda.DsVendaItemDataChange(Sender: TObject; Field: TField);
begin
  if MTblVendaItem.RecordCount > 0 then
  begin
    BtnGravar.Enabled := True;
    BtnCancelar.Enabled := True;
  end
  else
  begin
    BtnGravar.Enabled := False;
    BtnCancelar.Enabled := False;
  end;
end;

procedure TFrmCadVenda.EdtCodClienteExit(Sender: TObject);
begin
  if EdtCodCliente.Text <> '' then
    LCbxCliente.KeyValue := StrToInt(EdtCodCliente.Text);
end;

procedure TFrmCadVenda.EdtPrecoTotalEnter(Sender: TObject);
var quant : Integer;
    valUni: Double;
begin
  if EdtQuantidade.Text = '' then
    quant := 1
  else
    quant := StrToInt(EdtQuantidade.Text);

  valUni := StrToFloat(EdtPrecoUnit.Text);
  EdtPrecoTotal.Text := FloatToStr(valUni * quant);
end;

procedure TFrmCadVenda.InserirVendas;
var sErro: String;
begin
  with Venda do
  begin
    Cod_Status := RdgStatus.ItemIndex;
    Cod_Cliente := StrToInt(EdtCodCliente.Text);
    Dta_Venda := StrToDate(EdtDataVenda.Text);
    Val_Total_Venda := StrToFloat(EdtTotalVenda.Text);

    if Venda.Inserir(Venda, sErro) = false then
      raise Exception.Create(sErro);
  end;
end;

procedure TFrmCadVenda.InserirVendaItens;
var sErro : string;
begin
  MTblVendaItem.First;
  while not MTblVendaItem.eof do
  begin
    with VendaItens do
    begin
      Cod_Venda := Venda.Cod_Venda;
      Cod_Produto := MTblVendaItemCOD_PRODUTO.AsInteger;
      Des_Descricao := MTblVendaItemDES_DESCRICAO.AsString;
      Val_Preco_Unitario := MTblVendaItemVAL_PRECO_UNITARIO.AsFloat;
      Val_Quantidade := MTblVendaItemVAL_QUANTIDADE.AsInteger;
      Val_Total_Venda := MTblVendaItemVAL_TOTAL_VENDA.AsFloat;

      if VendaItens.Inserir(VendaItens, sErro) = false then
        raise Exception.Create(sErro);

    end;
    MTblVendaItem.Next;
  end;
end;

procedure TFrmCadVenda.AlterarVendas;
var sErro : string;
begin
  with Venda do
  begin
    Cod_Status := RdgStatus.ItemIndex;
    Dta_Venda := StrToDate(EdtDataVenda.Text);
    Cod_Cliente := StrToInt(EdtCodCliente.Text);
    Val_Total_Venda := StrToFloat(EdtTotalVenda.Text);
  end;

  if Venda.Alterar(Venda, StrToInt(EdtCodVenda.Text), sErro) = False then
    raise Exception.Create(sErro);
end;

procedure TFrmCadVenda.AlterarVendaItens;
var sErro : string;
begin
  if VendaItens.Excluir(StrToInt(EdtCodVenda.Text), sErro) = False then
    raise Exception.Create(sErro);

  InserirVendaItens();
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
    if LCbxProdutos.KeyValue = Null then
    begin
      MessageDlg('O produto precisa ser informado!', mtInformation, [mbOK], 0);
      LCbxProdutos.SetFocus;
      Exit;
    end;

    if MTblVendaItem.Locate('COD_PRODUTO', FloatToStr(LCbxProdutos.KeyValue), []) then
    begin
      MessageDlg('Produto j� inserido!', mtError, [mbOK],0);
      LCbxProdutos.SetFocus;
      Exit;
    end;

    if EdtQuantidade.Text = '' then
    begin
      MessageDlg('A quantidade deve ser preenchida!', mtInformation, [mbOK], 0);
      EdtQuantidade.SetFocus;
      Exit;
    end;

    if StrToFloat(EdtQuantidade.Text) = 0 then
    begin
      MessageDlg('A quantidade n�o pode ser igual a 0!', mtInformation, [mbOK], 0);
      EdtQuantidade.SetFocus;
      Exit;
    end;

    if EdtPrecoUnit.Text = '' then
    begin
      MessageDlg('o pre�o unit�rio deve ser preenchido!', mtInformation, [mbOK], 0);
      EdtPrecoUnit.SetFocus;
      Exit;
    end;

    if StrToFloat(EdtPrecoUnit.Text) = 0 then
    begin
      MessageDlg('O pre�o unit�rio n�o pode ser igual a 0!', mtInformation, [mbOK], 0);
      EdtPrecoUnit.SetFocus;
      Exit;
    end;

    if EdtPrecoTotal.Text = '' then
    begin
      MessageDlg('o pre�o total deve ser preenchido!', mtInformation, [mbOK], 0);
      EdtPrecoTotal.SetFocus;
      Exit;
    end;

    if StrToFloat(EdtPrecoTotal.Text) = 0 then
    begin
      MessageDlg('O pre�o total n�o pode ser igual a 0!', mtInformation, [mbOK], 0);
      EdtPrecoTotal.SetFocus;
      Exit;
    end;
  end;
  Result := True;
end;

procedure TFrmCadVenda.PesquisarProdutosAtivos;
var Produto: TProduto;
    campoIndice: string;
begin
  Produto := TProduto.Create;
  campoIndice := 'PRD.DES_DESCRICAO';
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

procedure TFrmCadVenda.BtnInserirItensClick(Sender: TObject);
begin
  if not ValidarDados('Venda') then
  begin
    Exit;
  end;

  GbxDados.Enabled := False;
  GbxItens.Enabled := True;
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
    PreencheCdsVendaItem(FOperacao);
    LimpaCamposItens;
    BtnGravar.Enabled := True;
    LCbxProdutos.SetFocus;
  end;
end;

procedure TFrmCadVenda.BtnDelItemGridClick(Sender: TObject);
begin
  if MessageDlg('Deseja excluir o registro selecionado?', mtConfirmation, [mbYes, mbNo], mrNo) = mrNo then
    Exit
  else
  begin
    MTblVendaItem.Locate('ID_ITEM', MTblVendaItemID_ITEM.AsInteger, []);
    totVenda := StrToFloat(SoNumeros(EdtTotalVenda.Text));
    totVenda := totVenda -  MTblVendaItemVAL_TOTAL_VENDA.AsFloat;
    EdtTotalVenda.Text := FloatToStr(totVenda);
    MTblVendaItem.Delete;
    MTblVendaItem.ApplyUpdates(0);
    BtnGravar.Enabled := True;
  end;
end;

procedure TFrmCadVenda.BtnGravarClick(Sender: TObject);
begin
  if FOperacao = opNovo then
  begin
    InserirVendas();
    InserirVendaItens();
    MessageDlg('Produto inserido com sucesso!', mtInformation, [mbOK],0);
    LimpaCamposPedido();
    LimpaCamposItens();
    MTblVendaItem.Close;
  end
  else
  if FOperacao = opAlterar then
  begin
    AlterarVendas();
    AlterarVendaItens();
    GbxItens.Enabled := False;
    GbxDados.Enabled := True;
    MessageDlg('Produto Alterado com sucesso!', mtInformation, [mbOK],0);
  end;
end;

procedure TFrmCadVenda.LCbxClienteClick(Sender: TObject);
begin
  if LCbxCliente.KeyValue > 0 then
    EdtCodCliente.Text := IntToStr(LCbxCliente.KeyValue)
end;

procedure TFrmCadVenda.LCbxProdutosExit(Sender: TObject);
var Produto : TProduto;
begin
  Produto := TProduto.Create;
  try
    EdtPrecoUnit.Text := FloatToStr(Produto.RetornaValorUnitario(LCbxProdutos.KeyValue));
  except
    EdtPrecoUnit.Text := '0';
  end;
  //EdtQuantidade.SetFocus;
  FreeAndNil(Produto);
end;

procedure TFrmCadVenda.LimpaCamposPedido;
begin
  EdtCodVenda.Text := EmptyStr;
  EdtDataVenda.Text := EmptyStr;
  EdtCodCliente.Text := EmptyStr;
  LCbxCliente.KeyValue := 0;
  EdtTotalVenda.Text := EmptyStr;
end;

procedure TFrmCadVenda.LimpaCamposItens;
begin
  LCbxProdutos.KeyValue := 0;
  EdtQuantidade.Text := EmptyStr;
  EdtPrecoUnit.Text := EmptyStr;
  EdtPrecoTotal.Text := EmptyStr;
end;

procedure TFrmCadVenda.BtnCancelarClick(Sender: TObject);
begin
  LimpaCamposPedido();
  LimpaCamposItens();
  if MTblVendaItem.Active then
    MTblVendaItem.Close;

  if FOperacao = opAlterar then
  begin
    CarregarVendas();
    EdtCodClienteExit(Sender);
  end;

  GbxItens.Enabled := False;
  BtnGravar.Enabled := False;
  BtnCancelar.Enabled := False;
  GbxDados.Enabled := True;
  EdtDataVenda.SetFocus;
end;

procedure TFrmCadVenda.PreencheCdsVendaItem(FOperacao: TOperacao);
begin
  with MTblVendaItem do
  begin
    SoNumeros(EdtTotalVenda.Text);
    totVenda := StrToFloat(SoNumeros(EdtTotalVenda.Text));
    MTblVendaItem.Append;
    MTblVendaItemID_ITEM.AsInteger := idItem;
    MTblVendaItemCOD_PRODUTO.AsInteger := LCbxProdutos.KeyValue;
    MTblVendaItemDES_DESCRICAO.AsString := LCbxProdutos.Text;
    MTblVendaItemVAL_QUANTIDADE.AsInteger := StrToInt(EdtQuantidade.Text);
    MTblVendaItemVAL_PRECO_UNITARIO.AsFloat := StrToFloat(EdtPrecoUnit.Text);
    MTblVendaItemVAL_TOTAL_VENDA.AsFloat := StrToFloat(EdtPrecoTotal.Text);
    MTblVendaItem.Post;
    totVenda := totVenda +  MTblVendaItemVAL_TOTAL_VENDA.AsFloat;     ///// Verificar Calculos
    EdtTotalVenda.Text := FloatToStr(totVenda);
    idItem := idItem + 1
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

procedure TFrmCadVenda.EdtCodClienteKeyPress(Sender: TObject; var Key: Char);
begin
  if not( key in['0'..'9',#08] ) then
    key:=#0;
end;

procedure TFrmCadVenda.EdtDataVendaChange(Sender: TObject);
begin
  Formatar(EdtDataVenda, TFormato.Dt, '')
end;

procedure TFrmCadVenda.EdtDataVendaKeyPress(Sender: TObject; var Key: Char);
begin
  if not( key in['0'..'9',#08, '/'] ) then
    key:=#0;
end;

procedure TFrmCadVenda.EdtPrecoTotalKeyPress(Sender: TObject; var Key: Char);
begin
  if not( key in['0'..'9',#08] ) then
    key:=#0;
end;

procedure TFrmCadVenda.EdtPrecoUnitKeyPress(Sender: TObject; var Key: Char);
begin
  if not( key in['0'..'9',#08] ) then
    key:=#0;
end;

procedure TFrmCadVenda.EdtQuantidadeKeyPress(Sender: TObject; var Key: Char);
begin
  if not( key in['0'..'9',#08] ) then
    key:=#0;
end;


end.
