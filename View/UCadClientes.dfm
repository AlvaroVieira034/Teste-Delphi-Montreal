inherited FrmCadClientes: TFrmCadClientes
  Caption = 'Cadastro de Clientes'
  ClientHeight = 277
  ClientWidth = 628
  OnCreate = FormCreate
  OnShow = FormShow
  ExplicitWidth = 644
  ExplicitHeight = 316
  PixelsPerInch = 96
  TextHeight = 13
  inherited PanelBotoes: TPanel
    Left = 490
    Height = 277
    ExplicitLeft = 490
    ExplicitHeight = 277
    inherited BtnGravar: TSpeedButton
      Left = 11
      OnClick = BtnGravarClick
      ExplicitLeft = 11
      ExplicitWidth = 116
    end
    inherited BtnSair: TSpeedButton
      Left = 11
      Top = 231
      OnClick = BtnSairClick
      ExplicitLeft = 11
      ExplicitTop = 232
    end
    inherited BtnCancelar: TSpeedButton
      Left = 11
      Top = 163
      OnClick = BtnCancelarClick
      ExplicitLeft = 11
      ExplicitTop = 163
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
      ExplicitLeft = 11
    end
  end
  inherited PanelDados: TPanel
    Width = 490
    Height = 277
    ExplicitWidth = 490
    ExplicitHeight = 277
    object GroupBox1: TGroupBox
      Left = 7
      Top = 2
      Width = 473
      Height = 269
      Caption = ' Dados do Cliente '
      TabOrder = 0
      object Label1: TLabel
        Left = 59
        Top = 93
        Width = 37
        Height = 13
        Caption = '&C'#243'digo:'
      end
      object Label2: TLabel
        Left = 65
        Top = 171
        Width = 31
        Height = 13
        Caption = 'N&ome:'
      end
      object Label3: TLabel
        Left = 11
        Top = 209
        Width = 85
        Height = 13
        Caption = '&Data Nascimento:'
      end
      object Label6: TLabel
        Left = 67
        Top = 133
        Width = 19
        Height = 13
        Caption = 'C&PF'
      end
      object EdtNomeCliente: TEdit
        Left = 106
        Top = 168
        Width = 331
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 100
        TabOrder = 2
      end
      object EdtCodCliente: TEdit
        Left = 106
        Top = 89
        Width = 76
        Height = 21
        Enabled = False
        TabOrder = 4
      end
      object EdtDataNascimento: TEdit
        Left = 106
        Top = 206
        Width = 82
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 10
        TabOrder = 3
        OnChange = EdtDataNascimentoChange
      end
      object EdtCPF: TEdit
        Left = 106
        Top = 129
        Width = 139
        Height = 21
        MaxLength = 19
        TabOrder = 1
        OnExit = EdtCPFExit
        OnKeyPress = EdtCPFKeyPress
      end
      object RdgAtivo: TRadioGroup
        Left = 15
        Top = 19
        Width = 445
        Height = 40
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
    DataSet = DmTabelas.TblClientes
    Left = 424
    Top = 48
  end
end
