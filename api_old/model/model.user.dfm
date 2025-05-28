inherited modelUser: TmodelUser
  Height = 331
  Width = 591
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
end
