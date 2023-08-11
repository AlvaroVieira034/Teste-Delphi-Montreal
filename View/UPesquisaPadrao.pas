unit UPesquisaPadrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.Buttons, Vcl.ExtCtrls;

type
  TFrmPesquisaPadrao = class(TForm)
    PnlBotoesPesquisa: TPanel;
    BtnAlterar: TSpeedButton;
    BtnExcluir: TSpeedButton;
    BtnSair: TSpeedButton;
    BtnFiltrar: TSpeedButton;
    BtnTodos: TSpeedButton;
    BtnNovo: TSpeedButton;
    PanelGrid: TPanel;
    DbGridPesquisa: TDBGrid;
    PnlPesquisar: TPanel;
    Label3: TLabel;
    BtnPesquisar: TSpeedButton;
    EdtPesquisar: TEdit;
    CbxFiltro: TComboBox;
    PnlContador: TPanel;
    LblTotRegistros: TLabel;
    DsPesquisa: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPesquisaPadrao: TFrmPesquisaPadrao;

implementation

{$R *.dfm}

end.
