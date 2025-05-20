inherited modelUser: TmodelUser
  Height = 331
  Width = 591
  inherited FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorHome = ''
    VendorLib = 
      'D:\Fontes\DelphiFullStack2.0\PdvMobileDNV\api\Win32\Debug\libmar' +
      'iadb.dll'
    Left = 384
    Top = 64
  end
  object qUser: TFDQuery
    Connection = DB
    SQL.Strings = (
      'select * from &macro')
    Left = 280
    Top = 152
    MacroData = <
      item
        Value = Null
        Name = 'MACRO'
        DataType = mdIdentifier
      end>
    object qUserid: TIntegerField
      FieldName = 'id'
    end
    object qUsernome: TStringField
      FieldName = 'nome'
      Size = 255
    end
    object qUseremail: TStringField
      FieldName = 'email'
      Size = 255
    end
    object qUsersenha: TStringField
      FieldName = 'senha'
      Size = 50
    end
  end
  object QryLogin: TFDQuery
    Connection = DB
    SQL.Strings = (
      'select '
      '  cod as ID,'
      '  Login as Username,'
      '  senha'
      ' from user as tab_login')
    Left = 280
    Top = 224
  end
end
