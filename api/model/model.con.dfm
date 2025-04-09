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
    VendorHome = 'C:\Desenvolvimento\PdvMobileDNV\api'
    VendorLib = 'libmysql.dll'
    Left = 344
    Top = 80
  end
end
