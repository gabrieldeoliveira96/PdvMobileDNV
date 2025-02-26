unit view.cliente;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  heranca.base, frame.produtos, FMX.Layouts, FMX.Effects, FMX.Filter.Effects,
  FMX.Controls.Presentation, UI.Base, UI.Edit;

type
  TfrmCliente = class(TfrmHerancaBase)
    Layout1: TLayout;
    SpeedButton1: TSpeedButton;
    FillRGBEffect1: TFillRGBEffect;
    VertScrollBox1: TVertScrollBox;
    frameProduto1: TframeProduto;
    Layout2: TLayout;
    EditView1: TEditView;
    SpeedButton2: TSpeedButton;
    FillRGBEffect2: TFillRGBEffect;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
    FCallBack: TProc;
  public
    { Public declarations }
    procedure CarregaTela(ACallBack:TProc);

  end;

var
  frmCliente: TfrmCliente;

implementation

{$R *.fmx}

uses view.addcliente;

procedure TfrmCliente.CarregaTela(ACallBack:TProc);
begin
  FCallBack:= ACallBack;

  //buscar cliente da api

  for var i := 0 to 10 do
  begin
    var LFrame:= TframeProduto.Create(self);

    LFrame.Name:= 'FRame'+i.ToString;
    LFrame.Align:= TAlignLayout.Top;

    //LFrame.Tag:= 1; //ID

    LFrame.lblProduto.Text:= 'Cliente  '+i.ToString;
    LFrame.lblDescricao.Text:= 'Data de Criação do cliente '+i.ToString;

    LFrame.Margins.Left:= 24;
    LFrame.Margins.Right:= 24;
    LFrame.Margins.Top:= 16;

    LFrame.TagString:= LFrame.lblProduto.Text;

    {$IFDEF MSWINDOWS}
//    LFrame.OnClick:= CadastrarVenda;
    {$ELSE}
    LFrame.OnTap:= CadastrarVenda;
    {$ENDIF}

    VertScrollBox1.AddObject(LFrame);

  end;
end;

procedure TfrmCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action:= TCloseAction.caFree;
  frmCliente:= nil;

end;

procedure TfrmCliente.SpeedButton1Click(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TfrmCliente.SpeedButton2Click(Sender: TObject);
begin
  inherited;

  if not Assigned(frmaddcliente) then
    Application.CreateForm(Tfrmaddcliente,frmaddcliente);

  frmaddcliente.CarregaTela(FCallBack);
  frmaddcliente.Show;


end;

end.
