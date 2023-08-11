inherited FrmPesqFornecedor: TFrmPesqFornecedor
  Caption = 'Cadastro de Fornecedores - Pesquisa'
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
          Width = 39
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'COD_FORNECEDOR'
          Title.Alignment = taCenter
          Title.Caption = 'C'#243'digo'
          Width = 44
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DES_RAZAO_SOCIAL'
          Title.Caption = 'Raz'#227'o Social'
          Width = 243
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DES_NOME_FANTASIA'
          Title.Caption = 'Nome Fantasia'
          Width = 202
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'DES_CNPJ'
          Title.Alignment = taCenter
          Title.Caption = 'CNPJ'
          Visible = True
        end>
    end
    inherited PnlPesquisar: TPanel
      inherited BtnPesquisar: TSpeedButton
        OnClick = BtnPesquisarClick
      end
      inherited CbxFiltro: TComboBox
        Items.Strings = (
          'Nome'
          'CNPJ')
      end
    end
    inherited PnlContador: TPanel
      inherited LblTotRegistros: TLabel
        Left = 514
        ExplicitLeft = 514
      end
    end
  end
  inherited DsPesquisa: TDataSource
    DataSet = DmTabelas.TblFornecedores
  end
end
