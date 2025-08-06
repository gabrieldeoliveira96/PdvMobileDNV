unit view.login;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  heranca.base, FMX.Layouts, FMX.Controls.Presentation, FMX.Objects,
  Alcinoe.FMX.Controls, Alcinoe.FMX.Objects, Alcinoe.FMX.Edit, UI.Base,
  UI.Standard, uConnection, view.principal, uConstants;

type
  TfrmLogin = class(TfrmHerancaBase)
    Label1: TLabel;
    S: TLayout;
    Layout2: TLayout;
    Label2: TLabel;
    Rectangle1: TRectangle;
    Layout3: TLayout;
    Layout4: TLayout;
    edtEmail: TALEdit;
    Layout5: TLayout;
    Label3: TLabel;
    Layout6: TLayout;
    Layout7: TLayout;
    edtSenha: TALEdit;
    Label4: TLabel;
    Layout8: TLayout;
    btnLogin: TButtonView;
    Layout9: TLayout;
    Layout10: TLayout;
    Label5: TLabel;
    procedure btnLoginClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

uses
  System.JSON;

{$R *.fmx}

procedure TfrmLogin.btnLoginClick(Sender: TObject);
var
 LCon:TConnection;
 LJson:TJsonObject;
 LResult:string;
 LBasicAuth:TBasicAuth;
 LToken:string;
begin

  inherited;

  LBasicAuth.Login:= 'crFsSV06nr';
  LBasicAuth.Senha:= 'V%zwEGo<M5A1SQTK[LnIHH<G?z7PdJ';

  TThread.CreateAnonymousThread(
  procedure
  begin

    LCon:= TConnection.Create;
    try

      LJson:= TJSONObject.Create;
      try
        LJson.AddPair('login',edtEmail.Text);
        LJson.AddPair('senha',edtSenha.Text);

        if LCon.Post(URL+'valida/login',[],LJson,LBasicAuth,LResult) then
        begin

          TThread.Synchronize(nil,
          procedure
          begin
            if not Assigned(frmPrincipal) then
              Application.CreateForm(TfrmPrincipal, frmPrincipal);
          end);

          LJson:= TJSONObject.ParseJSONValue(LResult) as TJSONObject;
          frmPrincipal.CarregaTela(
            LJson.GetValue<string>('cod'),
            LJson.GetValue<string>('token'));

          TThread.Synchronize(nil,
          procedure
          begin
            frmPrincipal.Show;
          end);
        end;
      finally
        FreeAndNil(LJson);
      end;

    finally
      FreeAndNil(LCon);
    end;


  end).Start;


end;

procedure TfrmLogin.FormShow(Sender: TObject);
begin
  inherited;
  {$IFDEF MSWINDOWS}
  edtEmail.Text := 'teste@teste.com';
  edtSenha.Text := '1';
  {$ENDIF}
end;

end.
