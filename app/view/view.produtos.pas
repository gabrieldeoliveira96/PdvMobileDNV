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
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CarregaTela;
  end;

var
  frmProdutos: TfrmProdutos;

implementation

{$R *.fmx}

{ TfrmProdutos }

procedure TfrmProdutos.CarregaTela;
begin
  for var i := 0 to 10 do
  begin
    var LFrame:= TframeProduto.Create(self);

    LFrame.Name:= 'FRame'+i.ToString;
    LFrame.Align:= TAlignLayout.Top;

    LFrame.lblProduto.Text:= 'Produto '+i.ToString;
    LFrame.lblDescricao.Text:= 'Descrição do Produto '+i.ToString;

    LFrame.Margins.Left:= 24;
    LFrame.Margins.Right:= 24;
    LFrame.Margins.Top:= 16;

    VertScrollBox1.AddObject(LFrame);
                                          
  end;
end;

end.
