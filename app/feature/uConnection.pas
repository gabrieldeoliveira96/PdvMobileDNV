unit uConnection;

interface

uses System.SysUtils, System.Classes, REST.Types, REST.Client, System.JSON, System.Generics.Collections,
     REST.Authenticator.Basic, REST.Authenticator.OAuth;

type
  TParameter = record
    Value: string;
    key: string;
    Token: string;
  end;

  TBody = record
    Value: string;
    key: string;
  end;

  TBasicAuth = record
    Login: string;
    Senha: string;
  end;

  TConnection = class
    private
     FRESTClient: TRESTClient;
     FRESTRequest: TRESTRequest;
     FRESTResponse: TRESTResponse;
     FHttpBasicAuthenticator:  THTTPBasicAuthenticator;
     FOAuth2Authenticator: TOAuth2Authenticator;
    public
     constructor Create;
     destructor Destroy;
     function Post(AUrl:string; AParameter: array of string; ABody:TJSONObject; ABasicAuth:TBasicAuth; out AResult:string): Boolean; overload;
     function Post(AUrl:string; AParameter: array of string; ABody:TJSONObject; out AResult:string): Boolean; overload;
     function Post(AUrl:string; AParameter: TParameter; ABody:TJSONObject; out AResult:string): Boolean; overload;
     function Post(AUrl:string; AParameter: array of string; ABody:TJSONArray; out AResult:string): Boolean; overload;
     function Post(AUrl:string; AParameter: TList<TParameter>; ABody:TList<TBody>; out AResult:string): Boolean; overload;
     function Get(AUrl:string; AParameter: array of string; out AResult:string): Boolean; overload;
     function Get(AUrl:string; AParameter: TList<TParameter>; out AResult:string): Boolean; overload;
     function Get(AUrl:string; AParameter: TParameter; out AResult:string): Boolean; overload;
     function Get(AUrl:string; AParameter: array of string; ABody: TJSONArray; out AResult:string): Boolean; overload;
     function Get(AUrl:string; AParameter: array of string; ABody:TJSONObject; out AResult:string): Boolean; overload;
     function Put(AUrl:string; AParameter: array of string; ABody:TJSONObject; out AResult:string): Boolean;
     function Delete(AUrl:string; AParameter: array of string; ABody:TJSONObject; out AResult:string): Boolean; overload;
     function Delete(AUrl:string; AParameter: array of string; out AResult:string): Boolean; overload;
  end;

implementation

function TConnection.Post(AUrl:string; AParameter: array of string; ABody:TJSONObject; ABasicAuth:TBasicAuth; out AResult:string): Boolean;
var
 LUrl:string;
 i : Integer;
begin

  FRESTRequest.Client:= FRESTClient;
  FRESTRequest.Response:= FRESTResponse;
  try
    LUrl:= AUrl;
    for  i := 0 to pred(length(AParameter)) do
      LUrl := LUrl + '/' + AParameter[i];

    FHttpBasicAuthenticator.Username := ABasicAuth.Login;
    FHttpBasicAuthenticator.Password := ABasicAuth.Senha;

    FRESTClient.Authenticator := FHttpBasicAuthenticator;

    FRESTRequest.ClearBody;
    FRESTRequest.AddBody(ABody);

    FRESTClient.BaseURL := LUrl;
    FRESTRequest.Method := rmPOST;
    FRESTRequest.Timeout := 60000;
    FRESTRequest.Execute;

    AResult:= FRESTResponse.Content;
    Result:= (FRESTResponse.StatusCode = 200) or (FRESTResponse.StatusCode = 201);

  except
    on e: exception do
    begin
      Result := false;
    end;

  end;
end;

constructor TConnection.Create;
begin
  FRESTClient:= TRESTClient.Create(nil);
  FRESTRequest:= TRESTRequest.Create(nil);
  FRESTResponse:= TRESTResponse.Create(nil);
  FHttpBasicAuthenticator:= THTTPBasicAuthenticator.Create(nil);
  FOAuth2Authenticator:= TOAuth2Authenticator.Create(nil);
end;

function TConnection.Delete(AUrl: string; AParameter: array of string;
  ABody: TJSONObject; out AResult: string): Boolean;
var
 LUrl:string;
 I : Integer;
begin

  FRESTRequest.Client:= FRESTClient;
  FRESTRequest.Response:= FRESTResponse;
  try
    LUrl:= AUrl;
    for i := 0 to pred(length(AParameter)) do
      LUrl := LUrl + '/' + AParameter[i];

    FRESTRequest.ClearBody;
    FRESTRequest.AddBody(ABody);

//    FHttpBasicAuthenticator.Username := FUser;
//    FHttpBasicAuthenticator.Password := FPass;

    FRESTClient.Authenticator := FHttpBasicAuthenticator;

    FRESTClient.BaseURL := LUrl;
    FRESTRequest.Method := rmDELETE;
    FRESTRequest.Execute;

    AResult:= FRESTResponse.Content;
    Result:= FRESTResponse.StatusCode = 200;

  except
    on e: exception do
    begin
      Result := false;
    end;

  end;
end;

destructor TConnection.Destroy;
begin
  FreeAndNil(FRESTClient);
  FreeAndNil(FRESTRequest);
  FreeAndNil(FRESTResponse);
  FreeAndNil(FHttpBasicAuthenticator);
  FreeAndNil(FOAuth2Authenticator);
end;

function TConnection.Get(AUrl: string; AParameter: TParameter;
  out AResult: string): Boolean;
var
 LUrl:string;
 i : Integer;
begin

  FRESTRequest.Client:= FRESTClient;
  FRESTRequest.Response:= FRESTResponse;
  try
    LUrl:= AUrl;

    FRESTRequest.ContentType.ctAPPLICATION_JSON;

    FOAuth2Authenticator.TokenType:= TOAuth2TokenType.ttBEARER;
    FOAuth2Authenticator.AccessToken:= AParameter.Token;

    FRESTClient.Authenticator := FOAuth2Authenticator;

    FRESTClient.BaseURL := LUrl;
    FRESTRequest.Method := rmGET;
    FRESTRequest.Execute;

    AResult:= FRESTResponse.Content;
    Result:= FRESTResponse.StatusCode = 200;

  except
    on e: exception do
    begin
      Result := false;
    end;

  end;
end;

function TConnection.Get(AUrl: string; AParameter: TList<TParameter>;
  out AResult: string): Boolean;
var
 LUrl:string;
 i : Integer;
begin

  FRESTRequest.Client:= FRESTClient;
  FRESTRequest.Response:= FRESTResponse;
  try
    LUrl:= AUrl;

    FRESTRequest.ContentType.ctAPPLICATION_JSON;
    for var Lparam in AParameter do
      FRESTRequest.Params.AddItem(Lparam.key, Lparam.Value, pkHTTPHEADER, [poDoNotEncode]);

//    FHttpBasicAuthenticator.Username := FUser;
//    FHttpBasicAuthenticator.Password := FPass;

    FRESTClient.Authenticator := FHttpBasicAuthenticator;

    FRESTClient.BaseURL := LUrl;
    FRESTRequest.Method := rmGET;
    FRESTRequest.Execute;

    AResult:= FRESTResponse.Content;
    Result:= FRESTResponse.StatusCode = 200;

  except
    on e: exception do
    begin
      Result := false;
    end;

  end;
end;

function TConnection.Get(AUrl:string; AParameter: array of string; out AResult:string): Boolean;
var
 LUrl:string;
 i : integer;
begin


  FRESTRequest.Client:= FRESTClient;
  FRESTRequest.Response:= FRESTResponse;
  try
    LUrl:= AUrl;
    for i := 0 to pred(length(AParameter)) do
      LUrl := LUrl + '/' + AParameter[i];

//    FHttpBasicAuthenticator.Username := FUser;
//    FHttpBasicAuthenticator.Password := FPass;

    FRESTClient.Authenticator := FHttpBasicAuthenticator;

    FRESTClient.BaseURL := LUrl;
    FRESTRequest.Method := rmGET;
    FRESTRequest.Execute;

    AResult:= FRESTResponse.Content;
    Result:= FRESTResponse.StatusCode = 200;

  except
    on e: exception do
    begin
      Result := false;
    end;

  end;

end;

function TConnection.Get(AUrl:string; AParameter: array of string; ABody: TJSONArray;
 out AResult:string): Boolean;
var
 LUrl:string;
 i : integer;
begin
  FRESTRequest.Client:= FRESTClient;
  FRESTRequest.Response:= FRESTResponse;
  try
    LUrl:= AUrl;
    for i := 0 to pred(length(AParameter)) do
      LUrl := LUrl + '/' + AParameter[i];

    FRESTRequest.ClearBody;
    FRESTRequest.AddBody(ABody.ToString,TRESTContentType.ctAPPLICATION_JSON);

//    FHttpBasicAuthenticator.Username := FUser;
//    FHttpBasicAuthenticator.Password := FPass;

    FRESTClient.Authenticator := FHttpBasicAuthenticator;

    FRESTClient.BaseURL := LUrl;
    FRESTRequest.Method := rmGET;
    FRESTRequest.Execute;

    AResult:= FRESTResponse.Content;
    Result:= FRESTResponse.StatusCode = 200;

  except
    on e: exception do
    begin
      Result := false;
    end;

  end;

end;

function TConnection.Get(AUrl:string; AParameter: array of string; ABody: TJSONObject;
 out AResult:string): Boolean;
var
 LUrl:string;
 i : integer;
begin
  FRESTRequest.Client:= FRESTClient;
  FRESTRequest.Response:= FRESTResponse;
  try
    LUrl:= AUrl;
    for i := 0 to pred(length(AParameter)) do
      LUrl := LUrl + '/' + AParameter[i];

    FRESTRequest.ClearBody;
    FRESTRequest.AddBody(ABody.ToString,TRESTContentType.ctAPPLICATION_JSON);

//    FHttpBasicAuthenticator.Username := FUser;
//    FHttpBasicAuthenticator.Password := FPass;

    FRESTClient.Authenticator := FHttpBasicAuthenticator;

    FRESTClient.BaseURL := LUrl;
    FRESTRequest.Method := rmGET;
    FRESTRequest.Execute;

    AResult:= FRESTResponse.Content;
    Result:= FRESTResponse.StatusCode = 200;

  except
    on e: exception do
    begin
      Result := false;
    end;

  end;

end;

function TConnection.Post(AUrl: string; AParameter: array of string;
  ABody: TJSONArray; out AResult: string): Boolean;
var
 LUrl:string;
 i : Integer;
begin

  FRESTRequest.Client:= FRESTClient;
  FRESTRequest.Response:= FRESTResponse;
  try
    LUrl:= AUrl;
    for i := 0 to pred(length(AParameter)) do
      LUrl := LUrl + '/' + AParameter[i];

    FRESTRequest.ClearBody;
    FRESTRequest.AddBody(ABody.ToString,TRESTContentType.ctAPPLICATION_JSON);

//    FHttpBasicAuthenticator.Username := FUser;
//    FHttpBasicAuthenticator.Password := FPass;

    FRESTClient.Authenticator := FHttpBasicAuthenticator;

    FRESTClient.BaseURL := LUrl;
    FRESTRequest.Method := rmPOST;
    FRESTRequest.Timeout := 60000;
    FRESTRequest.Execute;

    AResult:= FRESTResponse.Content;
    Result:= FRESTResponse.StatusCode = 200;

  except
    on e: exception do
    begin
      Result := false;
    end;

  end;
end;

function TConnection.Post(AUrl: string; AParameter: TList<TParameter>;
  ABody: TList<TBody>; out AResult: string): Boolean;
var
 LUrl:string;
 i : Integer;
begin

  FRESTRequest.Client:= FRESTClient;
  FRESTRequest.Response:= FRESTResponse;
  try
    LUrl:= AUrl;

    FRESTRequest.ContentType.ctAPPLICATION_X_WWW_FORM_URLENCODED;
    for var LBody in ABody do
      FRESTRequest.Params.AddItem(LBody.key, LBody.Value, pkGETorPOST, [poDoNotEncode]);

    for var Lparam in AParameter do
      FRESTRequest.Params.AddItem(Lparam.key, Lparam.Value, pkHTTPHEADER, [poDoNotEncode]);

//    FHttpBasicAuthenticator.Username := FUser;
//    FHttpBasicAuthenticator.Password := FPass;

    FRESTClient.Authenticator := FHttpBasicAuthenticator;

    FRESTClient.BaseURL := LUrl;
    FRESTRequest.Method := rmPOST;
    FRESTRequest.Execute;

    AResult:= FRESTResponse.Content;
    Result:= FRESTResponse.StatusCode = 200;

  except
    on e: exception do
    begin
      Result := false;
    end;

  end;
end;

function TConnection.Post(AUrl: string; AParameter: TParameter;
  ABody: TJSONObject; out AResult: string): Boolean;
var
 LUrl:string;
 i : Integer;
begin

  FRESTRequest.Client:= FRESTClient;
  FRESTRequest.Response:= FRESTResponse;
  try
    LUrl:= AUrl;

    FRESTRequest.ContentType.ctAPPLICATION_JSON;

    FOAuth2Authenticator.TokenType:= TOAuth2TokenType.ttBEARER;
    FOAuth2Authenticator.AccessToken:= AParameter.Token;

    FRESTClient.Authenticator := FOAuth2Authenticator;

    FRESTRequest.ClearBody;
    FRESTRequest.AddBody(ABody);

    FRESTClient.BaseURL := LUrl;
    FRESTRequest.Method := rmPOST;
    FRESTRequest.Timeout := 60000;
    FRESTRequest.Execute;

    AResult:= FRESTResponse.Content;
    Result:= (FRESTResponse.StatusCode = 200) or (FRESTResponse.StatusCode = 201);

  except
    on e: exception do
    begin
      Result := false;
    end;

  end;







end;

function TConnection.Post(AUrl: string; AParameter: array of string;
  ABody: TJSONObject; out AResult: string): Boolean;

var
 LUrl:string;
 i : Integer;
begin

  FRESTRequest.Client:= FRESTClient;
  FRESTRequest.Response:= FRESTResponse;
  try
    LUrl:= AUrl;
    for  i := 0 to pred(length(AParameter)) do
      LUrl := LUrl + '/' + AParameter[i];

    FRESTRequest.ClearBody;
    FRESTRequest.AddBody(ABody);

    FRESTClient.BaseURL := LUrl;
    FRESTRequest.Method := rmPOST;
    FRESTRequest.Timeout := 60000;
    FRESTRequest.Execute;

    AResult:= FRESTResponse.Content;
    Result:= (FRESTResponse.StatusCode = 200) or (FRESTResponse.StatusCode = 201);

  except
    on e: exception do
    begin
      Result := false;
    end;

  end;

end;

function TConnection.Put(AUrl: string; AParameter: array of string;
  ABody: TJSONObject; out AResult: string): Boolean;
var
 LUrl:string;
 i : Integer;
begin

  FRESTRequest.Client:= FRESTClient;
  FRESTRequest.Response:= FRESTResponse;
  try
    LUrl:= AUrl;
    for  i := 0 to pred(length(AParameter)) do
      LUrl := LUrl + '/' + AParameter[i];

//    FHttpBasicAuthenticator.Username := FUser;
//    FHttpBasicAuthenticator.Password := FPass;

    FRESTClient.Authenticator := FHttpBasicAuthenticator;

    FRESTRequest.ClearBody;
    FRESTRequest.AddBody(ABody);

    FRESTClient.BaseURL := LUrl;
    FRESTRequest.Method := rmPUT;
    FRESTRequest.Execute;

    AResult:= FRESTResponse.Content;
    Result:= FRESTResponse.StatusCode = 200;

  except
    on e: exception do
    begin
      Result := false;
    end;

  end;
end;

function TConnection.Delete(AUrl: string; AParameter: array of string;
  out AResult: string): Boolean;
var
 LUrl:string;
 i:Integer;
begin

  FRESTRequest.Client:= FRESTClient;
  FRESTRequest.Response:= FRESTResponse;
  try
    LUrl:= AUrl;
    for  i := 0 to pred(length(AParameter)) do
      LUrl := LUrl + '/' + AParameter[i];

    FRESTRequest.ClearBody;

//    FHttpBasicAuthenticator.Username := FUser;
//    FHttpBasicAuthenticator.Password := FPass;

    FRESTClient.Authenticator := FHttpBasicAuthenticator;

    FRESTClient.BaseURL := LUrl;
    FRESTRequest.Method := rmDELETE;
    FRESTRequest.Execute;

    AResult:= FRESTResponse.Content;
    Result:= FRESTResponse.StatusCode = 200;

  except
    on e: exception do
    begin
      Result := false;
    end;

  end;
end;

end.
