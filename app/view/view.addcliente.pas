unit view.addcliente;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  heranca.base, FMX.Effects, FMX.Filter.Effects, FMX.Controls.Presentation,
  FMX.Layouts, System.Skia, FMX.Skia, UI.Base, UI.Edit, UI.Standard, UI.Calendar,
  uGosBase, uGosStandard, uFancyDialog;

type
  Tfrmaddcliente = class(TfrmHerancaBase)
    Layout1: TLayout;
    SpeedButton1: TSpeedButton;
    FillRGBEffect1: TFillRGBEffect;
    VertScrollBox1: TVertScrollBox;
    edtNome: TEditView;
    Layout2: TLayout;
    SkLabel1: TSkLabel;
    Layout3: TLayout;
    edtCPF: TEditView;
    SkLabel2: TSkLabel;
    Layout4: TLayout;
    SkLabel3: TSkLabel;
    DateView1: TDateView;
    Layout5: TLayout;
    Layout6: TLayout;
    btnSalvar: TButtonView;
    SkLabel7: TSkLabel;
    Layout7: TLayout;
    GosButtonView2: TButtonView;
    SkLabel8: TSkLabel;
    procedure btnSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton1Click(Sender: TObject);
    procedure GosButtonView2Click(Sender: TObject);
  private
    { Private declarations }
    FMsg:TFancyDialog;
    FCallBack:TProc;
  public
    { Public declarations }
    procedure CarregaTela(ACallBack:TProc);

  end;

var
  frmaddcliente: Tfrmaddcliente;

implementation

{$R *.fmx}

procedure Tfrmaddcliente.CarregaTela(ACallBack: TProc);
begin
  FCallBack:= ACallBack;
end;

procedure Tfrmaddcliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action:= TCloseAction.caFree;
  frmaddcliente:= nil;

end;

procedure Tfrmaddcliente.FormCreate(Sender: TObject);
begin
  inherited;
  FMsg:= TFancyDialog.Create(self);
end;

procedure Tfrmaddcliente.btnSalvarClick(Sender: TObject);
begin
  inherited;

  FMsg.Show(TIconDialog.Question,
  'Confirme',
  'Confirme para salvar',
  'Confirmar',
  procedure
  begin
    //post na api
    FCallBack;
  end,
  'Cancelar');
end;

procedure Tfrmaddcliente.GosButtonView2Click(Sender: TObject);
begin
  inherited;
  close;
end;

procedure Tfrmaddcliente.SpeedButton1Click(Sender: TObject);
begin
  inherited;
  close;
end;

end.
