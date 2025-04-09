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

  controller.user.Registry;

  THorse.Listen(9000);

end.
