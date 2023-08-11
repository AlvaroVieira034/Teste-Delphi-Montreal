inherited FrmPesqProduto: TFrmPesqProduto
  Caption = 'Cadastro de Produtos - Pesquisa'
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  inherited PnlBotoesPesquisa: TPanel
    inherited BtnAlterar: TSpeedButton
      OnClick = BtnAlterarClick
    end
    inherited BtnExcluir: TSpeedButton
      OnClick = BtnExcluirClick
    end
    inherited BtnSair: TSpeedButton
      OnClick = BtnSairClick
    end
    inherited BtnFiltrar: TSpeedButton
      OnClick = BtnFiltrarClick
    end
    inherited BtnTodos: TSpeedButton
      OnClick = BtnTodosClick
    end
    inherited BtnNovo: TSpeedButton
      OnClick = BtnNovoClick
    end
  end
  inherited PanelGrid: TPanel
    inherited DbGridPesquisa: TDBGrid
      DataSource = DsPesquisa
      OnDrawColumnCell = DbGridPesquisaDrawColumnCell
      OnDblClick = DbGridPesquisaDblClick
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'COD_STATUS'
          Title.Alignment = taCenter
          Title.Caption = 'Ativo'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'COD_PRODUTO'
          Title.Alignment = taCenter
          Title.Caption = 'C'#243'digo'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DES_DESCRICAO'
          Title.Caption = 'Descri'#231#227'o'
          Width = 326
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VAL_PRECO_UNITARIO'
          Title.Alignment = taCenter
          Title.Caption = 'Pre'#231'o Unit'#225'rio'
          Width = 77
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'COD_FORNECEDOR'
          Title.Alignment = taCenter
          Title.Caption = 'Fornecedor'
          Width = 67
          Visible = True
        end>
    end
    inherited PnlPesquisar: TPanel
      inherited BtnPesquisar: TSpeedButton
        OnClick = BtnPesquisarClick
      end
      inherited CbxFiltro: TComboBox
        Text = 'C'#243'digo'
        Items.Strings = (
          'Codigo'
          'Descri'#231#227'o'
          'Fornecedor')
      end
    end
    inherited PnlContador: TPanel
      inherited LblTotRegistros: TLabel
        Left = 543
        ExplicitLeft = 543
      end
    end
  end
  inherited DsPesquisa: TDataSource
    DataSet = DmTabelas.TblProdutos
  end
end
