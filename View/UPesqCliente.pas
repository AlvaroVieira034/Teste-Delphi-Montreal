unit UPesqCliente;

interface

{$REGION 'Uses'}
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UPesquisaPadrao, Data.DB, Vcl.StdCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.ExtCtrls;
{$ENDREGION}

type
  TFrmPesqCliente = class(TFrmPesquisaPadrao)
    procedure FormShow(Sender: TObject);
    procedure BtnFiltrarClick(Sender: TObject);
    procedure BtnTodosClick(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnPesquisarClick(Sender: TObject);
    procedure BtnSairClick(Sender: TObject);
    procedure DbGridPesquisaDblClick(Sender: TObject);
    procedure DbGridPesquisaDrawColumnCell(Sender: TObject; const [Ref] Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);

  private
    var filtroOn: boolean;
    procedure PesquisarClientes;
    procedure ExcluirClientes;

  public

  end;

var
  FrmPesqCliente: TFrmPesqCliente;
  campoIndice : String;

implementation

{$R *.dfm}

uses UDMConexao, UDmTabelas, ClienteController, UCadClientes;


{ TFrmPesqCliente }

procedure TFrmPesqCliente.FormShow(Sender: TObject);
begin
  inherited;
  filtroOn := False;
  PesquisarClientes();
end;

procedure TFrmPesqCliente.PesquisarClientes;
var Cliente : TCliente;
begin
  Cliente := TCliente.Create;
  try
    if CbxFiltro.Text = 'Nome' then
      campoIndice := 'DES_NOME'
    else
      campoIndice := 'DES_CPF';

    Cliente.Pesquisar(Trim(EdtPesquisar.Text), campoIndice, '');
  finally
    FreeAndNil(Cliente);
  end;
  LblTotRegistros.Caption := 'Clientes: ' + InttoStr(DsPesquisa.DataSet.RecordCount);
end;

procedure TFrmPesqCliente.ExcluirClientes;
var Cliente : TCliente;
    sErro : String;
begin
  Cliente := TCliente.Create;
  try
    if MessageDlg('Deseja realmente excluir o cliente selecionado ?',mtConfirmation, [mbYes, mbNo],0) = IDYES then
      if Cliente.Excluir(DsPesquisa.DataSet.FieldByName('COD_CLIENTE').AsInteger, sErro) = False then
        raise Exception.Create(sErro);

  finally
    FreeAndNil(Cliente);
  end;

end;

procedure TFrmPesqCliente.BtnFiltrarClick(Sender: TObject);
begin
  inherited;
  if filtroOn then
  begin
    PnlPesquisar.Visible := False;
    filtroOn := False;
  end
  else
   begin
    PnlContador.Visible := False;
    PnlPesquisar.Visible := True;
    PnlContador.Visible := True;
    filtroOn := True;
  end
end;

procedure TFrmPesqCliente.BtnTodosClick(Sender: TObject);
begin
  inherited;
  EdtPesquisar.Text := '';
  BtnFiltrar.Click;
  PesquisarClientes();
end;

procedure TFrmPesqCliente.BtnNovoClick(Sender: TObject);
begin
  inherited;
  if not Assigned(FrmCadClientes) then
    FrmCadClientes := TFrmCadClientes.Create(Self);

  FrmCadClientes.FOperacao := opNovo;
  FrmCadClientes.ShowModal;
  FreeAndNil(FrmCadClientes);
  DsPesquisa.DataSet.Refresh;
  LblTotRegistros.Caption := 'Clientes: ' + InttoStr(DsPesquisa.DataSet.RecordCount);
end;

procedure TFrmPesqCliente.BtnAlterarClick(Sender: TObject);
begin
  inherited;
  if not Assigned(FrmCadClientes) then
    FrmCadClientes := TFrmCadClientes.Create(Self);

  FrmCadClientes.FOperacao := opAlterar;
  FrmCadClientes.ShowModal;
  FreeAndNil(FrmCadClientes);
  DsPesquisa.DataSet.Refresh;
end;

procedure TFrmPesqCliente.BtnExcluirClick(Sender: TObject);
begin
  inherited;
  ExcluirClientes();
  DsPesquisa.DataSet.Refresh;
end;

procedure TFrmPesqCliente.BtnPesquisarClick(Sender: TObject);
begin
  inherited;
  PesquisarClientes();
end;

procedure TFrmPesqCliente.BtnSairClick(Sender: TObject);
begin
  inherited;
  Close
end;

procedure TFrmPesqCliente.DbGridPesquisaDblClick(Sender: TObject);
begin
  inherited;
  BtnAlterar.Click;
end;

procedure TFrmPesqCliente.DbGridPesquisaDrawColumnCell(Sender: TObject; const [Ref] Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var Check: Integer;
    R: TRect;
begin
  inherited;
  if ((Sender as TDBGrid).DataSource.Dataset.IsEmpty) then
    Exit;

  // Desenha um checkbox no dbgrid
  if Column.FieldName = 'COD_STATUS' then
  begin
    TDBGrid(Sender).Canvas.FillRect(Rect);
    if ((Sender as TDBGrid).DataSource.Dataset.FieldByName('COD_STATUS').AsInteger = 1) then
      Check := 0
    else
      Check := DFCS_CHECKED;

    R := Rect;
    InflateRect(R, -2, -2); { Diminue o tamanho do CheckBox }
    DrawFrameControl(TDBGrid(Sender).Canvas.Handle, R, DFC_BUTTON, DFCS_BUTTONCHECK or Check);
  end;
end;


end.
