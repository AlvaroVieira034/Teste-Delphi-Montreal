inherited FrmPesqCliente: TFrmPesqCliente
  Caption = 'Cadastro de Clientes - Pesquisa'
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
          FieldName = 'COD_CLIENTE'
          Title.Alignment = taCenter
          Title.Caption = 'C'#243'digo'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DES_NOME'
          Title.Caption = 'Nome do Cliente'
          Width = 290
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'DES_CPF'
          Title.Alignment = taCenter
          Title.Caption = 'CPF'
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'DTA_NASCIMENTO'
          Title.Alignment = taCenter
          Title.Caption = 'Data Nascimento'
          Width = 98
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
          'CPF')
      end
    end
    inherited PnlContador: TPanel
      inherited LblTotRegistros: TLabel
        Left = 553
        ExplicitLeft = 553
      end
    end
  end
  inherited DsPesquisa: TDataSource
    DataSet = DmTabelas.TblClientes
  end
end
