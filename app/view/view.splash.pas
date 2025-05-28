unit view.splash;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, view.login;

type
  TfrmSplash = class(TForm)
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSplash: TfrmSplash;

implementation

{$R *.fmx}

procedure TfrmSplash.FormShow(Sender: TObject);
begin
  TThread.CreateAnonymousThread(
  procedure
  begin

    sleep(3000);
    TThread.Synchronize(nil,
    procedure
    begin
      if not Assigned(frmLogin) then
       Application.CreateForm(TfrmLogin, frmLogin);

      frmLogin.Show;
    end);

  end).Start;

end;

end.
