program api_pdv;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Horse,
  horse.JWT,
  horse.Jhonson,
  horse.BasicAuthentication,
  model.conexao in 'src\model\model.conexao.pas' {dmConexao: TDataModule},
  model.usuario in 'src\model\model.usuario.pas' {dmUsuario: TDataModule},
  classe.hash.senha in 'src\classe\classe.hash.senha.pas',
  controllers.usuario in 'src\controllers\controllers.usuario.pas',
  controllers.Auth in 'src\controllers\controllers.Auth.pas';

function ValidateBasicAuth(const AUsername, APassword: string): Boolean;
begin
  // Aqui você pode validar as credenciais no banco de dados ou onde preferir
  Result := AUsername.Equals('crFsSV06nr') and APassword.Equals('V%zwEGo<M5A1SQTK[LnIHH<G?z7PdJ');
end;

begin
  {$REGION 'Endpoints JWT'}
    const EndpointsJWT: TArray<string> = [''];
  {$ENDREGION}

  THorse
    .Use(Jhonson())
    .Use(HorseBasicAuthentication(ValidateBasicAuth,
      THorseBasicAuthenticationConfig.New
        .SkipRoutes(EndpointsJWT)
    ));

  controllers.usuario.RegistryRoutes;

  THorse.Listen(9000,
  procedure
  begin
    Writeln(' ' + 'Rodando na porta: 9000');
    Writeln;
  end);
end.
