unit view.principal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  heranca.base, FMX.Layouts, System.Skia, FMX.Skia,
  FMX.Objects, FMX.ListBox, FMX.Effects,
  FMX.Filter.Effects, heranca.botao, view.produtos,
  System.Generics.Collections, frame.vendas, view.addcliente,
  uLoading, uConnection, uConstants, System.JSON, uFancyDialog, view.venda,
  uGosBase, uGosStandard, uGosObjects;

type
  TfrmPrincipal = class(TfrmHerancaBotao)
    Layout1: TLayout;
    SkLabel1: TSkLabel;
    ButtonView1: TGosButtonView;
    Layout2: TLayout;
    SkLabel2: TSkLabel;
    SkLabel3: TSkLabel;
    GosCircle1: TGosCircle;
    FillRGBEffect1: TFillRGBEffect;
    ALRectangle1: TRectangle;
    ALRectangle2: TRectangle;
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
    Layout4: TLayout;
    Layout7: TLayout;
    Layout9: TLayout;
    procedure btnAddClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ALRectangle1Click(Sender: TObject);
    procedure ALRectangle2Click(Sender: TObject);
  private
    { Private declarations }
    FListaVendas:TObjectList<TFrameVendas>;
    FMsg:TFancyDialog;
    procedure AtualizaContadorProduto;
    procedure AtualizaContadorCliente;
    procedure CarregaListaVendas;
    {$IFDEF MSWINDOWS}
    procedure OnClickVendas(Sender: TObject);
    {$ELSE}
    procedure OnClickVendas(Sender: TObject; const Point: TPointF);
    {$ENDIF}
  public
    { Public declarations }
    procedure CarregaTela(ACodUser, AToken:string);
    var
     FToken:string;
     FCodUser:string;
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.fmx}

uses view.cliente;

procedure TfrmPrincipal.CarregaListaVendas;
var
 LCon:TConnection;
 LParam: TParameter;
 LResult:string;
 LJsonArray:TJSONArray;
begin

  TLoading.Show(self,'Aguarde, carregando vendas');

  TThread.CreateAnonymousThread(
  procedure
  begin

    LCon:= TConnection.Create;
    try
      LParam.Token:= FToken;

      if not LCon.Get(URL+'lista/venda',LParam,LResult) then
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

    TThread.Synchronize(nil,
    procedure
    begin
      FListaVendas.Clear;

      for var LJson in LJsonArray do
      begin
        var LFrame:= TFrameVendas.Create(self);

        LFrame.Name:= 'FRame'+LJson.GetValue<string>('codVenda');
        LFrame.Align:= TAlignLayout.Top;

        LFrame.lblCliente.Text:= LJson.GetValue<string>('nomeCliente');
        LFrame.lblValor.Text:= LJson.GetValue<string>('valorTotal');
        LFrame.lblData.Text:= LJson.GetValue<string>('dataVenda');

        LFrame.Margins.Left:= 24;
        LFrame.Margins.Right:= 24;
        LFrame.Margins.Top:= 16;


        {$IFDEF MSWINDOWS}
        LFrame.OnClick:= OnClickVendas;
        {$ELSE}
        LFrame.OnTap:= OnClickVendas;
        {$ENDIF}



        LFrame.Tag:= LJson.GetValue<integer>('codVenda');


        VertScrollBox1.AddObject(LFrame);
        FListaVendas.Add(LFrame);

      end;

      TLoading.Hide;
    end);

  end).Start;
end;


{$IFDEF MSWINDOWS}
procedure TfrmPrincipal.OnClickVendas(Sender: TObject);
{$ELSE}
procedure TfrmPrincipal.OnClickVendas(Sender: TObject; const Point: TPointF);
{$ENDIF}
begin
  TLoading.Show(self,'Aguarde carregando tela');

  TThread.CreateAnonymousThread(
  procedure
  begin
    try
      TThread.Synchronize(nil,
      procedure
      begin
        if not Assigned(frmVenda) then
          Application.CreateForm(TfrmVenda,frmVenda);
      end);

      frmVenda.CarregaTela(TFrameVendas(Sender).Tag, TTipoCarreTela.VisualizarVenda, nil);

      TThread.Synchronize(nil,
      procedure
      begin
        frmVenda.Show;
      end);

    finally

      TThread.Synchronize(nil,
      procedure
      begin
        TLoading.Hide;
      end);

    end;


  end).Start;



//
end;


procedure TfrmPrincipal.CarregaTela(ACodUser, AToken:string);
begin
  FToken:= AToken;
  FCodUser:= ACodUser;

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
  FMsg:= TFancyDialog.Create(self);
end;

procedure TfrmPrincipal.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FListaVendas);
  FreeAndNil(FMsg);
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  inherited;
//  CarregaTela;
end;

procedure TfrmPrincipal.ALRectangle1Click(Sender: TObject);
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

procedure TfrmPrincipal.ALRectangle2Click(Sender: TObject);
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
        if not Assigned(frmVenda) then
          Application.CreateForm(TfrmVenda,frmVenda);
      end);

      frmVenda.carregaTela(0, NovaVenda, CarregaListaVendas);

      TThread.Synchronize(nil,
      procedure
      begin
        frmVenda.Show;
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
