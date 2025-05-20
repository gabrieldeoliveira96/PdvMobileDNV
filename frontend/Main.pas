unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIRegClasses, uniGUIForm, Vcl.Imaging.jpeg,
  uniGUIBaseClasses, uniImage, uniPanel,
  uLogin.Frame.View;

type
  TMainForm = class(TUniForm)
    UniImage1: TUniImage;
    PnlLogin: TUniPanel;
    procedure UniFormCreate(Sender: TObject);
  private
    FLoginView: TFrLogin;
  public
    { Public declarations }
  end;

function MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  uniGUIVars, MainModule, uniGUIApplication,
  Bootstrap.Converter.Panels.Dinos;

function MainForm: TMainForm;
begin
  Result := TMainForm(UniMainModule.GetFormInstance(TMainForm));
end;

procedure TMainForm.UniFormCreate(Sender: TObject);
begin
  FLoginView := TFrLogin.Create(Self);
  FLoginView.Parent := PnlLogin;
  FLoginView.Left := Round((screen.Width/2) - (FLoginView.Width /2));
  FLoginView.Top := 10;

  FLoginView.Show;
  FLoginView.BringToFront;

  PnlLogin.Align := alClient;
  PnlLogin.ConvertToBootstrap();
  PnlLogin.Transparence();
end;

initialization
  RegisterAppFormClass(TMainForm);

end.
