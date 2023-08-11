unit UCadFornecedores;

interface

{$REGION 'Uses'}
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UManutPadrao, Data.DB, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, FornecedorController;
{$ENDREGION}

type
  TOperacao = (opNovo, opAlterar, opNavegar);
  TFrmCadFornecedores = class(TFrmManutPadrao)

{$REGION 'Componentes'}
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    EdtRazaoSocial: TEdit;
    EdtCodFornecedor: TEdit;
    EdtNomeFantasia: TEdit;
    EdtCNPJ: TEdit;
    RdgAtivo: TRadioGroup;
{$ENDREGION}

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnSairClick(Sender: TObject);
    procedure EdtCNPJExit(Sender: TObject);

  private
    ValoresOriginais: array of string;

    procedure LimpaCampos();
    procedure CarregarFornecedores;
    procedure InserirFornecedores;
    procedure AlterarFornecedores;
    procedure GravarDados;
    function ValidarDados: Boolean;

  public
    FOperacao: TOperacao;

  end;

var
  FrmCadFornecedores: TFrmCadFornecedores;

implementation

{$R *.dfm}

uses UMain, UDmTabelas, untFormat, Biblioteca;

{ TFrmCadFornecedores }

procedure TFrmCadFornecedores.FormCreate(Sender: TObject);
begin
  inherited;
  SetLength(ValoresOriginais, 5);
end;

procedure TFrmCadFornecedores.FormShow(Sender: TObject);
begin
  inherited;
  BtnNovo.Visible := False;
  BtnAlterar.Visible := False;
  BtnExcluir.Visible := False;
  BtnGravar.Top := 4;
  BtnCancelar.Top := 43;
  if FOperacao = opAlterar then
  begin
    CarregarFornecedores();
    ValoresOriginais[0] := EdtCodFornecedor.Text;
    ValoresOriginais[1] := IntToStr(RdgAtivo.ItemIndex);
    ValoresOriginais[2] := EdtCnpj.Text;
    ValoresOriginais[3] := EdtRazaoSocial.Text;
    ValoresOriginais[4] := EdtNomeFantasia.Text;
    EdtCNPJ.SetFocus;
  end
  else
  if FOperacao = opNovo then
  begin
    LimpaCampos();
    EdtCNPJ.SetFocus;
  end
  else
  begin
    BtnNovo.Visible := True;
    BtnAlterar.Visible := True;
    BtnExcluir.Visible := True;
    BtnNovo.Top := 4;
    BtnAlterar.Top := 43;
    BtnExcluir.Top := 83;
    BtnGravar.Top := 123;
    BtnCancelar.Top := 163;
    LimpaCampos();
    EdtCNPJ.SetFocus;
  end;
end;

procedure TFrmCadFornecedores.CarregarFornecedores;
var Fornecedor: TFornecedor;
begin
  Fornecedor:= TFornecedor.Create;
  try
    Fornecedor.Carregar(Fornecedor, DsPadrao.DataSet.FieldByName('COD_FORNECEDOR').AsInteger);
    with Fornecedor do
    begin
      RdgAtivo.ItemIndex := Cod_Status;
      EdtCodFornecedor.Text := IntToStr(Cod_Fornecedor);
      EdtCNPJ.Text := Des_CNPJ;
      EdtRazaoSocial.Text := Des_Razao_Social;
      EdtNomeFantasia.Text := Des_Nome_Fantasia;
    end;
  finally
    FreeAndNil(Fornecedor);
  end;
end;

procedure TFrmCadFornecedores.EdtCNPJExit(Sender: TObject);
begin
  inherited;
  if not ValidarCNPJ(EdtCNPJ.Text) then
  begin
    MessageDlg('CNPJ Inválido!', mtError, [mbOk], 0);
    EdtCNPJ.SetFocus;
  end;
end;

procedure TFrmCadFornecedores.InserirFornecedores;
var Fornecedor : TFornecedor;
    sErro: String;
begin
  Fornecedor := TFornecedor.Create;
  try
    with Fornecedor do
    begin
      Cod_Status := RdgAtivo.ItemIndex;
      Des_CNPJ := EdtCNPJ.Text;
      Des_Razao_Social := EdtRazaoSocial.Text;
      Des_Nome_Fantasia := EdtNomeFantasia.Text;

      if not Fornecedor.VerificaCNPJExistente(Des_CNPJ, sErro) then
      begin
        MessageDlg('CNPJ já cadastrado anteriormente!', mtInformation, [mbOk], 0);
        exit
      end;

      if Fornecedor.Inserir(Fornecedor, sErro) = false then
        raise Exception.Create(sErro)
      else
        MessageDlg('Registro incluido com sucesso !!', mtInformation, [mbOk], 0);

      BtnSair.Click
    end;
  finally
    FreeAndNil(Fornecedor);
  end;
end;

procedure TFrmCadFornecedores.AlterarFornecedores;
var Fornecedor : TFornecedor;
    sErro: String;
begin
  Fornecedor := TFornecedor.Create;
  try
    with Fornecedor do
    begin
      Cod_Status := RdgAtivo.ItemIndex;
      Des_Cnpj := EdtCNPJ.Text;
      Des_Razao_Social := EdtRazaoSocial.Text;
      Des_Nome_Fantasia := EdtNomeFantasia.Text;
    end;

    {if not Fornecedor.VerificaCNPJExistente(EdtCNPJ.Text, sErro) then
    begin
      MessageDlg('CNPJ já cadastrado anteriormente!', mtInformation, [mbOk], 0);
      exit
    end;}

    if Fornecedor.Alterar(Fornecedor, StrToInt(EdtCodFornecedor.Text), sErro) = False then
      raise Exception.Create(sErro)
    else
      MessageDlg('Registro alterado com sucesso !!', mtInformation, [mbOK], 0);

    BtnSair.Click;
  finally
    FreeAndNil(Fornecedor);
  end;
end;

function TFrmCadFornecedores.ValidarDados: Boolean;
begin
  Result := False;
  if EdtCNPJ.Text = EmptyStr then
  begin
    MessageDlg('O CNPJ do fornecedor deve ser informado!', mtInformation, [mbOK], 0);
    EdtCNPJ.SetFocus;
    Exit;
  end;

  if EdtRazaoSocial.Text = EmptyStr then
  begin
    MessageDlg('A razão social do fornecedor deve ser informada!', mtInformation, [mbOK], 0);
    EdtRazaoSocial.SetFocus;
    Exit;
  end;

  Result := True;
end;

procedure TFrmCadFornecedores.GravarDados;
var Fornecedor : TFornecedor;
begin
  Fornecedor := TFornecedor.Create;
  try
    case FOperacao of
      opNovo    : InserirFornecedores();
      opAlterar : AlterarFornecedores();
    end;
  finally
    FreeAndNil(Fornecedor);
  end;
end;

procedure TFrmCadFornecedores.BtnGravarClick(Sender: TObject);
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

procedure TFrmCadFornecedores.BtnCancelarClick(Sender: TObject);
begin
  inherited;
  LimpaCampos();
  if FOperacao = opAlterar then
  begin
    EdtCodFornecedor.Text := ValoresOriginais[0];
    RdgAtivo.ItemIndex := StrToInt(ValoresOriginais[1]);
    EdtCNPJ.Text := ValoresOriginais[2];
    EdtRazaoSocial.Text := ValoresOriginais[3];
    EdtNomeFantasia.Text := ValoresOriginais[4];
  end;
end;

procedure TFrmCadFornecedores.BtnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmCadFornecedores.LimpaCampos;
var i : Integer;
begin
  for i := 0 to FrmCadFornecedores.ComponentCount-1 do
  begin
    if FrmCadFornecedores.Components[i] is TEdit then
    (FrmCadFornecedores.Components[i] as TEdit).Text := '';

    if FrmCadFornecedores.Components[i] is TCheckBox then
    (FrmCadFornecedores.Components[i] as TCheckBox).Checked := False;

    if FrmCadFornecedores.Components[i] is TLabeledEdit then
    (FrmCadFornecedores.Components[i] as TLabeledEdit).Text := '';
  end;
end;


end.
