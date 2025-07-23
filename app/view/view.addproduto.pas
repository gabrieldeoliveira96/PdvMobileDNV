unit view.addproduto;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  heranca.base, System.Skia, UI.Standard, FMX.Skia, UI.Base, UI.Edit,
  FMX.Layouts, FMX.Effects, FMX.Filter.Effects, FMX.Controls.Presentation,
  uFancyDialog, uLoading, uConnection, uConstants, System.JSON, frame.produtos;

type
  Tfrmaddproduto = class(TfrmHerancaBase)
    Layout1: TLayout;
    SpeedButton1: TSpeedButton;
    FillRGBEffect1: TFillRGBEffect;
    VertScrollBox1: TVertScrollBox;
    Layout2: TLayout;
    edtNome: TEditView;
    SkLabel1: TSkLabel;
    Layout3: TLayout;
    SkLabel2: TSkLabel;
    edtValor: TEditView;
    Layout5: TLayout;
    btnCadastrar: TButtonView;
    Layout4: TLayout;
    SkLabel3: TSkLabel;
    edtCodBarra: TEditView;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCadastrarClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
    FCallBack:TProc;
    FMsg:TFancyDialog;
  public
    { Public declarations }
    procedure CarregaTela(ACallBack:TProc);
  end;

var
  frmaddproduto: Tfrmaddproduto;

implementation

{$R *.fmx}

uses view.principal, view.produtos;

procedure Tfrmaddproduto.btnCadastrarClick(Sender: TObject);
begin
  inherited;
  FMsg.Show(TIconDialog.Question,
  'Confirme',
  'Confirme para salvar',
  'Confirmar',
  procedure
  begin
    TLoading.Show(self,'Aguarde Cadatrando');

    TThread.CreateAnonymousThread(
    procedure
    var
      LCon:TConnection;
      LJsonObject:TJSONObject;
      LResult:string;
      LParameter:TParameter;
    begin

      try

        LCon:= TConnection.Create;
        LJsonObject:= TJSONObject.Create;
        try

          LJsonObject.AddPair('descricao',edtNome.Text);
          LJsonObject.AddPair('precoCompra','0');
          LJsonObject.AddPair('precoVenda',edtValor.Text);
          LJsonObject.AddPair('unidade','UN');

          LJsonObject.AddPair('estoque','100');
          LJsonObject.AddPair('codCategoria','5');
          LJsonObject.AddPair('codigoBarra',edtCodBarra.Text);
          LJsonObject.AddPair('image','');

          LParameter.Token:= frmPrincipal.FToken;

          if not LCon.Post(URL+'cadastra/produto',LParameter,LJsonObject,LResult) then
          begin
            Tthread.Synchronize(nil,
            procedure
            begin
              FMsg.Show(TIconDialog.Error,'Erro ao enviar','Erro ao enviar dados para o servidor');
            end);

            exit;
          end;
          FCallBack;

        finally
          FreeAndNil(LCon);
          FreeAndNil(LJsonObject);
        end;


      finally

        Tthread.Synchronize(nil,
        procedure
        begin
          TLoading.Hide;
          self.Close;
          if Assigned(frmProdutos) then
            frmProdutos.Close;

        end);

      end;

    end).Start;



  end,
  'Cancelar');

end;

procedure Tfrmaddproduto.CarregaTela(ACallBack:TProc);
begin
  FCallBack:= ACallBack;
end;

procedure Tfrmaddproduto.FormCreate(Sender: TObject);
begin
  inherited;
  FMsg:= TFancyDialog.Create(self);
end;

procedure Tfrmaddproduto.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FMsg);
end;

procedure Tfrmaddproduto.SpeedButton1Click(Sender: TObject);
begin
  inherited;
  self.Close;
end;

end.
