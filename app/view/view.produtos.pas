unit view.produtos;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  heranca.base, FMX.Effects, FMX.Filter.Effects, FMX.Controls.Presentation,
  FMX.Layouts, frame.produtos, System.Skia, FMX.Objects, FMX.Skia, UI.Standard,
  UI.Base, UI.Edit, uConnection, System.JSON, uConstants, uFancyDialog, uLoading,
  view.addproduto;

type
  TfrmProdutos = class(TfrmHerancaBase)
    VertScrollBox1: TVertScrollBox;
    Layout1: TLayout;
    SpeedButton1: TSpeedButton;
    FillRGBEffect1: TFillRGBEffect;
    SkLabel1: TSkLabel;
    SkLabel2: TSkLabel;
    Circle1: TCircle;
    SkLabel3: TSkLabel;
    Layout2: TLayout;
    EditView1: TEditView;
    btnLogin: TButtonView;
    SkLabel4: TSkLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Circle1Click(Sender: TObject);
  private
    { Private declarations }
    FCallBack:TProc;
    FMsg:TFancyDialog;
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

uses view.venda,view.principal;

{ TfrmProdutos }

procedure TfrmProdutos.CarregaTela(ACallBack:TProc);
var
 LCon:TConnection;
 LParam: TParameter;
 LResult:string;
 LJsonArray:TJSONArray;
begin

  FCallBack:= ACallBack;

  LCon:= TConnection.Create;
  try
    LParam.Token:= frmPrincipal.FToken;

    if not LCon.Get(URL+'lista/produto',LParam,LResult) then
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
    var LFrame:= TframeProduto.Create(self);  //alterar para frame de cliente

    LFrame.Name:= 'FRame'+LJson.GetValue<string>('cod');
    LFrame.Align:= TAlignLayout.Top;
    LFrame.Tag:= LJson.GetValue<integer>('cod');

    LFrame.lblProduto.Text:= LJson.GetValue<string>('descricao');
    LFrame.lblDetalhes.Text:= LJson.GetValue<string>('codigoBarra');
    LFrame.lblData.Text:= Formatdatetime('dd/mm/yyyy',now);
    LFrame.lblValor.Text:= LJson.GetValue<string>('precoVenda');

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

procedure TfrmProdutos.Circle1Click(Sender: TObject);
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

        if not Assigned(frmaddproduto) then
          Application.CreateForm(Tfrmaddproduto,frmaddproduto);
      end);

      frmaddproduto.CarregaTela(FCallBack);

      TThread.Synchronize(nil,
      procedure
      begin

        frmaddproduto.Show;
      end);

    finally
      TThread.Synchronize(nil,
      procedure
      begin

        TLoading.Hide;
      end)
    end;


  end).Start;
end;

procedure TfrmProdutos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action:= TCloseAction.caFree;
  frmProdutos:= nil;
end;

procedure TfrmProdutos.FormCreate(Sender: TObject);
begin
  inherited;
  FMsg:= TFancyDialog.Create(self);
end;

procedure TfrmProdutos.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FMsg);
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
