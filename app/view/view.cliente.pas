unit view.cliente;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  heranca.base, frame.clientes, FMX.Layouts, FMX.Effects, FMX.Filter.Effects,
  FMX.Controls.Presentation, UI.Base, UI.Edit, uConnection, uConstants,
  view.principal, System.JSON, uFancyDialog, System.Skia, FMX.Skia, FMX.Objects,
  UI.Standard, frame.produtos, uLoading;

type
  TfrmCliente = class(TfrmHerancaBase)
    Layout1: TLayout;
    SpeedButton1: TSpeedButton;
    FillRGBEffect1: TFillRGBEffect;
    VertScrollBox1: TVertScrollBox;
    Layout2: TLayout;
    EditView1: TEditView;
    SkLabel1: TSkLabel;
    SkLabel2: TSkLabel;
    Circle1: TCircle;
    SkLabel3: TSkLabel;
    btnLogin: TButtonView;
    SkLabel4: TSkLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Circle1Click(Sender: TObject);
  private
    { Private declarations }
    FMsg:TFancyDialog;
  public
    { Public declarations }
    procedure CarregaTela;

  end;

var
  frmCliente: TfrmCliente;

implementation

{$R *.fmx}

uses view.addcliente;

procedure TfrmCliente.CarregaTela;
var
 LCon:TConnection;
 LParam: TParameter;
 LResult:string;
 LJsonArray:TJSONArray;
begin

  LCon:= TConnection.Create;
  try
    LParam.Token:= frmPrincipal.FToken;

    if not LCon.Get(URL+'lista/cliente',LParam,LResult) then
    begin
      TThread.Synchronize(nil,
      procedure
      begin
        FMsg.Show(TIconDialog.Error,'erro na requisição','');
        exit;
      end);
    end;

    LJsonArray:= TJSONObject.ParseJSONValue(LResult) as TJSONArray;

  finally
    FreeAndNil(LCon);
  end;

  for var LJson in LJsonArray do
  begin
    var LFrame:= TFrameClientes.Create(self);  //alterar para frame de cliente

    LFrame.Name:= 'FRame'+LJson.GetValue<string>('cod');
    LFrame.Align:= TAlignLayout.Top;
    LFrame.Tag:= LJson.GetValue<integer>('cod');

    LFrame.lblCliente.Text:= LJson.GetValue<string>('nome');
    LFrame.lblEndereco.Text:= LJson.GetValue<string>('complemento');

    LFrame.Margins.Left:= 24;
    LFrame.Margins.Right:= 24;
    LFrame.Margins.Top:= 16;

    LFrame.TagString:= LFrame.lblCliente.Text;

    VertScrollBox1.AddObject(LFrame);

  end;
end;

procedure TfrmCliente.Circle1Click(Sender: TObject);
begin
  inherited;

  TLoading.Show(self,'Aguarde, carregando produtos');
  TThread.CreateAnonymousThread(
  procedure
  begin

    try

      TThread.Synchronize(nil,
      procedure
      begin
        if not Assigned(frmaddcliente) then
          Application.CreateForm(Tfrmaddcliente,frmaddcliente);
      end);

      frmaddcliente.CarregaTela;

      TThread.Synchronize(nil,
      procedure
      begin
        frmaddcliente.Show;
      end);

    finally

      TThread.Synchronize(nil,
      procedure
      begin
        TLoading.Hide;

      end);


    end;
  end).Start;


end;

procedure TfrmCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  FreeAndNil(FMsg);
  Action:= TCloseAction.caFree;
  frmCliente:= nil;

end;

procedure TfrmCliente.FormShow(Sender: TObject);
begin
  inherited;
  FMsg:= TFancyDialog.Create(self);
end;

procedure TfrmCliente.SpeedButton1Click(Sender: TObject);
begin
  inherited;
  close;
end;

end.
