unit view.addcliente;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  heranca.base, FMX.Effects, FMX.Filter.Effects, FMX.Controls.Presentation,
  FMX.Layouts, System.Skia, FMX.Skia, UI.Base, UI.Edit, UI.Standard, UI.Calendar,
  uGosBase, uGosStandard, uFancyDialog, uLoading, uConnection, uConstants,
  System.JSON;

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
    SkLabel2: TSkLabel;
    Layout5: TLayout;
    Layout4: TLayout;
    SkLabel3: TSkLabel;
    edtEndereco: TEditView;
    edtTelefone: TEditView;
    Layout8: TLayout;
    SkLabel4: TSkLabel;
    edtEmail: TEditView;
    btnCadastrar: TButtonView;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton1Click(Sender: TObject);
    procedure GosButtonView2Click(Sender: TObject);
    procedure btnCadastrarClick(Sender: TObject);
  private
    { Private declarations }
    FMsg:TFancyDialog;
  public
    { Public declarations }
    procedure CarregaTela;

  end;

var
  frmaddcliente: Tfrmaddcliente;

implementation

{$R *.fmx}

uses view.principal, view.cliente;

procedure Tfrmaddcliente.btnCadastrarClick(Sender: TObject);
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

          LJsonObject.AddPair('nome',edtNome.Text);
          LJsonObject.AddPair('endereco',edtEndereco.Text);
          LJsonObject.AddPair('celular',edtTelefone.Text);
          LJsonObject.AddPair('email',edtEmail.Text);

          LJsonObject.AddPair('cpf','01012345600');
          LJsonObject.AddPair('dataNascimento','2023/03/03');
          LJsonObject.AddPair('cep','29900100');
          LJsonObject.AddPair('cidade','linhares');
          LJsonObject.AddPair('bairro','bnh');

          LJsonObject.AddPair('uf','ES');
          LJsonObject.AddPair('numero','5');
          LJsonObject.AddPair('complemento','');

          LParameter.Token:= frmPrincipal.FToken;

          if not LCon.Post(URL+'cadastra/cliente',LParameter,LJsonObject,LResult) then
          begin
            Tthread.Synchronize(nil,
            procedure
            begin
              FMsg.Show(TIconDialog.Error,'Erro ao enviar','Erro ao enviar dados para o servidor');
            end);

            exit;
          end;

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
          if Assigned(frmCliente) then
            frmCliente.Close;
        end);

      end;

    end).Start;



  end,
  'Cancelar');

end;

procedure Tfrmaddcliente.CarregaTela;
begin
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
