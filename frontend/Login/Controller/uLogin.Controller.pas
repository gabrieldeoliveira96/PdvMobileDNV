unit uLogin.Controller;

interface

uses
  SysUtils,
  uLogin.Model,
  uLogin.Services;

type
  TLoginController = class
    private

    public
    class function Validarlogin(AModel: TLoginModel):Boolean;
  end;

implementation

{ TLoginController }
uses
  js.SweetAlert.Dinos;

class function TLoginController.Validarlogin(AModel: TLoginModel): Boolean;
begin
  var
    lServices := TLoginServices.Create(nil);
  try
    try
      Result := lServices.ValidarLogin(Amodel);
    Except
      on E:Exception do
        TSweetAlert.jsSweetFireError('Erro no sistema', E.Message);
    end;
  finally
    lServices.Free;
  end;
end;

end.
