unit view.principal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  heranca.base, FMX.Layouts, System.Skia, UI.Base, UI.Standard, FMX.Skia,
  FMX.Objects, Alcinoe.FMX.Objects, FMX.ListBox, FMX.Effects,
  FMX.Filter.Effects, uGosObjects, heranca.botao, view.produtos,
  System.Generics.Collections, frame.vendas;

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
    lblQtdVendas: TSkLabel;
    SkLabel5: TSkLabel;
    GosCircle2: TGosCircle;
    FillRGBEffect2: TFillRGBEffect;
    SkLabel6: TSkLabel;
    Layout5: TLayout;
    VertScrollBox1: TVertScrollBox;
    procedure lytbtn3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FListaVendas:TObjectList<TFrameVendas>;
  public
    { Public declarations }
    procedure CarregaTela;
    procedure CarregaListaVendas;
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

procedure TfrmPrincipal.CarregaListaVendas;
begin

  FListaVendas.Clear;

  for var i := 0 to 10 do
  begin
    var LFrame:= TFrameVendas.Create(self);

    LFrame.Name:= 'FRame'+i.ToString;
    LFrame.Align:= TAlignLayout.Top;

    LFrame.lblCliente.Text:= 'Cliente '+i.ToString;
    LFrame.lblValor.Text:= (i*random(999)).tostring;
    LFrame.lblData.Text:= FormatDateTime('dd/mm/yyyy hh:mm:ss',now);

    LFrame.Margins.Left:= 24;
    LFrame.Margins.Right:= 24;
    LFrame.Margins.Top:= 16;

    VertScrollBox1.AddObject(LFrame);
    FListaVendas.Add(LFrame);

  end;

end;

procedure TfrmPrincipal.CarregaTela;
begin
//
  CarregaListaVendas;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  inherited;
  FListaVendas:= TObjectList<TFrameVendas>.create;
end;

procedure TfrmPrincipal.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FListaVendas);
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  inherited;
  CarregaTela;
end;

procedure TfrmPrincipal.lytbtn3Click(Sender: TObject);
var
 LProc:TProc;
begin
  inherited;

  //Loading

  LProc:=
  procedure
  begin
    lblQtdVendas.Text:= (lblQtdVendas.Text.ToInteger+1).ToString;
    CarregaListaVendas;
  end;


  TThread.CreateAnonymousThread(
  procedure
  begin

    TThread.Synchronize(nil,
    procedure
    begin
      if not Assigned(frmProdutos) then
        Application.CreateForm(TfrmProdutos,frmProdutos);
    end);

    frmProdutos.CarregaTela(LProc);

    TThread.Synchronize(nil,
    procedure
    begin
      frmProdutos.Show;
    end);


  end).Start;

end;

end.
