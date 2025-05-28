object DM: TDM
  Height = 213
  Width = 513
  object DB: TFDConnection
    Params.Strings = (
      'Database=delphinaveia'
      'User_Name=root'
      'Password=root'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 160
    Top = 72
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 'C:\Desenvolvimento\api-app-projeto\api\exe\libmysql.dll'
    Left = 256
    Top = 72
  end
end
