inherited FrmCadProduto: TFrmCadProduto
  Caption = 'Cadastro de Produtos'
  ClientHeight = 254
  ClientWidth = 610
  OnCreate = FormCreate
  OnShow = FormShow
  ExplicitWidth = 626
  ExplicitHeight = 293
  PixelsPerInch = 96
  TextHeight = 13
  inherited PanelBotoes: TPanel
    Left = 472
    Height = 254
    ExplicitLeft = 472
    ExplicitHeight = 254
    inherited BtnGravar: TSpeedButton
      Top = 118
      OnClick = BtnGravarClick
      ExplicitTop = 118
      ExplicitWidth = 116
    end
    inherited BtnSair: TSpeedButton
      Top = 208
      OnClick = BtnSairClick
      ExplicitTop = 208
    end
    inherited BtnCancelar: TSpeedButton
      Top = 156
      OnClick = BtnCancelarClick
      ExplicitTop = 156
    end
    inherited BtnAlterar: TSpeedButton
      Top = 42
      ExplicitTop = 42
    end
    inherited BtnExcluir: TSpeedButton
      Top = 80
      ExplicitTop = 80
    end
  end
  inherited PanelDados: TPanel
    Width = 472
    Height = 254
    ExplicitWidth = 472
    ExplicitHeight = 254
    object GroupBox1: TGroupBox
      Left = 7
      Top = 3
      Width = 457
      Height = 245
      Caption = ' Dados do Produto '
      TabOrder = 0
      object Label1: TLabel
        Left = 56
        Top = 85
        Width = 37
        Height = 13
        Caption = '&C'#243'digo:'
      end
      object Label2: TLabel
        Left = 22
        Top = 163
        Width = 71
        Height = 13
        Caption = '&Pre'#231'o Unit'#225'rio:'
      end
      object Label3: TLabel
        Left = 38
        Top = 201
        Width = 55
        Height = 13
        Caption = '&Fornecedor'
      end
      object Label6: TLabel
        Left = 43
        Top = 124
        Width = 50
        Height = 13
        Caption = '&Descri'#231#227'o:'
      end
      object EdtPrecoUnitario: TEdit
        Left = 103
        Top = 160
        Width = 76
        Height = 21
        Alignment = taRightJustify
        CharCase = ecUpperCase
        MaxLength = 12
        TabOrder = 2
        Text = '0.00'
        OnChange = EdtPrecoUnitarioChange
        OnExit = EdtPrecoUnitarioExit
      end
      object EdtCodProduto: TEdit
        Left = 103
        Top = 81
        Width = 76
        Height = 21
        Enabled = False
        TabOrder = 5
      end
      object EdtCodFornecedor: TEdit
        Left = 103
        Top = 198
        Width = 47
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 10
        TabOrder = 3
        OnExit = EdtCodFornecedorExit
        OnKeyPress = EdtCodFornecedorKeyPress
      end
      object EdtDescricao: TEdit
        Left = 103
        Top = 121
        Width = 331
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 19
        TabOrder = 1
      end
      object RdgAtivo: TRadioGroup
        Left = 23
        Top = 18
        Width = 411
        Height = 43
        Caption = ' Status '
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          'Ativo'
          'Inativo')
        TabOrder = 0
      end
      object LCbxFornecedor: TDBLookupComboBox
        Left = 151
        Top = 198
        Width = 284
        Height = 21
        KeyField = 'COD_FORNECEDOR'
        ListField = 'DES_RAZAO_SOCIAL'
        ListSource = DmTabelas.DsFornecedores
        TabOrder = 4
        OnClick = LCbxFornecedorClick
        OnExit = LCbxFornecedorClick
      end
    end
  end
  inherited DsPadrao: TDataSource
    DataSet = DmTabelas.TblProdutos
    Left = 392
    Top = 77
  end
end
