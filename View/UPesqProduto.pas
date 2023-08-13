unit UPesqProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UPesquisaPadrao, Data.DB, Vcl.StdCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.ExtCtrls;

type
  TFrmPesqProduto = class(TFrmPesquisaPadrao)
    procedure FormShow(Sender: TObject);
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
    procedure BtnSairClick(Sender: TObject);
  private
    var filtroOn: boolean;
    procedure PesquisarProdutos;
    procedure ExcluirProdutos;

  public
    { Public declarations }
  end;

var
  FrmPesqProduto: TFrmPesqProduto;
  campoIndice: String;

implementation

{$R *.dfm}

uses UDMConexao, UDmTabelas, ProdutoController, UCadProduto;


procedure TFrmPesqProduto.FormShow(Sender: TObject);
begin
  inherited;
  filtroOn := False;
  PesquisarProdutos();
end;

procedure TFrmPesqProduto.PesquisarProdutos;
var Produto : TProduto;
begin
  Produto := TProduto.Create;
  try
    if CbxFiltro.Text = 'Código' then
      campoIndice := 'PRD.COD_PRODUTO'
    else
    if CbxFiltro.Text = 'Descrição' then
      campoIndice := 'PRD.DES_DESCRICAO'
    else
      campoIndice := 'DES_NOME_FANTASIA';

    Produto.Pesquisar(Trim(EdtPesquisar.Text), campoIndice, '');
  finally
    FreeAndNil(Produto);
  end;
  LblTotRegistros.Caption := 'Produtos: ' + InttoStr(DsPesquisa.DataSet.RecordCount);
end;

procedure TFrmPesqProduto.ExcluirProdutos;
var Produto : TProduto;
    sErro : String;
begin
  Produto := TProduto.Create;
  try
    if MessageDlg('Deseja realmente excluir o produto selecionado ?',mtConfirmation, [mbYes, mbNo],0) = IDYES then
      if Produto.Excluir(DsPesquisa.DataSet.FieldByName('COD_PRODUTO').AsInteger, sErro) = False then
        raise Exception.Create(sErro);

  finally
    FreeAndNil(Produto);
  end;
end;

procedure TFrmPesqProduto.BtnFiltrarClick(Sender: TObject);
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

procedure TFrmPesqProduto.BtnTodosClick(Sender: TObject);
begin
  inherited;
  EdtPesquisar.Text := '';
  BtnFiltrar.Click;
  PesquisarProdutos();
end;

procedure TFrmPesqProduto.BtnNovoClick(Sender: TObject);
begin
  inherited;
  if not Assigned(FrmCadProduto) then
    FrmCadProduto := TFrmCadProduto.Create(Self);

  FrmCadProduto.FOperacao := opNovo;
  FrmCadProduto.ShowModal;
  FreeAndNil(FrmCadProduto);
  DsPesquisa.DataSet.Refresh;
  LblTotRegistros.Caption := 'Produtos: ' + InttoStr(DsPesquisa.DataSet.RecordCount);
end;

procedure TFrmPesqProduto.BtnAlterarClick(Sender: TObject);
begin
  inherited;
  if not Assigned(FrmCadProduto) then
    FrmCadProduto := TFrmCadProduto.Create(Self);

  FrmCadProduto.FOperacao := opAlterar;
  FrmCadProduto.ShowModal;
  FreeAndNil(FrmCadProduto);
  DsPesquisa.DataSet.Refresh;
end;

procedure TFrmPesqProduto.BtnExcluirClick(Sender: TObject);
begin
  inherited;
  ExcluirProdutos();
  DsPesquisa.DataSet.Refresh;
end;

procedure TFrmPesqProduto.BtnPesquisarClick(Sender: TObject);
begin
  inherited;
  PesquisarProdutos();
end;

procedure TFrmPesqProduto.DbGridPesquisaDblClick(Sender: TObject);
begin
  inherited;
  BtnAlterar.Click;
end;

procedure TFrmPesqProduto.DbGridPesquisaDrawColumnCell(Sender: TObject; const [Ref] Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
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

procedure TFrmPesqProduto.BtnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

end.
