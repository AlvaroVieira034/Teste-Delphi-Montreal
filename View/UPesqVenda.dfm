inherited FrmPesqVenda: TFrmPesqVenda
  Caption = 'Cadastro de Vendas - Pesquisa'
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
          Title.Caption = 'Efetivada'
          Width = 57
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'COD_VENDA'
          Title.Alignment = taCenter
          Title.Caption = 'C'#243'digo'
          Width = 49
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DES_NOME'
          Title.Caption = 'Cliente'
          Width = 286
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'DTA_VENDA'
          Title.Alignment = taCenter
          Title.Caption = 'Data Venda'
          Width = 84
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VAL_TOT_VENDA'
          Title.Alignment = taCenter
          Title.Caption = 'Valor Total'
          Width = 87
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VDA_STATUS'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'COD_CLIENTE'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'COD_PRODUTO'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'DES_DESCRICAO'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'VAL_PRECO_UNITARIO'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'VAL_QUANTIDADE'
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'VAL_TOT_ITEM'
          Visible = False
        end>
    end
    inherited PnlPesquisar: TPanel
      inherited BtnPesquisar: TSpeedButton
        OnClick = BtnPesquisarClick
      end
      inherited CbxFiltro: TComboBox
        Text = 'Cliente'
        Items.Strings = (
          'Cliente')
      end
    end
  end
  inherited DsPesquisa: TDataSource
    DataSet = DmTabelas.TblVendas
  end
end
