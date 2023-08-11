unit UCadProduto;

interface

{$REGION 'Uses'}
uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, System.UITypes,
  UManutPadrao, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.ComCtrls, Data.DB, Vcl.Controls, Vcl.Graphics, Vcl.Forms,
  Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls, ProdutoController, FornecedorController,
  Vcl.Mask;
{$ENDREGION}

type
  TOperacao = (opNovo, opAlterar, opNavegar);
  TFrmCadProduto = class(TFrmManutPadrao)

{$REGION 'Componentes'}
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    EdtPrecoUnitario: TEdit;
    EdtCodProduto: TEdit;
    EdtCodFornecedor: TEdit;
    EdtDescricao: TEdit;
    RdgAtivo: TRadioGroup;
    LCbxFornecedor: TDBLookupComboBox;
{$ENDREGION}

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnSairClick(Sender: TObject);
    procedure EdtCodFornecedorExit(Sender: TObject);
    procedure LCbxFornecedorClick(Sender: TObject);
    procedure EdtCodFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure EdtPrecoUnitarioChange(Sender: TObject);
    procedure EdtPrecoUnitarioKeyPress(Sender: TObject; var Key: Char);
    procedure EdtPrecoUnitarioExit(Sender: TObject);


  private
    ValoresOriginais: array of string;
    procedure CarregarProdutos;
    procedure InserirProdutos;
    procedure AlterarProdutos;
    function ValidarDados: Boolean;
    procedure GravarDados;
    procedure LimpaCampos();
    procedure PesquisarFornecedoresAtivos;

  public
    FOperacao: TOperacao;

  end;

var
  FrmCadProduto: TFrmCadProduto;

implementation

{$R *.dfm}

uses UMain, UDmTabelas, untFormat, Biblioteca, System.SysUtils;


procedure TFrmCadProduto.FormCreate(Sender: TObject);
begin
  inherited;
  PesquisarFornecedoresAtivos();
  SetLength(ValoresOriginais, 5);
end;

procedure TFrmCadProduto.FormShow(Sender: TObject);
begin
  inherited;
  BtnNovo.Visible := False;
  BtnAlterar.Visible := False;
  BtnExcluir.Visible := False;
  BtnGravar.Top := 4;
  BtnCancelar.Top := 42;
  if FOperacao = opAlterar then
  begin
    CarregarProdutos();
    ValoresOriginais[0] := EdtCodProduto.Text;
    ValoresOriginais[1] := IntToStr(RdgAtivo.ItemIndex);
    ValoresOriginais[2] := EdtDescricao.Text;
    ValoresOriginais[3] := EdtPrecoUnitario.Text;
    ValoresOriginais[4] := EdtCodProduto.Text;
    EdtCodFornecedorExit(Sender);
    EdtDescricao.SetFocus;
  end
  else
  if FOperacao = opNovo then
  begin
    LimpaCampos();
    EdtPrecoUnitario.Text := '0';
    EdtDescricao.SetFocus;
  end
  else
  begin
    BtnNovo.Visible := True;
    BtnAlterar.Visible := True;
    BtnExcluir.Visible := True;
    BtnNovo.Top := 4;
    BtnAlterar.Top := 42;
    BtnExcluir.Top := 80;
    BtnGravar.Top := 118;
    BtnCancelar.Top := 156;
    LimpaCampos();
    EdtDescricao.SetFocus;
  end;
end;

procedure TFrmCadProduto.CarregarProdutos;
var Produto: TProduto;
begin
  Produto:= TProduto.Create;
  try
    Produto.Carregar(Produto, DsPadrao.DataSet.FieldByName('COD_PRODUTO').AsInteger);
    with Produto do
    begin
      RdgAtivo.ItemIndex := Cod_Status;
      EdtCodProduto.Text := IntToStr(Cod_Produto);
      EdtDescricao.Text := Des_Descricao;
      EdtPrecoUnitario.Text := FormatFloat('##,###,##0.00', Val_Preco_Unitario);
      EdtCodFornecedor.Text := IntToStr(Cod_Fornecedor);
    end;
  finally
    FreeAndNil(Produto);
  end;

end;

procedure TFrmCadProduto.EdtCodFornecedorExit(Sender: TObject);
begin
  inherited;
  if EdtCodFornecedor.Text <> '' then
    LCbxFornecedor.KeyValue := StrToInt(EdtCodFornecedor.Text);
end;

procedure TFrmCadProduto.EdtCodFornecedorKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not( key in['0'..'9',#08] ) then
    key:=#0;
end;

procedure TFrmCadProduto.EdtPrecoUnitarioChange(Sender: TObject);
begin
  inherited;
  //Formatar(EdtPrecoUnitario, TFormato.Valor);
end;

procedure TFrmCadProduto.EdtPrecoUnitarioExit(Sender: TObject);
var valor: Double;
begin
  inherited;

end;

procedure TFrmCadProduto.EdtPrecoUnitarioKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if not( key in['0'..'9',',',#08] ) then
    key:=#0;
end;

procedure TFrmCadProduto.InserirProdutos;
var Produto : TProduto;
    sErro: String;
begin
  Produto := TProduto.Create;
  try
    with Produto do
    begin
      Cod_Status := RdgAtivo.ItemIndex;
      Des_Descricao := EdtDescricao.Text;
      Val_Preco_Unitario := StrToFloat(EdtPrecoUnitario.Text);
      Cod_Fornecedor := StrToInt(EdtCodFornecedor.Text);

      if Produto.Inserir(Produto, sErro) = false then
        raise Exception.Create(sErro)
      else
        MessageDlg('Registro incluido com sucesso !!', mtInformation, [mbOk], 0);

      BtnSair.Click
    end;
  finally
    FreeAndNil(Produto);
  end;

end;

procedure TFrmCadProduto.AlterarProdutos;
var Produto : TProduto;
    sErro: String;
begin
  Produto := TProduto.Create;
  try
    with Produto do
    begin
      Cod_Status := RdgAtivo.ItemIndex;
      Des_Descricao := EdtDescricao.Text;
      Val_Preco_Unitario := StrToFloat(EdtPrecoUnitario.Text);
      Cod_Fornecedor := StrToInt(EdtCodFornecedor.Text);
    end;

    if Produto.Alterar(Produto, StrToInt(EdtCodProduto.Text), sErro) = False then
      raise Exception.Create(sErro)
    else
      MessageDlg('Registro alterado com sucesso !!', mtInformation, [mbOK], 0);

    BtnSair.Click;
  finally
    FreeAndNil(Produto);
  end;

end;

function TFrmCadProduto.ValidarDados: Boolean;
begin
  Result := False;
  if EdtDescricao.Text = EmptyStr then
  begin
    MessageDlg('A descrição do produto deve ser informada!', mtInformation, [mbOK], 0);
    EdtDescricao.SetFocus;
    Exit;
  end;

  if StrToFloat(EdtPrecoUnitario.Text) = 0 then
  begin
    MessageDlg('O preço unitário deve ser maior que 0!', mtInformation, [mbOK], 0);
    EdtPrecoUnitario.SetFocus;
    Exit;
  end;

  Result := True;
end;

procedure TFrmCadProduto.GravarDados;
var Produto : TProduto;
begin
  Produto := TProduto.Create;
  try
    case FOperacao of
      opNovo    : InserirProdutos();
      opAlterar : AlterarProdutos();
    end;
  finally
    FreeAndNil(Produto);
  end;
end;

procedure TFrmCadProduto.BtnGravarClick(Sender: TObject);
begin
  inherited;
  if not ValidarDados then
  begin
    Exit;
  end
  else
  begin
    GravarDados();
  end;
end;

procedure TFrmCadProduto.BtnCancelarClick(Sender: TObject);
begin
  inherited;
  LimpaCampos();
  if FOperacao = opAlterar then
  begin
    EdtCodProduto.Text := ValoresOriginais[0];
    RdgAtivo.ItemIndex := StrToInt(ValoresOriginais[1]);
    EdtDescricao.Text := ValoresOriginais[2];
    EdtPrecoUnitario.Text := ValoresOriginais[3];
    EdtCodProduto.Text := ValoresOriginais[4];
  end;
end;

procedure TFrmCadProduto.BtnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmCadProduto.LCbxFornecedorClick(Sender: TObject);
begin
  inherited;
  if LCbxFornecedor.KeyValue > 0 then
    EdtCodFornecedor.Text := IntToStr(LCbxFornecedor.KeyValue)
end;

procedure TFrmCadProduto.LimpaCampos;
var i : Integer;
begin
  for i := 0 to FrmCadProduto.ComponentCount-1 do
  begin
    if FrmCadProduto.Components[i] is TEdit then
    (FrmCadProduto.Components[i] as TEdit).Text := '';

    if FrmCadProduto.Components[i] is TCheckBox then
    (FrmCadProduto.Components[i] as TCheckBox).Checked := False;

    if FrmCadProduto.Components[i] is TLabeledEdit then
    (FrmCadProduto.Components[i] as TLabeledEdit).Text := '';
  end;
end;

procedure TFrmCadProduto.PesquisarFornecedoresAtivos;
var Fornecedor: TFornecedor;
    campoIndice: string;
begin
  Fornecedor := TFornecedor.Create;
  campoIndice := 'DES_RAZAO_SOCIAL';
  try
    Fornecedor.Pesquisar('', campoIndice, 'Ativos');
  finally
    FreeAndNil(Fornecedor);
  end;
end;

end.
