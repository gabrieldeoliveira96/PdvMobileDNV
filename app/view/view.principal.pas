unit view.principal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  heranca.base, FMX.Layouts, System.Skia, UI.Base, UI.Standard, FMX.Skia,
  FMX.Objects, Alcinoe.FMX.Objects, FMX.ListBox, FMX.Effects,
  FMX.Filter.Effects, uGosObjects, heranca.botao, view.produtos;

type
  TfrmPrincipal = class(TfrmHerancaBotao)
    Layout1: TLayout;
    SkLabel1: TSkLabel;
    ButtonView1: TButtonView;
    Layout2: TLayout;
    SkLabel2: TSkLabel;
    SkLabel3: TSkLabel;
    GosCircle1: TGosCircle;
    FillRGBEffect1: TFillRGBEffect;
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    ListBoxItem4: TListBoxItem;
    ALRectangle1: TALRectangle;
    ALRectangle2: TALRectangle;
    ALRectangle3: TALRectangle;
    ALRectangle4: TALRectangle;
    Layout3: TLayout;
    Layout4: TLayout;
    SkLabel4: TSkLabel;
    SkLabel5: TSkLabel;
    GosCircle2: TGosCircle;
    FillRGBEffect2: TFillRGBEffect;
    procedure lytbtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

procedure TfrmPrincipal.lytbtn3Click(Sender: TObject);
begin
  inherited;

  //Loading

  TThread.CreateAnonymousThread(
  procedure
  begin

    TThread.Synchronize(nil,
    procedure
    begin
      if not Assigned(frmProdutos) then
        Application.CreateForm(TfrmProdutos,frmProdutos);
    end);

    frmProdutos.CarregaTela;

    TThread.Synchronize(nil,
    procedure
    begin
      frmProdutos.Show;
    end);


  end).Start;

end;

end.
