program PdvNaVeia;

uses
  System.StartUpCopy,
  FMX.Forms,
  heranca.base in 'heranca\heranca.base.pas' {frmHerancaBase},
  view.principal in 'view\view.principal.pas' {frmHerancaBase1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmHerancaBase, frmHerancaBase);
  Application.CreateForm(TfrmHerancaBase1, frmHerancaBase1);
  Application.Run;
end.
