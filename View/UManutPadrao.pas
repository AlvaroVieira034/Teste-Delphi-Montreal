unit UManutPadrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Buttons, Vcl.ExtCtrls;

type
  TFrmManutPadrao = class(TForm)
    PanelBotoes: TPanel;
    BtnGravar: TSpeedButton;
    BtnSair: TSpeedButton;
    BtnCancelar: TSpeedButton;
    DsPadrao: TDataSource;
    PanelDados: TPanel;
    BtnNovo: TSpeedButton;
    BtnAlterar: TSpeedButton;
    BtnExcluir: TSpeedButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmManutPadrao: TFrmManutPadrao;

implementation

{$R *.dfm}

end.
