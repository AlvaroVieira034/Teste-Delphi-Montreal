unit UCadClientes;

interface

{$REGION 'Uses'}
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UManutPadrao, Data.DB, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.StdCtrls, ClienteController;
{$ENDREGION}

type
  TOperacao = (opNovo, opAlterar, opNavegar);
  TFrmCadClientes = class(TFrmManutPadrao)

{$REGION 'Componentes'}
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    EdtNomeCliente: TEdit;
    EdtCodCliente: TEdit;
    EdtDataNascimento: TEdit;
    EdtCPF: TEdit;
    RdgAtivo: TRadioGroup;
{$ENDREGION}

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure EdtCPFExit(Sender: TObject);
    procedure BtnSairClick(Sender: TObject);
    procedure EdtDataNascimentoChange(Sender: TObject);

  private
    ValoresOriginais: array of string;
    procedure CarregarClientes;
    procedure InserirClientes;
    procedure AlterarClientes;
    function ValidarDados: Boolean;
    procedure GravarDados;
    procedure LimpaCampos();

  public
    FOperacao: TOperacao;

  end;

var
  FrmCadClientes: TFrmCadClientes;

implementation

{$R *.dfm}

uses UMain, UDmTabelas, untFormat, Biblioteca;

{ TFrmCadClientes }


procedure TFrmCadClientes.FormCreate(Sender: TObject);
begin
  inherited;
  SetLength(ValoresOriginais, 5);
end;

procedure TFrmCadClientes.FormShow(Sender: TObject);
begin
  inherited;
  BtnNovo.Visible := False;
  BtnAlterar.Visible := False;
  BtnExcluir.Visible := False;
  BtnGravar.Top := 4;
  BtnCancelar.Top := 43;
  if FOperacao = opAlterar then
  begin
    CarregarClientes();
    ValoresOriginais[0] := EdtCodCliente.Text;
    ValoresOriginais[1] := IntToStr(RdgAtivo.ItemIndex);
    ValoresOriginais[2] := EdtCPF.Text;
    ValoresOriginais[3] := EdtNomeCliente.Text;
    ValoresOriginais[4] := EdtDataNascimento.Text;
    EdtCPF.SetFocus;
  end
  else
  if FOperacao = opNovo then
  begin
    LimpaCampos();
    EdtCPF.SetFocus;
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
    EdtCPF.SetFocus;
  end;
end;

procedure TFrmCadClientes.CarregarClientes;
var Cliente: TCliente;
begin
  Cliente:= TCliente.Create;
  try
    Cliente.Carregar(Cliente, DsPadrao.DataSet.FieldByName('COD_CLIENTE').AsInteger);
    with Cliente do
    begin
      RdgAtivo.ItemIndex := Cod_Status;
      EdtCodCliente.Text := IntToStr(Cod_Cliente);
      EdtCPF.Text := Des_CPF;
      EdtNomeCliente.Text := Des_Nome;
      EdtDataNascimento.Text := DateToStr(Dta_Nascimento);
    end;
  finally
    FreeAndNil(Cliente);
  end;
end;

procedure TFrmCadClientes.InserirClientes;
var Cliente : TCliente;
    sErro: String;
begin
  Cliente := TCliente.Create;
  try
    with Cliente do
    begin
      Cod_Status := RdgAtivo.ItemIndex;
      Des_CPF := EdtCPF.Text;
      Des_Nome := EdtNomeCliente.Text;
      Dta_Nascimento := StrToDate(EdtDataNascimento.Text);

      if not Cliente.VerificaCPFExistente(Des_CPF, sErro) then
      begin
        MessageDlg('CPF já cadastrado anteriormente!', mtInformation, [mbOk], 0);
        exit
      end;

      if Cliente.Inserir(Cliente, sErro) = false then
        raise Exception.Create(sErro)
      else
        MessageDlg('Registro incluido com sucesso !!', mtInformation, [mbOk], 0);

      BtnSair.Click
    end;
  finally
    FreeAndNil(Cliente);
  end;
end;

procedure TFrmCadClientes.AlterarClientes;
var Cliente : TCliente;
    sErro: String;
begin
  Cliente := TCliente.Create;
  try
    with Cliente do
    begin
      Cod_Status := RdgAtivo.ItemIndex;
      Des_CPF := EdtCPF.Text;
      Des_Nome := EdtNomeCliente.Text;
      Dta_Nascimento := StrToDate(EdtDataNascimento.Text);
    end;

    {if not Cliente.VerificaCPFExistente(EdtCPF.Text, sErro) then
    begin
      MessageDlg('CPF já cadastrado anteriormente!', mtInformation, [mbOk], 0);
      exit
    end;}

    if Cliente.Alterar(Cliente, StrToInt(EdtCodCliente.Text), sErro) = False then
      raise Exception.Create(sErro)
    else
      MessageDlg('Registro alterado com sucesso !!', mtInformation, [mbOK], 0);

    BtnSair.Click;
  finally
    FreeAndNil(Cliente);
  end;

end;

function TFrmCadClientes.ValidarDados: Boolean;
begin
  Result := False;
  if EdtCPF.Text = EmptyStr then
  begin
    MessageDlg('O CPF do cliente deve ser informado!', mtInformation, [mbOK], 0);
    EdtCPF.SetFocus;
    Exit;
  end;

  if EdtNomeCliente.Text = EmptyStr then
  begin
    MessageDlg('O nome do cliente deve ser informado!', mtInformation, [mbOK], 0);
    EdtNomeCliente.SetFocus;
    Exit;
  end;

  if EdtDataNascimento.Text = EmptyStr then
  begin
    MessageDlg('A data de nascimdento do cliente deve ser informada!', mtInformation, [mbOK], 0);
    EdtDataNascimento.SetFocus;
    Exit;
  end;

  Result := True;
end;

procedure TFrmCadClientes.GravarDados;
var Cliente : TCliente;
begin
  Cliente := TCliente.Create;
  try
    case FOperacao of
      opNovo    : InserirClientes();
      opAlterar : AlterarClientes();
    end;
  finally
    FreeAndNil(Cliente);
  end;
end;

procedure TFrmCadClientes.BtnGravarClick(Sender: TObject);
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

procedure TFrmCadClientes.BtnCancelarClick(Sender: TObject);
begin
  inherited;
  LimpaCampos();
  if FOperacao = opAlterar then
  begin
    EdtCodCliente.Text := ValoresOriginais[0];
    RdgAtivo.ItemIndex := StrToInt(ValoresOriginais[1]);
    EdtCPF.Text := ValoresOriginais[2];
    EdtNomeCliente.Text := ValoresOriginais[3];
    EdtDataNascimento.Text := ValoresOriginais[4];
  end;
end;

procedure TFrmCadClientes.BtnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmCadClientes.LimpaCampos;
var i : Integer;
begin
  for i := 0 to FrmCadClientes.ComponentCount-1 do
  begin
    if FrmCadClientes.Components[i] is TEdit then
    (FrmCadClientes.Components[i] as TEdit).Text := '';

    if FrmCadClientes.Components[i] is TCheckBox then
    (FrmCadClientes.Components[i] as TCheckBox).Checked := False;

    if FrmCadClientes.Components[i] is TLabeledEdit then
    (FrmCadClientes.Components[i] as TLabeledEdit).Text := '';
  end;

end;

procedure TFrmCadClientes.EdtCPFExit(Sender: TObject);
begin
  inherited;
  if not ValidarCPF(EdtCPF.Text) then
  begin
    MessageDlg('CPF Inválido!', mtError, [mbOk], 0);
    EdtCPF.SetFocus;
  end;
end;









procedure TFrmCadClientes.EdtDataNascimentoChange(Sender: TObject);
begin
  inherited;
  Formatar(EdtDataNascimento, TFormato.Dt, '')
end;

end.
