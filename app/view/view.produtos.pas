unit view.produtos;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  heranca.base, FMX.Effects, FMX.Filter.Effects, FMX.Controls.Presentation,
  FMX.Layouts, frame.produtos;

type
  TfrmProdutos = class(TfrmHerancaBase)
    Layout1: TLayout;
    SpeedButton1: TSpeedButton;
    FillRGBEffect1: TFillRGBEffect;
    VertScrollBox1: TVertScrollBox;
    frameProduto1: TframeProduto;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FCallBack:TProc;
    {$IFDEF MSWINDOWS}
    procedure CadastrarVenda(Sender:TObject);
    {$ELSE}
    procedure CadastrarVenda(Sender:TObject; const Point: TPointF);
    {$ENDIF}

  public
    { Public declarations }
    procedure CarregaTela(ACallBack:TProc);
  end;

var
  frmProdutos: TfrmProdutos;

implementation

{$R *.fmx}

uses view.venda;

{ TfrmProdutos }

procedure TfrmProdutos.CarregaTela(ACallBack:TProc);
begin
  FCallBack:= ACallBack;
  for var i := 0 to 10 do
  begin
    var LFrame:= TframeProduto.Create(self);

    LFrame.Name:= 'FRame'+i.ToString;
    LFrame.Align:= TAlignLayout.Top;

    //LFrame.Tag:= 1; //ID

    LFrame.lblProduto.Text:= 'Produto '+i.ToString;
    LFrame.lblDescricao.Text:= 'Descrição do Produto '+i.ToString;

    LFrame.Margins.Left:= 24;
    LFrame.Margins.Right:= 24;
    LFrame.Margins.Top:= 16;

    LFrame.TagString:= LFrame.lblProduto.Text;

    {$IFDEF MSWINDOWS}
    LFrame.OnClick:= CadastrarVenda;
    {$ELSE}
    LFrame.OnTap:= CadastrarVenda;
    {$ENDIF}

    VertScrollBox1.AddObject(LFrame);
                                          
  end;
end;


procedure TfrmProdutos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action:= TCloseAction.caFree;
  frmProdutos:= nil;
end;

{$IFDEF MSWINDOWS}
procedure TfrmProdutos.CadastrarVenda(Sender:TObject);
{$ELSE}
procedure TfrmProdutos.CadastrarVenda(Sender:TObject; const Point: TPointF);
{$ENDIF}

var
 LProduto:string;
begin

  LProduto:= TframeProduto(Sender).TagString;


  //Loading

  TThread.CreateAnonymousThread(
  procedure
  begin

    TThread.Synchronize(nil,
    procedure
    begin
      if not Assigned(frmVenda) then
        Application.CreateForm(TfrmVenda,frmVenda);
    end);

    frmVenda.CarregaTela(LProduto, FCallBack);

    TThread.Synchronize(nil,
    procedure
    begin
      frmVenda.Show;

      self.Close;

    end);


  end).Start;



//
end;

end.
