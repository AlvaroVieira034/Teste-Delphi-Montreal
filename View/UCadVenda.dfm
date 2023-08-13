object FrmCadVenda: TFrmCadVenda
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Cadastro de Vendas'
  ClientHeight = 469
  ClientWidth = 617
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PnlDados: TPanel
    Left = 0
    Top = 0
    Width = 617
    Height = 172
    Align = alTop
    TabOrder = 0
    object GbxDados: TGroupBox
      Left = 3
      Top = 0
      Width = 610
      Height = 168
      Caption = ' Dados do Pedido '
      TabOrder = 0
      object Label1: TLabel
        Left = 17
        Top = 32
        Width = 85
        Height = 13
        Caption = '&C'#243'digo da Venda:'
      end
      object Label3: TLabel
        Left = 14
        Top = 86
        Width = 88
        Height = 13
        Caption = 'C'#243'digo do C&liente:'
      end
      object Label4: TLabel
        Left = 24
        Top = 113
        Width = 78
        Height = 13
        Caption = 'Valor do Pedido:'
      end
      object Label2: TLabel
        Left = 27
        Top = 59
        Width = 75
        Height = 13
        Caption = '&Data da Venda:'
      end
      object EdtCodVenda: TEdit
        Left = 111
        Top = 29
        Width = 74
        Height = 21
        Alignment = taRightJustify
        Enabled = False
        TabOrder = 1
      end
      object EdtCodCliente: TEdit
        Left = 111
        Top = 83
        Width = 74
        Height = 21
        Alignment = taRightJustify
        TabOrder = 3
        OnExit = EdtCodClienteExit
        OnKeyPress = EdtCodClienteKeyPress
      end
      object LCbxCliente: TDBLookupComboBox
        Left = 187
        Top = 83
        Width = 314
        Height = 21
        KeyField = 'COD_CLIENTE'
        ListField = 'DES_NOME'
        ListSource = DmTabelas.DsClientes
        TabOrder = 4
        OnClick = LCbxClienteClick
      end
      object EdtTotalVenda: TEdit
        Left = 111
        Top = 110
        Width = 74
        Height = 21
        Alignment = taRightJustify
        Enabled = False
        TabOrder = 5
      end
      object RdgStatus: TRadioGroup
        Left = 191
        Top = 26
        Width = 310
        Height = 51
        Caption = ' Status '
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          'Efetivada'
          'Pendente')
        TabOrder = 0
      end
      object BtnInserirItens: TButton
        Left = 254
        Top = 126
        Width = 115
        Height = 30
        Caption = '&Inserir Itens'
        ImageIndex = 14
        ImageMargins.Left = 12
        Images = FrmMain.ImageList
        TabOrder = 6
        OnClick = BtnInserirItensClick
      end
      object EdtDataVenda: TEdit
        Left = 111
        Top = 56
        Width = 74
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 10
        TabOrder = 2
        OnChange = EdtDataVendaChange
      end
    end
  end
  object PnlItens: TPanel
    Left = 0
    Top = 172
    Width = 617
    Height = 297
    Align = alClient
    TabOrder = 1
    object BtnGravar: TSpeedButton
      Left = 51
      Top = 256
      Width = 105
      Height = 30
      Caption = '&Gravar'
      Enabled = False
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9CCDB93C9C75188A5C78
        BBA0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFA0CFBC1E926652D5BC57E0C92BA27B95C9B4FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA3D1BF2093684BD0B538CAAA35C8A74C
        D2B81E9165CFE6DDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA5D1BF
        24946A4BD0B53ACBAB31C5A231C5A23CCDAE47C5A873B79CFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFABD4C426956B4DD1B63ACBAB38CAA942CDAE41C9AB3A
        CCAC44D3B638AD8A8CC5AEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF26916658D8C0
        3FCFB037C9A94CD4B92E9D752C9A714DD2B83CCDAE4CD6BB2B9970BADCCEFFFF
        FFFFFFFFFFFFFFFFFFFFAED6C63EB19050DAC150D7BE319F7997CAB69FCEBB2F
        9C754ED5BA41D0B34ECEB362AF91FAFCFBFFFFFFFFFFFFFFFFFFFFFFFF85C1A9
        3FB08F36A17C97CAB5FFFFFFFFFFFF99CBB7349F7A4ED6BC48D6BA45B99A8AC3
        ADFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBBDCCFDDEDE7FFFFFFFFFFFFFFFFFFFF
        FFFF99CAB73AA38050D7BF51DAC139A27FAFD5C6FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF98CAB63DA68355DCC455D5
        BD349871E7F3EEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFF95C8B441AA885BE0CB50C4A993C7B3FFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF94C8B445AD
        8D62E6D245AD8DAED5C6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF96C8B549B1925FDDC85FAC8EFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFB0D6C74AB192B0D6C7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCCE4DBFFFFFF}
      OnClick = BtnGravarClick
    end
    object BtnCancelar: TSpeedButton
      Left = 249
      Top = 256
      Width = 105
      Height = 30
      Caption = 'Ca&ncelar'
      Enabled = False
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFE3E3F28181C433339F11118F11118F30309D7B7BC1DDDDEFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7E7FC31215961120AA1128B911
        2CC0112CC01129BA1120AB1216977B7CC2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        7274BF111DA41430C11431C31431C31431C31431C31431C31431C31430C1121E
        A67274BFFFFFFFFFFFFFFFFFFF7E7FC61420A71736C61736C61736C61736C617
        36C61736C61736C61736C61736C61736C61421A97879C4FFFFFFE6E6F4171CA0
        1A3AC81A3CCA5F77DAFFFFFF5F77DA1A3CCA1A3CCA5F77DAFFFFFF5F77DA1A3C
        CA1A3BC9161C9FD8D8EE8385CC2235B81E43CE1E43CEFFFFFFFFFFFFFFFFFF62
        7CDD627CDDFFFFFFFFFFFFFFFFFF1E43CE1E43CE2136BB7577C63C40B22242C9
        2249D22249D24448B7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4448B72249
        D22249D22243CC3135AD1A1FA72950D42751D62751D62751D64448B7FFFFFFFF
        FFFFFFFFFFFFFFFF4448B72751D62751D62751D62952D5151AA5141AA83E66DD
        2B58DB2B58DB2B58DB6B8AE6FFFFFFFFFFFFFFFFFFFFFFFF6B8AE62B58DB2B58
        DB2B58DB3B64DD141AA83B41BA5270DC2F5EDF2F5EDF6E8FE9FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFF6E8FE92F5EDF2F5EDF5473DD363CB88286D55264D0
        3A6AE43365E3FFFFFFFFFFFFFFFFFF4448B74448B7FFFFFFFFFFFFFFFFFF3365
        E33869E45062D08286D5E5E6F71721B57495EB386CE74448B7FFFFFF4448B736
        6BE7366BE74448B7FFFFFF4448B7366BE77396EC1C27B7E5E6F7FFFFFF8286D8
        3948C77FA2F13F74EB151AA53970EA3970EA3970EA3970EA151AA53E73EA7CA0
        F13E4DCA7C81D6FFFFFFFFFFFFFFFFFF7379D43545C78FACF1709AF25B8BF047
        7DEE477DEE5A8AF06E98F28FADF23C4DCA7077D3FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFF7E84D91623BC5165D57088E38EA9EF8FABF0728AE35569D71825BC7B81
        D8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEEEFFA8D92DE5961CF29
        32C12630C0565ECE878CDCEBECF9FFFFFFFFFFFFFFFFFFFFFFFF}
      OnClick = BtnCancelarClick
    end
    object BtnSair: TSpeedButton
      Left = 445
      Top = 256
      Width = 105
      Height = 30
      Caption = '&Sair'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFEDEDEDCDCDCDCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
        CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCA0B2C04B7DA368A4D95C5C5C5D5B5C
        5E5B5B5E5A5A5D5A5A5B5A5B5A5B5B5A5B5B5A5B5B5B5A5A5C59565768764E7E
        A44C80AC5082AB65A2D5FFFFFFFFFFFFFFFFFF3A6BA16B69666F68696C6A696C
        6A696C6A696C6A686E67624C89BA4E85B24D83AE5D8CB2629ED1FFFFFFFFFFFF
        CCCCCC009147068A4E6E606469636467646367646367646268615B4F8ABB5086
        B44F84B16895B95F9BCDFFFFFFCCCCCC00894552DCB0008E477257606B5B6067
        5E6064606062605F645D57518DBE528AB75187B4739FC25D97C9CCCCCC008744
        65D7B400DAA2008641008B44008F461C7D50645A5C605C5A6058525490C2558C
        BA4E81AD7EA6C85A94C4008A4874DABD00CD9C00CC9C00D29E00D5A05FF0D000
        91466353585D57565B534D5794C5588EBC47749B88AFCF5790C0008A4886DEC8
        00C59C00C49B63DCC85FDECA5EE4CF0092475E4F55585353574F4A5A96CA5B8F
        BE22B9F795B5D3548DBCFFFFFF0087439BE0D100C1A000863F008D4400924717
        7A4C584E5154504F524B455B9ACD5C91C120B7F59EBCD75189B8FFFFFFFFFFFF
        008843A2E6DA0090475B414B57474D544A4E514C4E4F4D4C4D46415E9CD25C95
        C55990C1A6C4DF4E86B5FFFFFFFFFFFFFFFFFF00904603874A5244494E484A4D
        494A4C4A4A4C48484A423D60A0D55D98C95894C6AFCCE64B83B0FFFFFFFFFFFF
        FFFFFF4C7AAE47423F4A4443484644484644484644474542433C365FA1D85C9A
        CC5896C9B8D3EB4980ACFFFFFFFFFFFFFFFFFF4C7EAF443832433B37433D3843
        3D38433D38423B363C332CB9DAF57FB0DA5495CCC0DAEF467CA8FFFFFFFFFFFF
        FFFFFF83A6C34B81AE4B83B04A83B04A83B04A83B04A82AF447DA9709CBFB9D5
        EBB3D1EAC1DBF24279A5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAF2F9CEE3F53F75A1}
      OnClick = BtnSairClick
    end
    object GbxItens: TGroupBox
      Left = 3
      Top = 0
      Width = 610
      Height = 250
      Caption = ' Itens do Pedido'
      TabOrder = 0
      object Label7: TLabel
        Left = 12
        Top = 17
        Width = 38
        Height = 13
        Caption = 'Produto'
      end
      object Label8: TLabel
        Left = 254
        Top = 17
        Width = 56
        Height = 13
        Caption = 'Quantidade'
      end
      object Label9: TLabel
        Left = 343
        Top = 17
        Width = 67
        Height = 13
        Caption = 'Pre'#231'o Unit'#225'rio'
      end
      object Label10: TLabel
        Left = 461
        Top = 17
        Width = 54
        Height = 13
        Caption = 'Pre'#231'o Total'
      end
      object EdtQuantidade: TEdit
        Left = 252
        Top = 33
        Width = 61
        Height = 21
        Alignment = taRightJustify
        TabOrder = 1
        OnKeyPress = EdtQuantidadeKeyPress
      end
      object EdtPrecoUnit: TEdit
        Left = 325
        Top = 33
        Width = 100
        Height = 21
        Alignment = taRightJustify
        TabOrder = 2
        OnKeyPress = EdtPrecoUnitKeyPress
      end
      object EdtPrecoTotal: TEdit
        Left = 438
        Top = 33
        Width = 100
        Height = 21
        Alignment = taRightJustify
        TabOrder = 3
        OnEnter = EdtPrecoTotalEnter
        OnKeyPress = EdtPrecoTotalKeyPress
      end
      object PnlDbGrid: TPanel
        Left = 11
        Top = 67
        Width = 591
        Height = 172
        BevelOuter = bvNone
        TabOrder = 5
        object DbGridItensPedido: TDBGrid
          Left = 0
          Top = 0
          Width = 591
          Height = 172
          Align = alClient
          DataSource = DsVendaItem
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          OnDblClick = DbGridItensPedidoDblClick
          Columns = <
            item
              Expanded = False
              FieldName = 'DES_DESCRICAO'
              Title.Caption = 'Descri'#231#227'o do Produto'
              Width = 64
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'VAL_QUANTIDADE'
              Title.Alignment = taCenter
              Title.Caption = 'Quantidade'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'VAL_PRECO_UNITARIO'
              Title.Alignment = taCenter
              Title.Caption = 'Pre'#231'o Unit'#225'rio'
              Width = 84
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'VAL_TOTAL_VENDA'
              Title.Alignment = taCenter
              Title.Caption = 'Total Venda'
              Width = 91
              Visible = True
            end>
        end
      end
      object LCbxProdutos: TDBLookupComboBox
        Left = 11
        Top = 33
        Width = 230
        Height = 21
        KeyField = 'COD_PRODUTO'
        ListField = 'DES_DESCRICAO'
        ListFieldIndex = 1
        ListSource = DmTabelas.DsProdutos
        TabOrder = 0
        OnExit = LCbxProdutosExit
      end
      object BtnAddItemGrid: TButton
        Left = 546
        Top = 32
        Width = 24
        Height = 24
        ImageIndex = 0
        Images = FrmMain.ImageList
        TabOrder = 4
        OnClick = BtnAddItemGridClick
      end
      object BtnDelItemGrid: TButton
        Left = 576
        Top = 32
        Width = 24
        Height = 24
        ImageIndex = 1
        Images = FrmMain.ImageList
        TabOrder = 6
        OnClick = BtnDelItemGridClick
      end
    end
  end
  object DsVendaItem: TDataSource
    DataSet = MTblVendaItem
    OnDataChange = DsVendaItemDataChange
    Left = 544
    Top = 320
  end
  object DsVenda: TDataSource
    DataSet = DmTabelas.TblVendas
    Left = 552
    Top = 104
  end
  object MTblVendaItem: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 480
    Top = 320
    object MTblVendaItemID_ITEM: TIntegerField
      FieldName = 'ID_ITEM'
    end
    object MTblVendaItemCOD_VENDA: TIntegerField
      FieldName = 'COD_VENDA'
    end
    object MTblVendaItemCOD_PRODUTO: TIntegerField
      FieldName = 'COD_PRODUTO'
    end
    object MTblVendaItemDES_DESCRICAO: TStringField
      FieldName = 'DES_DESCRICAO'
      Size = 50
    end
    object MTblVendaItemVAL_PRECO_UNITARIO: TFloatField
      FieldName = 'VAL_PRECO_UNITARIO'
      DisplayFormat = '#,##0.00'
    end
    object MTblVendaItemVAL_QUANTIDADE: TIntegerField
      FieldName = 'VAL_QUANTIDADE'
    end
    object MTblVendaItemVAL_TOTAL_VENDA: TFloatField
      FieldName = 'VAL_TOTAL_VENDA'
      DisplayFormat = '#,##0.00'
    end
  end
end
