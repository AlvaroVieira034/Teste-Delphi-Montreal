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
    ExplicitWidth = 618
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
      object BtnAdicionaItens: TSpeedButton
        Left = 246
        Top = 130
        Width = 115
        Height = 27
        Caption = '&Adiciona Itens'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000BB8A5EBB8A5E
          BB8A5EBB8A5EBB8A5EBB8A5EBD8E63E7D5C6FBFDFCADD4B26DB07657A3616AAA
          71AACDADFBFDFBFFFFFFBC8B5EFFFFFEFFFCF7FFFEF5FFFEF6FFFBF4FFFAF5F9
          FCFA85C38F62B57266B77559AD6764B4735EAB6B7EB483F9FBF9BE8C5EFFFFFE
          FFFCF7FFFEF5FFFEF6FFFBF4FFFDFBAFDAB764B97569C0796AB474D2E8D568B3
          7465BA775EAB6BA9CDACBF8E5FFFFFFE7B432BFFFFF57B432B7B432BECE4E16F
          BE7F6ABD796EB8789DCFA4FFFFFF9CCDA46BB47766B57464A56BC18F5FFFFDFA
          FFFFFCFFFFFCFFFFFCFFFFFCFFFFFF60BA735EB36BD3EAD6FFFFFFFFFFFFFFFF
          FFD2E8D559AD6754A05DC39160FFFFFC7B432BFFFFF57B432B7B432BECE4E172
          C2826CBD7A6FB9799FD0A5FFFFFF9DCFA46DB67766B77566AA6FC49260FFFFFC
          FFFDF7FFFFF5FFFFFFFFFFFFFFFEFDAFDDB968BF7B6DC47B6CB877D3EAD66CB6
          7668C07962B270AAD0AEC79361FFFEF67B432BFFFFF57B432B7B432BBB9E91F9
          FDFA89CD9767BE796BBD795EB36B6ABB7863B57382BE8BF9FCF9C89561FFFFFB
          FFFFF5FFFFF5FFFFF5FFFFF5FFFFF5FFFFFBFBFEFCB2DEBB75C28561B87273BD
          80AFD8B6FBFDFCFFFFFFCA9662FFFFFC7B432BF7F2E87B432B7B432B7B432BFF
          FFFCB29284DDCFC9EBE2DFEBE2DFFFFEFCEEE1D6FFFFFFFFFFFFCC9862FFFBF8
          FFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFF3EAFFF9
          F3BB8A5EFFFFFFFFFFFFCD9963FFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFFFFFCFF
          FFFCFFFFFCFFFFFCDDDBDADDDBDADDDBDABB8A5EFFFFFFFFFFFFCF9A63FFFBF8
          FFF9F3FFF9F30000A10000A10000A10000A100009EFFFFFFDDDBDADDDBDAF5F7
          F8BB8A5EFFFFFFFFFFFFD09C64FFFBF8FEF5EFFFFFF5FFFFF5FFFFF5FFFFF5FF
          FFF5FFFFF5FFFFF5E9E5D5F9FCFDE7D7CAD4B7A0FFFFFFFFFFFFD29D64FFFFFF
          FFFBF8FFFBF8FFFFFEFFFFFEFFFFFEFFFFFEFFFFFEFFFFFFEEEEEEEDE0D8CBA9
          8EF8F4F1FFFFFFFFFFFFD4A067D19C64CF9A63CC9862CA9662C89461C49260C2
          9060BF8E5FBD8C5EC2976FCEAD93F8F4F1FFFFFFFFFFFFFFFFFF}
        OnClick = BtnAdicionaItensClick
      end
      object BtnLimpaCampos: TSpeedButton
        Left = 191
        Top = 28
        Width = 24
        Height = 24
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000F6F6F6ECECEC
          E5E5E5E6E6E6E7E7E7E9E9E9EBEBEBEDEDEDF0F0F0F2F2F2F5F5F5F8F8F8FAFA
          FAFCFCFCFEFEFEFFFFFFEEEEEED9D9D9BABABA9D9D9D9B9B9B9A9A9A999999BF
          BFBFE1E1E1E6E6E6ECECECF1F1F1F6F6F6FAFAFAFDFDFDFFFFFFFFFFFFD6D6D6
          A6A6A6DFDFDFCECECECECECECECECE9B9B9BD0D0D0FFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFDDDDDDB1B1B1F0F0F0E1E1E1E1E1E1BFBFBFC0C0C0D1
          D1D19F9F9FD2D2D2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBCBCBCF0F0F0
          E3E3E3E3E3E3E3E3E3E3E3E3C2C2C2C4C4C4D4D4D4A3A3A3D4D4D4FFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFC1C1C1F0F0F0E6E6E6E6E6E6E6E6E6E6E6E6E6E6E6C6
          C6C6C8C8C8D8D8D8A9A9A9D6D6D6FFFFFFFFFFFFFFFFFFFFFFFFE4E4E4C3C3C3
          F1F1F1E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9CACACACCCCCCDCDCDCAFAFAFC3BB
          E3FFFFFFFFFFFFFFFFFFFFFFFFE5E5E5C6C6C6F3F3F3ECECECECECECECECECEC
          ECECECECECCECECED0D0D09F8EE37D6BC5C5BDE4FFFFFFFFFFFFFFFFFFFFFFFF
          E6E6E6C8C8C8F4F4F4EFEFEFEFEFEFEFEFEFEFEFEFEFEFEF8E7DD2907FD4A392
          E7806EC7C6BEE5FFFFFFFFFFFFFFFFFFFFFFFFE7E7E7CBCBCBF6F6F6F2F2F2F2
          F2F2F2F2F2AE9DE8B09FE99281D69483D8A695EA8270C9C7BFE7FFFFFFFFFFFF
          FFFFFFFFFFFFE9E9E9CDCDCDF8F8F8F5F5F5AE9DE8B09FE9B2A1E9B3A2EA9584
          D99786DBA998ED8573CBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE9E9E9CFCFCFC1
          B0F9B09FE9B2A1E9B3A2EAB5A4EBB6A5EC9887DCAA99EE8876CEFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFCEC6ED9281D8C4B3FBB3A2EAB5A4EBB6A5ECB8A7
          ECCAB9FE8C7AD2CAC2EAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCE
          C6EE9382D8C6B5FCB6A5ECB8A7ECCAB9FE907FD6CCC4ECFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCFC7EE9584DAC9B8FDCAB9FE9382
          D8CEC6EDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFD0C8EF9685DB9584DBCFC7EEFFFFFFFFFFFFFFFFFF}
      end
      object EdtCodVenda: TEdit
        Left = 111
        Top = 29
        Width = 74
        Height = 21
        Alignment = taRightJustify
        Enabled = False
        TabOrder = 0
      end
      object EdtCodCliente: TEdit
        Left = 111
        Top = 83
        Width = 74
        Height = 21
        Alignment = taRightJustify
        TabOrder = 1
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
        TabOrder = 2
        OnClick = LCbxClienteClick
      end
      object EdtTotalVenda: TEdit
        Left = 111
        Top = 110
        Width = 74
        Height = 21
        Alignment = taRightJustify
        Enabled = False
        TabOrder = 3
      end
      object EdtDataVenda: TEdit
        Left = 111
        Top = 56
        Width = 74
        Height = 21
        Alignment = taCenter
        TabOrder = 4
        OnKeyPress = EdtDataVendaKeyPress
      end
      object RdgStatus: TRadioGroup
        Left = 400
        Top = 21
        Width = 185
        Height = 51
        Caption = ' Status '
        Columns = 2
        Items.Strings = (
          'Efetivada'
          'Pendente')
        TabOrder = 5
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
    ExplicitWidth = 618
    ExplicitHeight = 287
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
      OnClick = BtnCancelarClick
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
      object BtnAddItemGrid: TSpeedButton
        Left = 546
        Top = 31
        Width = 24
        Height = 24
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
        OnClick = BtnAddItemGridClick
      end
      object BtnDelItemGrid: TSpeedButton
        Left = 576
        Top = 31
        Width = 24
        Height = 24
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
          FFFFFFEDEDEDCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCEDEDEDFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEDEDED9499C82C3CC02B3BBE2B3ABE2B
          3ABE2B3ABE2B3BBE2C3CC09499C8EDEDEDFFFFFFFFFFFFFFFFFFFFFFFFEDEDED
          969BC92F3EC35F71F9697DFF697CFF697CFF697CFF697DFF5F71F92F3EC3969B
          C9EDEDEDFFFFFFFFFFFFEDEDED969BC92F3EC2586BF65F74FF5D72FE5E72FD5E
          73FD5E72FD5D72FE5F74FF586BF62F3EC2969BC9EDEDEDFFFFFF9499C8303FC2
          5568F3586CFC4E64F94D63F85468F9576BF95468F94D63F84E64F9586CFC5568
          F3303FC29499C8FFFFFF2D3DC05367F2556BFA4960F7FFFFFFFFFFFF3E56F647
          5EF63E56F6FFFFFFFFFFFF4960F7556BFA5166F22D3DC0FFFFFF2B3BBF6276FC
          4D64F64259F4FFFFFFFFFFFFFFFFFF2C46F3FFFFFFFFFFFFFFFFFF4259F44E64
          F65F75FC2C3BBFFFFFFF2A3ABF7386FA495FF3435AF36E80F6FFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF6E80F6435AF3495FF36E81FA2B3ABFFFFFFF2939BF8696FB
          425AF14259F1354EF05B70F2FFFFFFFFFFFFFFFFFF5B70F2354EF04259F1435B
          F17D90F92A39BFFFFFFF2737BF9AA8FB3A55EF3953EE2844EDFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF2844ED3953EE3B55EF8E9DFA2838BFFFFFFF2637BF9FABF1
          314CED2B47EBFFFFFFFFFFFFFFFFFF5369EFFFFFFFFFFFFFFFFFFF2C47EB314C
          ED9FABF12737BFFFFFFF2838C19FABF18091F4213EE8FFFFFFFFFFFF5D72EE23
          40E85D72EEFFFFFFFFFFFF213EE88091F49FABF12838C1FFFFFFB4BAE92E3EC3
          97A5EF778AF25B71EE6074EE2643E62C48E72643E66074EE5B71EE778AF297A5
          EF2E3EC3B4BAE9FFFFFFFFFFFFB6BCEA2E3EC295A2EE7688F01E3BE42340E525
          41E52340E51E3BE47688F095A2EE2E3EC2B6BCEAFFFFFFFFFFFFFFFFFFFFFFFF
          B6BCEA2F3DC394A0EFADB9F8ADB8F7ADB9F7ADB8F7ADB9F894A0EF2F3DC3B6BC
          EAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB4B9E9303FC44555CE4454CD43
          54CD4454CD4555CE303FC4B4B9E9FFFFFFFFFFFFFFFFFFFFFFFF}
        OnClick = BtnDelItemGridClick
      end
      object EdtQuantidade: TEdit
        Left = 252
        Top = 33
        Width = 61
        Height = 21
        Alignment = taRightJustify
        TabOrder = 1
      end
      object EdtPrecoUnit: TEdit
        Left = 325
        Top = 33
        Width = 100
        Height = 21
        Alignment = taRightJustify
        TabOrder = 2
      end
      object EdtPrecoTotal: TEdit
        Left = 438
        Top = 33
        Width = 100
        Height = 21
        Alignment = taRightJustify
        TabOrder = 3
      end
      object PnlDbGrid: TPanel
        Left = 11
        Top = 67
        Width = 591
        Height = 172
        BevelOuter = bvNone
        TabOrder = 4
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
          Columns = <
            item
              Expanded = False
              FieldName = 'DES_DESCRICAO'
              Title.Caption = 'Descri'#231#227'o do Produto'
              Width = 309
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'VAL_QUANTIDADE'
              Title.Alignment = taCenter
              Title.Caption = 'Quantidade'
              Width = 65
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'VAL_PRECO_UNITARIO'
              Title.Alignment = taCenter
              Title.Caption = 'Pre'#231'o Unit'#225'rio'
              Width = 90
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'VAL_TOTAL_VENDA'
              Title.Alignment = taCenter
              Title.Caption = 'Pre'#231'o Total'
              Width = 76
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
      end
    end
  end
  object DsVendaItem: TDataSource
    DataSet = CdsVendaItem
    Left = 544
    Top = 320
  end
  object DsVenda: TDataSource
    DataSet = DmTabelas.TblVendas
    Left = 552
    Top = 104
  end
  object CdsVendaItem: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 464
    Top = 320
    object CdsVendaItemID_ITEM: TIntegerField
      FieldName = 'ID_ITEM'
    end
    object CdsVendaItemCOD_VENDA: TIntegerField
      FieldName = 'COD_VENDA'
    end
    object CdsVendaItemCOD_PRODUTO: TIntegerField
      FieldName = 'COD_PRODUTO'
    end
    object CdsVendaItemDES_DESCRICAO: TStringField
      FieldName = 'DES_DESCRICAO'
      Size = 50
    end
    object CdsVendaItemVAL_PRECO_UNITARIO: TFloatField
      FieldName = 'VAL_PRECO_UNITARIO'
    end
    object CdsVendaItemVAL_QUANTIDADE: TIntegerField
      FieldName = 'VAL_QUANTIDADE'
    end
    object CdsVendaItemVAL_TOTAL_VENDA: TFloatField
      FieldName = 'VAL_TOTAL_VENDA'
    end
  end
end
