inherited dmUsuario: TdmUsuario
  inherited FDConnection1: TFDConnection
    Connected = True
  end
  object qryCadastraUsuario: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from user')
    Left = 72
    Top = 128
    object qryCadastraUsuarioCOD: TFDAutoIncField
      FieldName = 'COD'
      Origin = 'COD'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = False
    end
    object qryCadastraUsuarioNOME: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NOME'
      Origin = 'NOME'
      Size = 255
    end
    object qryCadastraUsuarioLOGIN: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'LOGIN'
      Origin = 'LOGIN'
      Size = 255
    end
    object qryCadastraUsuarioSENHA: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'SENHA'
      Origin = 'SENHA'
      Size = 255
    end
    object qryCadastraUsuarioSALT: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'SALT'
      Origin = 'SALT'
      Size = 255
    end
    object qryCadastraUsuarioDT_CADASTRO: TDateField
      AutoGenerateValue = arDefault
      FieldName = 'DT_CADASTRO'
      Origin = 'DT_CADASTRO'
    end
    object qryCadastraUsuarioEMAIL: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'EMAIL'
      Origin = 'EMAIL'
      Size = 50
    end
    object qryCadastraUsuarioCELULAR: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'CELULAR'
      Origin = 'CELULAR'
      Size = 255
    end
    object qryCadastraUsuarioCEP: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'CEP'
      Origin = 'CEP'
      Size = 255
    end
    object qryCadastraUsuarioENDERECO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'ENDERECO'
      Origin = 'ENDERECO'
      Size = 255
    end
    object qryCadastraUsuarioNUMERO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NUMERO'
      Origin = 'NUMERO'
      Size = 255
    end
    object qryCadastraUsuarioCOMPLEMENTO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'COMPLEMENTO'
      Origin = 'COMPLEMENTO'
      Size = 255
    end
    object qryCadastraUsuarioCIDADE: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'CIDADE'
      Origin = 'CIDADE'
      Size = 255
    end
    object qryCadastraUsuarioUF: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'UF'
      Origin = 'UF'
      Size = 255
    end
    object qryCadastraUsuarioBAIRRO: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'BAIRRO'
      Origin = 'BAIRRO'
      Size = 255
    end
  end
  object qryAux: TFDQuery
    Connection = FDConnection1
    Left = 72
    Top = 208
  end
end
