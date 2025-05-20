object LoginServices: TLoginServices
  Height = 127
  Width = 356
  object RESTClient1: TRESTClient
    BaseURL = 'http://localhost:9000/login'
    Params = <>
    SynchronizedEvents = False
    Left = 64
    Top = 32
  end
  object RESTRequest1: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient1
    Method = rmPOST
    Params = <
      item
        Kind = pkREQUESTBODY
        Name = 'body32BD523140124120AA8854720A14D292'
        Value = '{'#13#10'  "Username": "admin",'#13#10'  "Senha": "admin"'#13#10'}'
        ContentTypeStr = 'application/json'
      end>
    SynchronizedEvents = False
    Left = 184
    Top = 40
  end
end
