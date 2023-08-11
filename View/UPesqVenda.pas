unit UPesqVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UPesquisaPadrao, Data.DB, Vcl.StdCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.ExtCtrls;

type
  TFrmPesqVenda = class(TFrmPesquisaPadrao)
    procedure FormShow(Sender: TObject);
    procedure BtnSairClick(Sender: TObject);
    procedure BtnFiltrarClick(Sender: TObject);
    procedure BtnTodosClick(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnPesquisarClick(Sender: TObject);
    procedure DbGridPesquisaDblClick(Sender: TObject);
    procedure DbGridPesquisaDrawColumnCell(Sender: TObject;
      const [Ref] Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
  private
    var filtroOn: boolean;
    procedure PesquisarVendas;
    procedure ExcluirVendas;

  public
    { Public declarations }
  end;

var
  FrmPesqVenda: TFrmPesqVenda;
  campoIndice: String;

implementation

{$R *.dfm}

uses UDMConexao, UDmTabelas, VendaController, VendaItensController, UCadVenda;

procedure TFrmPesqVenda.FormShow(Sender: TObject);
begin
  inherited;
  filtroOn := False;
  PesquisarVendas();
end;

procedure TFrmPesqVenda.PesquisarVendas;
var Venda: TVenda;
begin
  Venda := TVenda.Create;
  try
    if CbxFiltro.Text = 'Cliente' then
      campoIndice := 'CLI.DES_NOME';

    Venda.Pesquisar(Trim(EdtPesquisar.Text), campoIndice);
  finally
    FreeAndNil(Venda);
  end;
  LblTotRegistros.Caption := 'Vendas: ' + InttoStr(DsPesquisa.DataSet.RecordCount);
end;

procedure TFrmPesqVenda.ExcluirVendas;
var Venda: TVenda;
    sErro: String;
begin
  Venda := TVenda.Create;
  try
    if MessageDlg('Deseja realmente excluir a venda selecionada ?',mtConfirmation, [mbYes, mbNo],0) = IDYES then
      if Venda.Excluir(DsPesquisa.DataSet.FieldByName('COD_VENDA').AsInteger, sErro) = False then
        raise Exception.Create(sErro);

  finally
    FreeAndNil(Venda);
  end;
end;

procedure TFrmPesqVenda.BtnFiltrarClick(Sender: TObject);
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

procedure TFrmPesqVenda.BtnTodosClick(Sender: TObject);
begin
  inherited;
  EdtPesquisar.Text := '';
  BtnFiltrar.Click;
  PesquisarVendas();
end;

procedure TFrmPesqVenda.BtnNovoClick(Sender: TObject);
begin
  inherited;
  if not Assigned(FrmCadVenda) then
    FrmCadVenda := TFrmCadVenda.Create(Self);

  FrmCadVenda.FOperacao := opNovo;
  FrmCadVenda.ShowModal;
  FreeAndNil(FrmCadVenda);
  DsPesquisa.DataSet.Refresh;
  LblTotRegistros.Caption := 'Vendas: ' + InttoStr(DsPesquisa.DataSet.RecordCount);
end;

procedure TFrmPesqVenda.BtnAlterarClick(Sender: TObject);
begin
  inherited;
  if not Assigned(FrmCadVenda) then
    FrmCadVenda := TFrmCadVenda.Create(Self);

  FrmCadVenda.FOperacao := opAlterar;
  FrmCadVenda.ShowModal;
  FreeAndNil(FrmCadVenda);
  DsPesquisa.DataSet.Refresh;
end;

procedure TFrmPesqVenda.BtnExcluirClick(Sender: TObject);
begin
  inherited;
  //ExcluirProdutos();
  //DsPesquisa.DataSet.Refresh;
end;

procedure TFrmPesqVenda.BtnPesquisarClick(Sender: TObject);
begin
  inherited;
  //PesquisarProdutos();
end;

procedure TFrmPesqVenda.DbGridPesquisaDblClick(Sender: TObject);
begin
  inherited;
  BtnAlterar.Click;
end;

procedure TFrmPesqVenda.DbGridPesquisaDrawColumnCell(Sender: TObject; const [Ref] Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
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

procedure TFrmPesqVenda.BtnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

end.
