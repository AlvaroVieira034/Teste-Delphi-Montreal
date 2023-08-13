object DmTabelas: TDmTabelas
  OldCreateOrder = False
  Height = 378
  Width = 608
  object TblClientes: TFDQuery
    Connection = DmConexao.FDConnection
    SQL.Strings = (
      'SELECT  *'
      'FROM TAB_CLIENTE')
    Left = 456
    Top = 28
    object TblClientesCOD_CLIENTE: TFDAutoIncField
      FieldName = 'COD_CLIENTE'
      Origin = 'COD_CLIENTE'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object TblClientesCOD_STATUS: TIntegerField
      FieldName = 'COD_STATUS'
      Origin = 'COD_STATUS'
      Required = True
    end
    object TblClientesDES_NOME: TStringField
      FieldName = 'DES_NOME'
      Origin = 'DES_NOME'
      Size = 50
    end
    object TblClientesDES_CPF: TStringField
      FieldName = 'DES_CPF'
      Origin = 'DES_CPF'
      Size = 12
    end
    object TblClientesDTA_NASCIMENTO: TSQLTimeStampField
      FieldName = 'DTA_NASCIMENTO'
      Origin = 'DTA_NASCIMENTO'
    end
  end
  object DsClientes: TDataSource
    DataSet = TblClientes
    Left = 539
    Top = 28
  end
  object TblFornecedores: TFDQuery
    Connection = DmConexao.FDConnection
    SQL.Strings = (
      'SELECT  *'
      'FROM TAB_FORNECEDOR'
      'ORDER BY DES_RAZAO_SOCIAL'
      '')
    Left = 456
    Top = 84
    object TblFornecedoresCOD_FORNECEDOR: TFDAutoIncField
      FieldName = 'COD_FORNECEDOR'
      Origin = 'COD_FORNECEDOR'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object TblFornecedoresCOD_STATUS: TIntegerField
      FieldName = 'COD_STATUS'
      Origin = 'COD_STATUS'
      Required = True
    end
    object TblFornecedoresDES_RAZAO_SOCIAL: TStringField
      FieldName = 'DES_RAZAO_SOCIAL'
      Origin = 'DES_RAZAO_SOCIAL'
      Size = 50
    end
    object TblFornecedoresDES_NOME_FANTASIA: TStringField
      FieldName = 'DES_NOME_FANTASIA'
      Origin = 'DES_NOME_FANTASIA'
      Size = 50
    end
    object TblFornecedoresDES_CNPJ: TStringField
      FieldName = 'DES_CNPJ'
      Origin = 'DES_CNPJ'
      Size = 19
    end
  end
  object DsFornecedores: TDataSource
    DataSet = TblFornecedores
    Left = 540
    Top = 84
  end
  object DsProdutos: TDataSource
    DataSet = TblProdutos
    Left = 539
    Top = 140
  end
  object TblVendas: TFDQuery
    Connection = DmConexao.FDConnection
    SQL.Strings = (
      'SELECT VDA.COD_VENDA '
      '      ,VDA.COD_CLIENTE '
      '      ,CLI.DES_NOME '
      '      ,VDA.DTA_VENDA '
      '      ,VDA.VAL_TOTAL_VENDA AS VAL_TOT_VENDA '
      '      ,VDA.COD_STATUS '
      
        '      ,CASE WHEN VDA.COD_STATUS = 0 then '#39'0 - EFETIVADA'#39' ELSE '#39'1' +
        ' - PENDENTE'#39' END AS VDA_STATUS'
      ''
      'FROM TAB_VENDA VDA'
      
        '   INNER JOIN TAB_CLIENTE CLI ON VDA.COD_CLIENTE = CLI.COD_CLIEN' +
        'TE'
      'ORDER BY COD_VENDA'
      ''
      '')
    Left = 456
    Top = 196
    object TblVendasCOD_VENDA: TFDAutoIncField
      FieldName = 'COD_VENDA'
      Origin = 'COD_VENDA'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object TblVendasCOD_CLIENTE: TIntegerField
      FieldName = 'COD_CLIENTE'
      Origin = 'COD_CLIENTE'
      Required = True
    end
    object TblVendasDES_NOME: TStringField
      FieldName = 'DES_NOME'
      Origin = 'DES_NOME'
      Size = 50
    end
    object TblVendasDTA_VENDA: TSQLTimeStampField
      FieldName = 'DTA_VENDA'
      Origin = 'DTA_VENDA'
    end
    object TblVendasVAL_TOT_VENDA: TFloatField
      FieldName = 'VAL_TOT_VENDA'
      Origin = 'VAL_TOT_VENDA'
    end
    object TblVendasCOD_STATUS: TIntegerField
      FieldName = 'COD_STATUS'
      Origin = 'COD_STATUS'
    end
    object TblVendasVDA_STATUS: TStringField
      FieldName = 'VDA_STATUS'
      Origin = 'VDA_STATUS'
      ReadOnly = True
      Required = True
      Size = 13
    end
  end
  object DsVendas: TDataSource
    DataSet = TblVendas
    Left = 538
    Top = 196
  end
  object TblVendasProdutos: TFDQuery
    Connection = DmConexao.FDConnection
    SQL.Strings = (
      'SELECT  *'
      'FROM TAB_VENDA_PRODUTO'
      ''
      '')
    Left = 456
    Top = 252
    object TblVendasProdutosCOD_VENDA: TIntegerField
      FieldName = 'COD_VENDA'
      Origin = 'COD_VENDA'
      Required = True
    end
    object TblVendasProdutosCOD_PRODUTO: TIntegerField
      FieldName = 'COD_PRODUTO'
      Origin = 'COD_PRODUTO'
      Required = True
    end
    object TblVendasProdutosDES_DESCRICAO: TStringField
      FieldName = 'DES_DESCRICAO'
      Origin = 'DES_DESCRICAO'
      Size = 50
    end
    object TblVendasProdutosVAL_PRECO_UNITARIO: TFloatField
      FieldName = 'VAL_PRECO_UNITARIO'
      Origin = 'VAL_PRECO_UNITARIO'
      DisplayFormat = '#,##0.00'
    end
    object TblVendasProdutosVAL_QUANTIDADE: TIntegerField
      FieldName = 'VAL_QUANTIDADE'
      Origin = 'VAL_QUANTIDADE'
      Required = True
    end
    object TblVendasProdutosVAL_TOTAL_VENDA: TFloatField
      FieldName = 'VAL_TOTAL_VENDA'
      Origin = 'VAL_TOTAL_VENDA'
      DisplayFormat = '#,##0.00'
    end
  end
  object DsVendasProdutos: TDataSource
    DataSet = TblVendasProdutos
    Left = 538
    Top = 252
  end
  object QryInserir: TFDQuery
    Connection = DmConexao.FDConnection
    SQL.Strings = (
      '')
    Left = 40
    Top = 19
  end
  object QryAlterar: TFDQuery
    Connection = DmConexao.FDConnection
    Left = 40
    Top = 87
  end
  object QryExcluir: TFDQuery
    Connection = DmConexao.FDConnection
    Left = 40
    Top = 146
  end
  object QryPesquisar: TFDQuery
    Connection = DmConexao.FDConnection
    SQL.Strings = (
      '')
    Left = 40
    Top = 209
  end
  object QryTemp: TFDQuery
    Connection = DmConexao.FDConnection
    Left = 40
    Top = 274
  end
  object TblProdutos: TFDQuery
    Connection = DmConexao.FDConnection
    SQL.Strings = (
      'SELECT PRD.COD_PRODUTO'
      '      ,PRD.COD_STATUS'
      '      ,PRD.DES_DESCRICAO'
      '      ,PRD.VAL_PRECO_UNITARIO'
      '      ,PRD.COD_FORNECEDOR'
      '      ,FRN.DES_NOME_FANTASIA'
      'FROM TAB_PRODUTO PRD'
      
        '  INNER JOIN TAB_FORNECEDOR FRN ON PRD.COD_FORNECEDOR = FRN.COD_' +
        'FORNECEDOR')
    Left = 456
    Top = 139
    object TblProdutosCOD_PRODUTO: TFDAutoIncField
      FieldName = 'COD_PRODUTO'
      Origin = 'COD_PRODUTO'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
    end
    object TblProdutosCOD_STATUS: TIntegerField
      FieldName = 'COD_STATUS'
      Origin = 'COD_STATUS'
      Required = True
    end
    object TblProdutosDES_DESCRICAO: TStringField
      FieldName = 'DES_DESCRICAO'
      Origin = 'DES_DESCRICAO'
      Size = 50
    end
    object TblProdutosVAL_PRECO_UNITARIO: TFloatField
      FieldName = 'VAL_PRECO_UNITARIO'
      Origin = 'VAL_PRECO_UNITARIO'
      DisplayFormat = '#,##0.00'
    end
    object TblProdutosCOD_FORNECEDOR: TIntegerField
      FieldName = 'COD_FORNECEDOR'
      Origin = 'COD_FORNECEDOR'
      Required = True
    end
    object TblProdutosDES_NOME_FANTASIA: TStringField
      FieldName = 'DES_NOME_FANTASIA'
      Origin = 'DES_NOME_FANTASIA'
      Size = 50
    end
  end
  object QryPesquisarItens: TFDQuery
    Connection = DmConexao.FDConnection
    SQL.Strings = (
      'SELECT *'
      'FROM TAB_VENDA_ITENS')
    Left = 128
    Top = 209
    object QryPesquisarItensCOD_VENDA: TIntegerField
      FieldName = 'COD_VENDA'
      Origin = 'COD_VENDA'
      Required = True
    end
    object QryPesquisarItensCOD_PRODUTO: TIntegerField
      FieldName = 'COD_PRODUTO'
      Origin = 'COD_PRODUTO'
      Required = True
    end
    object QryPesquisarItensDES_DESCRICAO: TStringField
      FieldName = 'DES_DESCRICAO'
      Origin = 'DES_DESCRICAO'
      Size = 50
    end
    object QryPesquisarItensVAL_PRECO_UNITARIO: TFloatField
      FieldName = 'VAL_PRECO_UNITARIO'
      Origin = 'VAL_PRECO_UNITARIO'
      DisplayFormat = '#,##0.00'
    end
    object QryPesquisarItensVAL_QUANTIDADE: TIntegerField
      FieldName = 'VAL_QUANTIDADE'
      Origin = 'VAL_QUANTIDADE'
      Required = True
    end
    object QryPesquisarItensVAL_TOTAL_VENDA: TFloatField
      FieldName = 'VAL_TOTAL_VENDA'
      Origin = 'VAL_TOTAL_VENDA'
      DisplayFormat = '#,##0.00'
    end
  end
end
