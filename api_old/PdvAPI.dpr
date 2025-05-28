program PdvAPI;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Horse,
  model.con in 'model\model.con.pas' {DM: TDataModule},
  controller.user in 'controller\controller.user.pas',
  model.user in 'model\model.user.pas' {modelUser: TDataModule};

begin
 {criamos o primeiro endpoint de usuário mas estávamos com
 problema na conexão com banco de dados, a dll
 do mysql não está funcionando, corrigir antes da próxima live}
  controller.user.Registry;

  THorse.Listen(9000);

end.
