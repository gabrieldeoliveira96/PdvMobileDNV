object FrLogin: TFrLogin
  Left = 0
  Top = 0
  Width = 291
  Height = 480
  OnCreate = UniFrameCreate
  TabOrder = 0
  object UniPanel1: TUniPanel
    Left = 0
    Top = 0
    Width = 291
    Height = 480
    Hint = ''
    Align = alClient
    TabOrder = 0
    ShowCaption = False
    Caption = ''
    ExplicitLeft = 19
    ExplicitTop = 48
    ExplicitWidth = 256
    ExplicitHeight = 128
    object UniImage1: TUniImage
      Left = 24
      Top = 16
      Width = 241
      Height = 169
      Hint = ''
      Url = 'files/hello-2488_256.gif'
    end
    object UniLabel1: TUniLabel
      Left = 24
      Top = 208
      Width = 51
      Height = 13
      Hint = ''
      Caption = 'Username'
      TabOrder = 2
    end
    object UniLabel2: TUniLabel
      Left = 24
      Top = 290
      Width = 32
      Height = 13
      Hint = ''
      Caption = 'Senha'
      TabOrder = 3
    end
    object EdtUser: TUniEdit
      Left = 24
      Top = 227
      Width = 241
      Height = 46
      Hint = ''
      Text = ''
      TabOrder = 4
    end
    object EdtSenha: TUniEdit
      Left = 24
      Top = 310
      Width = 241
      Height = 46
      Hint = ''
      PasswordChar = '*'
      Text = ''
      TabOrder = 5
    end
    object BtnLogin: TUniButton
      Left = 24
      Top = 376
      Width = 89
      Height = 33
      Hint = ''
      Caption = 'Logar'
      ParentFont = False
      Font.Color = 8244230
      TabOrder = 6
      OnClick = BtnLoginClick
      OnMouseEnter = BtnLoginMouseEnter
      OnMouseLeave = BtnLoginMouseLeave
    end
    object BtnCancelar: TUniButton
      Left = 119
      Top = 376
      Width = 89
      Height = 33
      Hint = ''
      Caption = 'Cancelar'
      ParentFont = False
      Font.Color = clWhite
      TabOrder = 7
    end
  end
end
