unit uLogin.Services;

interface

uses
  System.SysUtils, System.Classes, REST.Types, REST.Client,
  Data.Bind.Components,
  Data.Bind.ObjectScope,
  uLogin.Model;

type
  TLoginServices = class(TDataModule)
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
  private
    { Private declarations }
  public
    function ValidarLogin(AModel: TLoginModel): Boolean;
  end;

var
  LoginServices: TLoginServices;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

uses
  REST.Json;

{ TDataModule1 }

function TLoginServices.ValidarLogin(AModel: TLoginModel): Boolean;
begin
  RESTRequest1.Params[0].Value := TJson.ObjectToJsonString(AModel);
  RESTRequest1.Execute;

  var
  lModelResult := TJson.JsonToObject<TUserLogado>
    (RESTRequest1.Response.JSONValue.ToString);
  try
    Result := lModelResult.Logado;
  finally
    lModelResult.Free;
  end;
end;

end.
