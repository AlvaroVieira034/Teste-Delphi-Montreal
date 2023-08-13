inherited FrmCadFornecedores: TFrmCadFornecedores
  Caption = 'Cadastro de Fornecedores'
  ClientHeight = 276
  ClientWidth = 621
  OnCreate = FormCreate
  OnShow = FormShow
  ExplicitWidth = 637
  ExplicitHeight = 315
  PixelsPerInch = 96
  TextHeight = 13
  inherited PanelBotoes: TPanel
    Left = 483
    Height = 276
    ExplicitLeft = 483
    ExplicitHeight = 276
    inherited BtnGravar: TSpeedButton
      Left = 11
      Top = 119
      OnClick = BtnGravarClick
      ExplicitLeft = 11
      ExplicitTop = 119
      ExplicitWidth = 116
    end
    inherited BtnSair: TSpeedButton
      Left = 11
      Top = 233
      OnClick = BtnSairClick
      ExplicitLeft = 11
      ExplicitTop = 233
    end
    inherited BtnCancelar: TSpeedButton
      Left = 11
      Top = 157
      OnClick = BtnCancelarClick
      ExplicitLeft = 11
      ExplicitTop = 157
    end
    inherited BtnNovo: TSpeedButton
      Left = 11
      ExplicitLeft = 11
    end
    inherited BtnAlterar: TSpeedButton
      Left = 11
      ExplicitLeft = 11
    end
    inherited BtnExcluir: TSpeedButton
      Left = 11
      Top = 81
      ExplicitLeft = 11
      ExplicitTop = 81
    end
  end
  inherited PanelDados: TPanel
    Width = 483
    Height = 276
    ExplicitWidth = 483
    ExplicitHeight = 276
    object GroupBox1: TGroupBox
      Left = 7
      Top = 2
      Width = 467
      Height = 268
      Caption = ' Dados do Fornecedor '
      TabOrder = 0
      object Label1: TLabel
        Left = 59
        Top = 93
        Width = 37
        Height = 13
        Caption = '&C'#243'digo:'
      end
      object Label2: TLabel
        Left = 36
        Top = 171
        Width = 64
        Height = 13
        Caption = '&Raz'#227'o Social:'
      end
      object Label3: TLabel
        Left = 25
        Top = 209
        Width = 75
        Height = 13
        Caption = '&Nome Fantasia:'
      end
      object Label6: TLabel
        Left = 67
        Top = 133
        Width = 29
        Height = 13
        Caption = 'C&NPJ:'
      end
      object EdtRazaoSocial: TEdit
        Left = 106
        Top = 168
        Width = 331
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 100
        TabOrder = 2
      end
      object EdtCodFornecedor: TEdit
        Left = 106
        Top = 89
        Width = 76
        Height = 21
        Enabled = False
        TabOrder = 4
      end
      object EdtNomeFantasia: TEdit
        Left = 106
        Top = 206
        Width = 331
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 10
        TabOrder = 3
      end
      object EdtCNPJ: TEdit
        Left = 106
        Top = 129
        Width = 139
        Height = 21
        MaxLength = 19
        TabOrder = 1
        OnExit = EdtCNPJExit
        OnKeyPress = EdtCNPJKeyPress
      end
      object RdgAtivo: TRadioGroup
        Left = 17
        Top = 19
        Width = 433
        Height = 43
        Caption = ' Status '
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          'Ativo'
          'Inativo')
        TabOrder = 0
      end
    end
  end
  inherited DsPadrao: TDataSource
    DataSet = DmTabelas.TblFornecedores
    Left = 424
    Top = 24
  end
end
