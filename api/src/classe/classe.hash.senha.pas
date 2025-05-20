unit classe.hash.senha;

interface

uses
  System.SysUtils, System.Classes, System.Hash, FireDAC.Comp.Client,
  FireDAC.Stan.Param, System.JSON, DataSet.Serialize;

type
  TUsuario = class
  private
    function GerarSalt: string;
    function GerarHash(const ASenha, ASalt: string): string;
  public
    procedure Criptografia(const ASenha: string; out AHash, ASalt: string);
    function ValidarLogin(const AUsuario, ASenha: string; AConn: TFDConnection): TJsonObject;
  end;

implementation

uses model.usuario;

function TUsuario.GerarSalt: string;
var
  Guid: TGUID;
begin
  CreateGUID(Guid);
  Result := GUIDToString(Guid);
end;

function TUsuario.GerarHash(const ASenha, ASalt: string): string;
begin
  Result := THashSHA2.GetHashString(ASenha + ASalt, THashSHA2.TSHA2Version.SHA256);
end;

procedure TUsuario.Criptografia(const ASenha: string; out AHash, ASalt: string);
begin
  ASalt := GerarSalt;
  AHash := GerarHash(ASenha, ASalt);
end;

function TUsuario.ValidarLogin(const AUsuario, ASenha: string; AConn: TFDConnection): TJsonObject;
var
  LQry: TFDQuery;
  LHashArmazenado, LSalt: string;
  LValida: boolean;
begin
  Result := nil;

  LQry := TFDQuery.Create(nil);

  Result:= TJSONObject.Create;
  try
    LQry.Connection := AConn;
    LQry.SQL.Text := 'SELECT * FROM user WHERE EMAIL = :EMAIL';
    LQry.ParamByName('EMAIL').AsString := AUsuario;
    LQry.Open;

    if not LQry.IsEmpty then
    begin
      LHashArmazenado := LQry.FieldByName('SENHA').AsString;
      LSalt := LQry.FieldByName('SALT').AsString;

      LValida := LHashArmazenado = GerarHash(ASenha, LSalt);
      if LValida then
      begin
        Result := LQry.ToJSONObject;

        Result.RemovePair('senha');
        Result.RemovePair('salt');
      end
      else
      begin
        LQry.Close;
        Result := LQry.ToJSONObject;
      end;
    end
    else
      Result := LQry.ToJSONObject;

  finally
    LQry.Free;
  end;
end;

end.
