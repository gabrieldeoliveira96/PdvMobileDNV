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
 {criamos o primeiro endpoint de usu�rio mas est�vamos com
 problema na conex�o com banco de dados, a dll
 do mysql n�o est� funcionando, corrigir antes da pr�xima live}
  controller.user.Registry;

  THorse.Listen(9000);

end.
