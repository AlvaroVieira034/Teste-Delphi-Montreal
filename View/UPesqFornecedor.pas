unit UPesqFornecedor;

interface

{$REGION 'Uses'}
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UPesquisaPadrao, Data.DB, Vcl.StdCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.ExtCtrls;

{$ENDREGION}

type
  TFrmPesqFornecedor = class(TFrmPesquisaPadrao)
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
    procedure PesquisarFornecedores;
    procedure ExcluirFornecedores;

  public
    { Public declarations }

  end;

var
  FrmPesqFornecedor: TFrmPesqFornecedor;
  campoIndice : String;

implementation

{$R *.dfm}

uses UDMConexao, UDmTabelas, FornecedorController, UCadFornecedores;


procedure TFrmPesqFornecedor.FormShow(Sender: TObject);
begin
  inherited;
  filtroOn := False;
  PesquisarFornecedores();
end;

procedure TFrmPesqFornecedor.PesquisarFornecedores;
var Fornecedor : TFornecedor;
begin
  Fornecedor := TFornecedor.Create;
  try
    if CbxFiltro.Text = 'Nome' then
      campoIndice := 'DES_RAZAO_SOCIAL'
    else
      campoIndice := 'DES_CNPJ';

    Fornecedor.Pesquisar(Trim(EdtPesquisar.Text), campoIndice, 'Todos');
  finally
    FreeAndNil(Fornecedor);
  end;
  LblTotRegistros.Caption := 'Fornecedores: ' + InttoStr(DsPesquisa.DataSet.RecordCount);

end;

procedure TFrmPesqFornecedor.ExcluirFornecedores;
var Fornecedor : TFornecedor;
    sErro : String;
begin
  Fornecedor := TFornecedor.Create;
  try
    if MessageDlg('Deseja realmente excluir o fornecedor selecionado ?',mtConfirmation, [mbYes, mbNo],0) = IDYES then
      if Fornecedor.Excluir(DsPesquisa.DataSet.FieldByName('COD_FORNECEDOR').AsInteger, sErro) = False then
        raise Exception.Create(sErro);

  finally
    FreeAndNil(Fornecedor);
  end;
end;

procedure TFrmPesqFornecedor.BtnFiltrarClick(Sender: TObject);
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

procedure TFrmPesqFornecedor.BtnTodosClick(Sender: TObject);
begin
  inherited;
  EdtPesquisar.Text := '';
  BtnFiltrar.Click;
  PesquisarFornecedores();
end;

procedure TFrmPesqFornecedor.BtnNovoClick(Sender: TObject);
begin
  inherited;
  if not Assigned(FrmCadFornecedores) then
    FrmCadFornecedores := TFrmCadFornecedores.Create(Self);

  FrmCadFornecedores.FOperacao := opNovo;
  FrmCadFornecedores.ShowModal;
  FreeAndNil(FrmCadFornecedores);
  DsPesquisa.DataSet.Refresh;
  LblTotRegistros.Caption := 'Fornecedores: ' + InttoStr(DsPesquisa.DataSet.RecordCount);
end;

procedure TFrmPesqFornecedor.BtnAlterarClick(Sender: TObject);
begin
  inherited;
  if not Assigned(FrmCadFornecedores) then
    FrmCadFornecedores := TFrmCadFornecedores.Create(Self);

  FrmCadFornecedores.FOperacao := opAlterar;
  FrmCadFornecedores.ShowModal;
  FreeAndNil(FrmCadFornecedores);
  DsPesquisa.DataSet.Refresh;
end;

procedure TFrmPesqFornecedor.BtnExcluirClick(Sender: TObject);
begin
  inherited;
  ExcluirFornecedores();
  DsPesquisa.DataSet.Refresh;
end;

procedure TFrmPesqFornecedor.BtnPesquisarClick(Sender: TObject);
begin
  inherited;
  PesquisarFornecedores();
end;

procedure TFrmPesqFornecedor.DbGridPesquisaDblClick(Sender: TObject);
begin
  inherited;
  BtnAlterar.Click;
end;

procedure TFrmPesqFornecedor.DbGridPesquisaDrawColumnCell(Sender: TObject; const [Ref] Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
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

procedure TFrmPesqFornecedor.BtnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

end.
