unit UDmTabelas;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TDmTabelas = class(TDataModule)
    TblClientes: TFDQuery;
    DsClientes: TDataSource;
    TblFornecedores: TFDQuery;
    DsFornecedores: TDataSource;
    TblClientesCOD_CLIENTE: TFDAutoIncField;
    TblClientesCOD_STATUS: TIntegerField;
    TblClientesDES_NOME: TStringField;
    TblClientesDES_CPF: TStringField;
    TblClientesDTA_NASCIMENTO: TSQLTimeStampField;
    DsProdutos: TDataSource;
    TblVendas: TFDQuery;
    DsVendas: TDataSource;
    TblFornecedoresCOD_FORNECEDOR: TFDAutoIncField;
    TblFornecedoresCOD_STATUS: TIntegerField;
    TblFornecedoresDES_RAZAO_SOCIAL: TStringField;
    TblFornecedoresDES_NOME_FANTASIA: TStringField;
    TblFornecedoresDES_CNPJ: TStringField;
    TblVendasProdutos: TFDQuery;
    DsVendasProdutos: TDataSource;
    QryInserir: TFDQuery;
    QryAlterar: TFDQuery;
    QryExcluir: TFDQuery;
    QryPesquisar: TFDQuery;
    QryTemp: TFDQuery;
    TblProdutos: TFDQuery;
    TblProdutosCOD_PRODUTO: TFDAutoIncField;
    TblProdutosCOD_STATUS: TIntegerField;
    TblProdutosDES_DESCRICAO: TStringField;
    TblProdutosVAL_PRECO_UNITARIO: TFloatField;
    TblProdutosCOD_FORNECEDOR: TIntegerField;
    TblVendasProdutosCOD_VENDA: TIntegerField;
    TblVendasProdutosCOD_PRODUTO: TIntegerField;
    TblVendasProdutosDES_DESCRICAO: TStringField;
    TblVendasProdutosVAL_PRECO_UNITARIO: TFloatField;
    TblVendasProdutosVAL_QUANTIDADE: TIntegerField;
    TblVendasProdutosVAL_TOTAL_VENDA: TFloatField;
    QryPesquisarItens: TFDQuery;
    QryPesquisarItensCOD_VENDA: TIntegerField;
    QryPesquisarItensCOD_PRODUTO: TIntegerField;
    QryPesquisarItensDES_DESCRICAO: TStringField;
    QryPesquisarItensVAL_PRECO_UNITARIO: TFloatField;
    QryPesquisarItensVAL_QUANTIDADE: TIntegerField;
    QryPesquisarItensVAL_TOTAL_VENDA: TFloatField;
    TblVendasCOD_VENDA: TFDAutoIncField;
    TblVendasCOD_CLIENTE: TIntegerField;
    TblVendasDES_NOME: TStringField;
    TblVendasDTA_VENDA: TSQLTimeStampField;
    TblVendasVAL_TOT_VENDA: TFloatField;
    TblVendasCOD_STATUS: TIntegerField;
    TblVendasVDA_STATUS: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DmTabelas: TDmTabelas;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

uses UDmConexao;

end.
