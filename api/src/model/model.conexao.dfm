object dmConexao: TdmConexao
  OnCreate = DataModuleCreate
  Height = 347
  Width = 502
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=delphinaveia'
      'User_Name=root'
      'Password=root'
      'Server=127.0.0.1'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 72
    Top = 48
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 'C:\Desenvolvimento\PdvMobileDNV\api\exe\libmysql.dll'
    Left = 216
    Top = 48
  end
end
