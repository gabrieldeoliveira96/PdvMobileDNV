unit uLogin.Frame.View;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIFrame, uniButton, uniEdit, uniLabel, uniImage,
  uniGUIBaseClasses, uniPanel;

type
  TFrLogin = class(TUniFrame)
    UniPanel1: TUniPanel;
    UniImage1: TUniImage;
    UniLabel1: TUniLabel;
    UniLabel2: TUniLabel;
    EdtUser: TUniEdit;
    EdtSenha: TUniEdit;
    BtnLogin: TUniButton;
    BtnCancelar: TUniButton;
    procedure UniFrameCreate(Sender: TObject);
    procedure BtnLoginMouseLeave(Sender: TObject);
    procedure BtnLoginMouseEnter(Sender: TObject);
    procedure BtnLoginClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  uLogin.Controller,
  uLogin.Model,
  Bootstrap.Converter.Map.Dinos,
  Bootstrap.Converter.Buttons.Dinos,
  js.SweetAlert.Dinos;

procedure TFrLogin.BtnLoginClick(Sender: TObject);
begin
  var lModel := TLoginModel.Create;
  try
    lModel.Username := EdtUser.Text;
    lModel.Senha := EdtSenha.Text;

    if TLoginController.Validarlogin(lModel) then
      TSweetAlert.jsSweetFireSuccess('Login', 'Realizado com sucesso!')
    else
      TSweetAlert.jsSweetFireWarning('Login', 'Usario ou senha, invalido!');
  finally
    lModel.Free;
  end;
end;

procedure TFrLogin.BtnLoginMouseEnter(Sender: TObject);
begin
  TUniButton(Sender).Font.Color := clWhite;
end;

procedure TFrLogin.BtnLoginMouseLeave(Sender: TObject);
begin
  TUniButton(Sender).Font.Color := $007DCC06;
end;

procedure TFrLogin.UniFrameCreate(Sender: TObject);
begin
  TMap.MapComponenet(self);
  BtnLogin.ConvertToBootstrap(TpButtom.tpSuccessOutline);
  BtnCancelar.ConvertToBootstrap(TpButtom.tpDanger);
end;

end.
