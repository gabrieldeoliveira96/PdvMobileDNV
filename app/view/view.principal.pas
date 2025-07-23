unit view.principal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  heranca.base, FMX.Layouts, System.Skia, UI.Base, UI.Standard, FMX.Skia,
  FMX.Objects, Alcinoe.FMX.Objects, FMX.ListBox, FMX.Effects,
  FMX.Filter.Effects, uGosObjects, heranca.botao, view.produtos,
  System.Generics.Collections, frame.vendas, view.addcliente,
  Alcinoe.FMX.Controls, uLoading, uConnection, uConstants, System.JSON,
  uFancyDialog;

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
    ALRectangle1: TGosRectangle;
    ALRectangle2: TGosRectangle;
    Layout3: TLayout;
    lblQtdClientes: TSkLabel;
    SkLabel5: TSkLabel;
    Layout5: TLayout;
    VertScrollBox1: TVertScrollBox;
    Layout6: TLayout;
    SkLabel4: TSkLabel;
    Layout8: TLayout;
    lblQtdProdutos: TSkLabel;
    SkLabel6: TSkLabel;
    SkLabel8: TSkLabel;
    procedure btnAddClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ListBoxItem1Click(Sender: TObject);
    procedure ListBoxItem2Click(Sender: TObject);
  private
    { Private declarations }
    FListaVendas:TObjectList<TFrameVendas>;
    procedure AtualizaContadorProduto;
    procedure AtualizaContadorCliente;
  public
    { Public declarations }
    procedure CarregaTela(AToken:string);
    procedure CarregaListaVendas;
    var
     FToken:string;
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

uses view.cliente;

procedure TfrmPrincipal.CarregaListaVendas;
begin


  FListaVendas.Clear;

  for var i := 0 to 10 do
  begin
    var LFrame:= TFrameVendas.Create(self);

    LFrame.Name:= 'FRame'+i.ToString;
    LFrame.Align:= TAlignLayout.Top;

    LFrame.lblCliente.Text:= 'Cliente '+i.ToString;
    LFrame.lblProduto.Text:= 'Produto '+i.ToString;
    LFrame.lblValor.Text:= (i*random(999)).tostring;
    LFrame.lblData.Text:= FormatDateTime('dd/mm/yyyy hh:mm:ss',now);

    LFrame.Margins.Left:= 24;
    LFrame.Margins.Right:= 24;
    LFrame.Margins.Top:= 16;

    VertScrollBox1.AddObject(LFrame);
    FListaVendas.Add(LFrame);

  end;

end;

procedure TfrmPrincipal.CarregaTela(AToken:string);
begin
  FToken:= AToken;

  TThread.Synchronize(nil,
  procedure
  begin
    VertScrollBox1.BeginUpdate;
  end);

  CarregaListaVendas;

  TThread.Synchronize(nil,
  procedure
  begin
    VertScrollBox1.EndUpdate;
  end);

  AtualizaContadorProduto;
  AtualizaContadorCliente;

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
//  CarregaTela;
end;

procedure TfrmPrincipal.ListBoxItem1Click(Sender: TObject);
begin
  inherited;

  TLoading.Show(self,'Aguarde, carregando cliente!');

  TThread.CreateAnonymousThread(
  procedure
  begin
    try
      Tthread.Synchronize(nil,
      procedure
      begin
        if not Assigned(frmCliente) then
          Application.CreateForm(TfrmCliente, frmCliente);

      end);

      frmCliente.CarregaTela;

      Tthread.Synchronize(nil,
      procedure
      begin
        frmCliente.Show;

      end);
    finally

      Tthread.Synchronize(nil,
      procedure
      begin
        TLoading.Hide;

      end);
    end;

  end).Start;

end;

procedure TfrmPrincipal.ListBoxItem2Click(Sender: TObject);
begin
  inherited;
  TLoading.Show(self,'Aguarde, carregando produtos!');

  TThread.CreateAnonymousThread(
  procedure
  begin
    try
      Tthread.Synchronize(nil,
      procedure
      begin
        if not Assigned(frmProdutos) then
          Application.CreateForm(TfrmProdutos, frmProdutos);

      end);

      frmProdutos.CarregaTela(AtualizaContadorProduto);

      Tthread.Synchronize(nil,
      procedure
      begin
        frmProdutos.Show;

      end);
    finally

      Tthread.Synchronize(nil,
      procedure
      begin
        TLoading.Hide;

      end);
    end;

  end).Start;


end;

procedure TfrmPrincipal.AtualizaContadorCliente;
var
 LCon:TConnection;
 LParam: TParameter;
 LResult:string;
 LJsonArray:TJSONArray;
begin

  LCon:= TConnection.Create;
  try
    LParam.Token:= FToken;

    if not LCon.Get(URL+'lista/cliente',LParam,LResult) then
      exit;

    LJsonArray:= TJSONObject.ParseJSONValue(LResult) as TJSONArray;

  finally
    FreeAndNil(LCon);
  end;


  lblQtdClientes.Text:= LJsonArray.Count.ToString;

end;

procedure TfrmPrincipal.AtualizaContadorProduto;
var
 LCon:TConnection;
 LParam: TParameter;
 LResult:string;
 LJsonArray:TJSONArray;
begin

  LCon:= TConnection.Create;
  try
    LParam.Token:= FToken;

    if not LCon.Get(URL+'lista/produto',LParam,LResult) then
      exit;

    LJsonArray:= TJSONObject.ParseJSONValue(LResult) as TJSONArray;

  finally
    FreeAndNil(LCon);
  end;

  TThread.Synchronize(nil,
  procedure
  begin
    lblQtdProdutos.Text:= LJsonArray.Count.ToString;
  end);
end;

procedure TfrmPrincipal.btnAddClick(Sender: TObject);
begin
  inherited;

  TLoading.Show(self,'Aguarde carregando tela');

  TThread.CreateAnonymousThread(
  procedure
  begin
    try
      TThread.Synchronize(nil,
      procedure
      begin
        if not Assigned(frmProdutos) then
          Application.CreateForm(TfrmProdutos,frmProdutos);
      end);

      frmProdutos.CarregaTela(CarregaListaVendas);

      TThread.Synchronize(nil,
      procedure
      begin
        frmProdutos.Show;
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



end.
