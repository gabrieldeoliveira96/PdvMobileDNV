unit view.venda;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  heranca.base, FMX.Objects, uGosObjects, uGosBase, uGosStandard, FMX.Layouts,
  System.Skia, FMX.Skia, FMX.Effects, FMX.Filter.Effects,
  FMX.Controls.Presentation;

type
  TfrmVenda = class(TfrmHerancaBase)
    GosButtonView1: TGosButtonView;
    Layout1: TLayout;
    Layout2: TLayout;
    SkLabel1: TSkLabel;
    lblProduto: TSkLabel;
    SkLabel3: TSkLabel;
    SkLabel4: TSkLabel;
    SkLabel5: TSkLabel;
    SkLabel6: TSkLabel;
    Layout3: TLayout;
    Layout4: TLayout;
    Layout5: TLayout;
    Layout6: TLayout;
    Layout7: TLayout;
    GosButtonView2: TGosButtonView;
    SkLabel7: TSkLabel;
    SkLabel8: TSkLabel;
    Layout8: TLayout;
    SpeedButton1: TSpeedButton;
    FillRGBEffect1: TFillRGBEffect;
    SkLabel9: TSkLabel;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CarregaTela(AProduto:string);
  end;

var
  frmVenda: TfrmVenda;

implementation

{$R *.fmx}

{ TfrmHerancaBase1 }

procedure TfrmVenda.CarregaTela(AProduto:string);
begin

  TThread.Synchronize(nil,
  procedure
  begin
    lblProduto.Text:= AProduto;

  end);

end;

end.
