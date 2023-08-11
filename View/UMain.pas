unit UMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls,
  System.ImageList, Vcl.ImgList, Vcl.Menus;

type
  TFrmMain = class(TForm)
    MainMenu: TMainMenu;
    Cadastros1: TMenuItem;
    Usurios1: TMenuItem;
    Clientes1: TMenuItem;
    Produtos1: TMenuItem;
    Sistemas1: TMenuItem;
    Carga1: TMenuItem;
    Relatrios1: TMenuItem;
    Parmetros1: TMenuItem;
    Sair1: TMenuItem;
    Timer1: TTimer;
    ImageList: TImageList;
    PanelBotoesMenu: TPanel;
    BtnFornecedores: TSpeedButton;
    BtnClientes: TSpeedButton;
    BtnSair: TSpeedButton;
    BtnVendas: TSpeedButton;
    SpeedButtonRelatorios: TSpeedButton;
    BtnProdutos: TSpeedButton;
    procedure BtnSairClick(Sender: TObject);
    procedure BtnClientesClick(Sender: TObject);
    procedure BtnFornecedoresClick(Sender: TObject);
    procedure BtnProdutosClick(Sender: TObject);
    procedure BtnVendasClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

uses UDmConexao, UDmTabelas, UPesqCliente, UPesqFornecedor, UPesqProduto, UPesqVenda;

procedure TFrmMain.BtnClientesClick(Sender: TObject);
begin
  if not Assigned(FrmPesqCliente) then
    FrmPesqCliente := TFrmPesqCliente.Create(Self);

  FrmPesqCliente.ShowModal;
  FreeAndNil(FrmPesqCliente);
end;

procedure TFrmMain.BtnFornecedoresClick(Sender: TObject);
begin
  if not Assigned(FrmPesqFornecedor) then
    FrmPesqFornecedor := TFrmPesqFornecedor.Create(Self);

  FrmPesqFornecedor.ShowModal;
  FreeAndNil(FrmPesqFornecedor);
end;

procedure TFrmMain.BtnProdutosClick(Sender: TObject);
begin
  if not Assigned(FrmPesqProduto) then
    FrmPesqProduto := TFrmPesqProduto.Create(Self);

  FrmPesqProduto.ShowModal;
  FreeAndNil(FrmPesqProduto);
end;

procedure TFrmMain.BtnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmMain.BtnVendasClick(Sender: TObject);
begin
  if not Assigned(FrmPesqVenda) then
    FrmPesqVenda := TFrmPesqVenda.Create(Self);

  FrmPesqVenda.ShowModal;
  FreeAndNil(FrmPesqVenda);
end;

end.
