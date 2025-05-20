{$define UNIGUI_VCL} // Comment out this line to turn this project into an ISAPI module

{$ifndef UNIGUI_VCL}
library
{$else}
program
{$endif}
  PDV_WEB;

uses
  uniGUIISAPI,
  Forms,
  ServerModule in 'ServerModule.pas' {UniServerModule: TUniGUIServerModule},
  MainModule in 'MainModule.pas' {UniMainModule: TUniGUIMainModule},
  Main in 'Main.pas' {MainForm: TUniForm},
  uLogin.Frame.View in 'Login\View\uLogin.Frame.View.pas' {FrLogin: TUniFrame},
  Bootstrap.Converter.Buttons.Dinos in '..\..\..\componenetes\DinosStyle\ConversorBootstrap\Bootstrap.Converter.Buttons.Dinos.pas',
  Bootstrap.Converter.Checkbox.Dinos in '..\..\..\componenetes\DinosStyle\ConversorBootstrap\Bootstrap.Converter.Checkbox.Dinos.pas',
  Bootstrap.Converter.Edits.Dinos in '..\..\..\componenetes\DinosStyle\ConversorBootstrap\Bootstrap.Converter.Edits.Dinos.pas',
  Bootstrap.Converter.Grids.Dinos in '..\..\..\componenetes\DinosStyle\ConversorBootstrap\Bootstrap.Converter.Grids.Dinos.pas',
  Bootstrap.Converter.Images.Dinos in '..\..\..\componenetes\DinosStyle\ConversorBootstrap\Bootstrap.Converter.Images.Dinos.pas',
  Bootstrap.Converter.Labels.Dinos in '..\..\..\componenetes\DinosStyle\ConversorBootstrap\Bootstrap.Converter.Labels.Dinos.pas',
  Bootstrap.Converter.Map.Dinos in '..\..\..\componenetes\DinosStyle\ConversorBootstrap\Bootstrap.Converter.Map.Dinos.pas',
  Bootstrap.Converter.Memos.Dinos in '..\..\..\componenetes\DinosStyle\ConversorBootstrap\Bootstrap.Converter.Memos.Dinos.pas',
  Bootstrap.Converter.Panels.Dinos in '..\..\..\componenetes\DinosStyle\ConversorBootstrap\Bootstrap.Converter.Panels.Dinos.pas',
  Bridge.Dinos in '..\..\..\componenetes\DinosStyle\ConversorBootstrap\Bridge.Dinos.pas',
  js.SweetAlert.Dinos in '..\..\..\componenetes\DinosStyle\ConversorBootstrap\js.SweetAlert.Dinos.pas',
  uConst.Buttons in '..\..\..\componenetes\DinosStyle\ConversorBootstrap\uConst.Buttons.pas',
  uConst.Form.Controls in '..\..\..\componenetes\DinosStyle\ConversorBootstrap\uConst.Form.Controls.pas',
  uConst.Grids in '..\..\..\componenetes\DinosStyle\ConversorBootstrap\uConst.Grids.pas',
  uLogin.Model in 'Login\Model\uLogin.Model.pas',
  uLogin.Services in 'Login\Services\uLogin.Services.pas' {LoginServices: TDataModule},
  uLogin.Controller in 'Login\Controller\uLogin.Controller.pas';

{$R *.res}

{$ifndef UNIGUI_VCL}
exports
  GetExtensionVersion,
  HttpExtensionProc,
  TerminateExtension;
{$endif}

begin
{$ifdef UNIGUI_VCL}
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  TUniServerModule.Create(Application);
  Application.CreateForm(TLoginServices, LoginServices);
  Application.Run;
{$endif}
end.
