object DmConexao: TDmConexao
  OldCreateOrder = False
  Height = 208
  Width = 316
  object FDConnection: TFDConnection
    Params.Strings = (
      'Database=TesteDelphi'
      'User_Name=sa'
      'Password=info'
      'Server=PC-ALVARO\SQLEXPRESS'
      'DriverID=MSSQL')
    LoginPrompt = False
    Left = 48
    Top = 32
  end
  object FDPhysMSSQLDriverLink: TFDPhysMSSQLDriverLink
    Left = 160
    Top = 32
  end
  object FDTransaction: TFDTransaction
    Connection = FDConnection
    Left = 160
    Top = 104
  end
end
