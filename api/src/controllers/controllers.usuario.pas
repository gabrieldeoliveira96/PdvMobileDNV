unit controllers.usuario;

interface

uses Horse, Horse.jwt, System.Json, System.SysUtils, model.usuario, controllers.Auth;

procedure RegistryRoutes;
procedure CadastraUsuario(Req: THorseRequest; Res: THorseResponse);
procedure ValidaLogin(Req: THorseRequest; Res: THorseResponse);

implementation

procedure RegistryRoutes;
begin
  THorse.Post('/cadastra/usuario', CadastraUsuario);
  THorse.Post('/valida/login', ValidaLogin);
end;

procedure CadastraUsuario(Req: THorseRequest; Res: THorseResponse);
var
  LUsuario: TdmUsuario;
begin
    LUsuario := TdmUsuario.Create(nil);
  try

    try

      Res.Send<TJSONObject>(LUsuario.CadastraUsuario(Req.Body<TJSONObject>)).status(201);

    except on ex:Exception do
      Res.send('Erro na operação: ' + ex.message).Status(500);
    end;

  finally
    FreeAndNil(LUsuario);
  end;

end;

procedure ValidaLogin(Req: THorseRequest; Res: THorseResponse);
var
  LUsuario: TdmUsuario;
  LJson: TJSONObject;
  LToken: string;
begin
    LUsuario := TdmUsuario.Create(nil);
  try

    try
      LJson := LUsuario.ValidaLogin(Req.Body<TJSONObject>);

      if LJson.Count = 0 then
      begin
        Res.Send('Email ou senha inválida').Status(401);
        FreeAndNil(LJson);
      end
      else
      begin
        LToken := CriarToken(LJson.GetValue<integer>('cod'));

        LJson.AddPair('token', LToken);

        Res.Send<TJSONObject>(LJson).status(201);
      end;

    except on ex:Exception do
      Res.send('Erro na operação: ' + ex.message).Status(500);
    end;

  finally
    FreeAndNil(LUsuario);
  end;
end;

end.
