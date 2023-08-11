program TesteTecnico;

uses
  Vcl.Forms,
  UMain in 'View\UMain.pas' {FrmMain},
  UManutPadrao in 'View\UManutPadrao.pas' {FrmManutPadrao},
  UPesquisaPadrao in 'View\UPesquisaPadrao.pas' {FrmPesquisaPadrao},
  UDmConexao in 'Dao\UDmConexao.pas' {DmConexao: TDataModule},
  UDmTabelas in 'Dao\UDmTabelas.pas' {DmTabelas: TDataModule},
  ClienteController in 'Controller\ClienteController.pas',
  UPesqCliente in 'View\UPesqCliente.pas' {FrmPesqCliente},
  untFormat in 'Lib\untFormat.pas',
  UCadClientes in 'View\UCadClientes.pas' {FrmCadClientes},
  Biblioteca in 'Lib\Biblioteca.pas',
  FornecedorController in 'Controller\FornecedorController.pas',
  UCadFornecedores in 'View\UCadFornecedores.pas' {FrmCadFornecedores},
  UPesqFornecedor in 'View\UPesqFornecedor.pas' {FrmPesqFornecedor},
  ProdutoController in 'Controller\ProdutoController.pas',
  UCadProduto in 'View\UCadProduto.pas' {FrmCadProduto},
  UPesqProduto in 'View\UPesqProduto.pas' {FrmPesqProduto},
  UCadVenda in 'View\UCadVenda.pas' {FrmCadVenda},
  VendaItensController in 'Controller\VendaItensController.pas',
  VendaController in 'Controller\VendaController.pas',
  UPesqVenda in 'View\UPesqVenda.pas' {FrmPesqVenda};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TDmConexao, DmConexao);
  Application.CreateForm(TDmTabelas, DmTabelas);
  Application.CreateForm(TFrmPesqVenda, FrmPesqVenda);
  Application.Run;
end.
