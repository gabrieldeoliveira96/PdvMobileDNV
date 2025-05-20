unit controllers.Auth;

interface

uses Horse, Horse.JWT, JOSE.Core.JWT, JOSE.Types.JSON, JOSE.Core.Builder, System.JSON, System.SysUtils, DataSet.Serialize;

const
  SECRET = 'entrega2025!#';
  cTOKEN_EXPIRATION_DAYS = 1;

type
  TMyClaims = class(TJWTClaims)

  strict private
    function GetIdUsuario: integer;
    procedure SetIdUsuario(const Value: integer);

  private

  public
    property ID_USUARIO: integer read GetIdUsuario write SetIdUsuario;
  end;

function CriarToken(AIdUsuario: integer): string;
function GetUsuarioRequest(Req: THorseRequest): integer;
function VerificarOuRenovarToken(AReq: THorseRequest; out NovoToken: string): Boolean;

implementation

function CriarToken(AIdUsuario: integer): string;
var
  LJwt: TJWT;
  LClaims: TMyClaims;
begin
  try
    LJwt := TJWT.Create();
    LClaims := TMyClaims(LJwt.Claims);

    try
      LClaims.ID_USUARIO := AIdUsuario;

      LClaims.Expiration := Now + cTOKEN_EXPIRATION_DAYS; //Duração de 1 dia
      //LClaims.Expiration := IncSecond(Now, 30); //Duração de 30 segundos

      Result := TJOSE.SHA256CompactToken(SECRET, LJwt);
    except
      Result := '';
    end;

  finally
    FreeAndNil(LJwt);
  end;
end;

function VerificarOuRenovarToken(AReq: THorseRequest; out NovoToken: string): Boolean;
var
  LJwt: TJWT;
  LClaims: TMyClaims;
begin
  Result := False;
  NovoToken := '';

  try
    LJwt := TJOSE.Verify(SECRET, AReq.Headers['Authorization']);
    LClaims := TMyClaims(LJwt.Claims);

    // Verifica se o token está expirado
    if LClaims.Expiration < Now then
    begin
      // Token expirado: gera um novo token
      NovoToken := CriarToken(LClaims.ID_USUARIO);
    end
    else
    begin
      // Token ainda válido
      Result := True;
    end;

  except
    // Caso ocorra algum erro na verificação, o token é considerado inválido
    NovoToken := '';
  end;

  FreeAndNil(LJwt);
end;

function GetUsuarioRequest(Req: THorseRequest): integer;
var
  LClaims: TMyClaims;
begin
  LClaims := Req.Session<TMyClaims>;
  Result := LClaims.ID_USUARIO;
end;

procedure TMyClaims.SetIdUsuario(const Value: integer);
begin
  TJSONUtils.SetJSONValueFrom<integer>('cod', Value, FJSON);
end;

function TMyClaims.GetIdUsuario: integer;
begin
  Result := FJSON.GetValue<integer>('cod', 0);
end;

end.
