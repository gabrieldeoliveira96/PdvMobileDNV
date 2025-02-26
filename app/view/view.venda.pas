unit view.venda;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  heranca.base, FMX.Objects, uGosObjects, uGosBase, uGosStandard, FMX.Layouts,
  System.Skia, FMX.Skia, FMX.Effects, FMX.Filter.Effects,
  FMX.Controls.Presentation, uFancyDialog, UI.Base, UI.Standard;

type
  TfrmVenda = class(TfrmHerancaBase)
    GosButtonView1: TButtonView;
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
    GosButtonView2: TButtonView;
    SkLabel7: TSkLabel;
    SkLabel8: TSkLabel;
    Layout8: TLayout;
    SpeedButton1: TSpeedButton;
    FillRGBEffect1: TFillRGBEffect;
    SkLabel9: TSkLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GosButtonView1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SkLabel8Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
    FCallBack:TProc;
    FMsg:TFancyDialog;
  public
    { Public declarations }
    procedure CarregaTela(AProduto:string; ACallBack:TProc);
  end;

var
  frmVenda: TfrmVenda;

implementation

{$R *.fmx}

uses view.principal;

{ TfrmHerancaBase1 }

procedure TfrmVenda.CarregaTela(AProduto:string; ACallBack:TProc);
begin
  FCallBack:= ACallBack;
  TThread.Synchronize(nil,
  procedure
  begin
    lblProduto.Text:= AProduto;

  end);

end;

procedure TfrmVenda.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action:= TCloseAction.caFree;
  frmVenda:= nil;
end;

procedure TfrmVenda.FormCreate(Sender: TObject);
begin
  inherited;
  FMsg:= TFancyDialog.Create(self);
end;

procedure TfrmVenda.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FMsg);

end;

procedure TfrmVenda.GosButtonView1Click(Sender: TObject);
begin
  inherited;

  FMsg.Show(
  TIconDialog.Question,
  'Confirme',
  'Confirme para salvar',
  'Confirmar',
  procedure
  begin
    FCallBack;
    self.Close;
  end,
  'Sair');
end;

procedure TfrmVenda.SkLabel8Click(Sender: TObject);
begin
  inherited;
  self.Close;

end;

procedure TfrmVenda.SpeedButton1Click(Sender: TObject);
begin
  inherited;
  self.Close;
end;

end.
