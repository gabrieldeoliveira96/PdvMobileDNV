unit view.venda;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  heranca.base, FMX.Objects, FMX.Layouts,
  System.Skia, FMX.Skia, FMX.Effects, FMX.Filter.Effects,
  FMX.Controls.Presentation, uFancyDialog,
  uCombobox, uConnection, uConstants, System.JSON, uLoading, uGosStandard,
  uGosBase, uGosEdit;

type
  TTipoCarreTela = (NovaVenda, VisualizarVenda);

  TfrmVenda = class(TfrmHerancaBase)
    Layout2: TLayout;
    Layout8: TLayout;
    SpeedButton1: TSpeedButton;
    FillRGBEffect1: TFillRGBEffect;
    SkLabel9: TSkLabel;
    Layout5: TLayout;
    btnCadastrar: TGosButtonView;
    Layout1: TLayout;
    edtCliente: TGosEditView;
    SkLabel1: TSkLabel;
    Layout3: TLayout;
    edtProduto: TGosEditView;
    SkLabel2: TSkLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GosButtonView1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure SkLabel8Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure btnCadastrarClick(Sender: TObject);
    procedure edtClienteClick(Sender: TObject);
    procedure edtProdutoClick(Sender: TObject);
  private
    { Private declarations }
    FIdVenda:integer;
    FTipoCarregaTela: TTipoCarreTela;
    FMsg:TFancyDialog;
    FComboCliente:TCustomCombo;
    FComboProduto:TCustomCombo;
    FCodCliente: integer;
    FCodProduto: integer;
    FCallBack:TProc;
    procedure CriaComboboxCliente;
    procedure PopulaComboboxCliente;
    procedure CriaComboboxProduto;
    procedure PopulaComboboxProduto;

    {$IFDEF MSWINDOWS}
    procedure ItemClickCliente(Sender: TObject);
    procedure ItemClickProduto(Sender: TObject);
    {$ELSE}
    procedure ItemClickCliente(Sender: TObject; const Point: TPointF);
    procedure ItemClickProduto(Sender: TObject; const Point: TPointF);
    {$ENDIF}

    procedure OnCloseItem(Sender: TObject);
    procedure CarregaVenda;
  public
    { Public declarations }
    procedure CarregaTela(AIdVenda:Integer; ATipoCarregaTela:TTipoCarreTela; ACallBack:TProc);
  end;

var
  frmVenda: TfrmVenda;

implementation

{$R *.fmx}

uses view.principal;

{ TfrmHerancaBase1 }

procedure TfrmVenda.btnCadastrarClick(Sender: TObject);
begin
  inherited;
  FMsg.Show(TIconDialog.Question,
  'Confirme para realizar a Venda',
  '',
  'Sim',
  procedure
  begin

    TLoading.Show(self,'Aguarde Cadastrando Venda');

    TThread.CreateAnonymousThread(
    procedure
    var
      LCon:TConnection;
      LJsonObject:TJSONObject;
      LJsonArrayProdutos:TJSONArray;
      LJsonObjectProdutos:TJSONObject;
      LResult:string;
      LParameter:TParameter;
    begin

      try

        LCon:= TConnection.Create;
        LJsonObject:= TJSONObject.Create;
        try

          LJsonObject.AddPair('codCliente',FCodCliente);
          LJsonObject.AddPair('valorTotal',10);
          LJsonObject.AddPair('valorSubtotal',20);
          LJsonObject.AddPair('valorDesconto',30);
          LJsonObject.AddPair('codUsuario',frmPrincipal.FCodUser);


          LJsonObjectProdutos:= TJSONObject.Create;
          LJsonObjectProdutos.AddPair('codProduto',FCodProduto);
          LJsonObjectProdutos.AddPair('quantidade',1);
          LJsonObjectProdutos.AddPair('valorUnitario',50);
          LJsonObjectProdutos.AddPair('valorTotal',50);
          LJsonObjectProdutos.AddPair('desconto',5);

          LJsonArrayProdutos:= TJSONArray.Create;
          LJsonArrayProdutos.Add(LJsonObjectProdutos);

          LJsonObject.AddPair('items',LJsonArrayProdutos);

          LParameter.Token:= frmPrincipal.FToken;

          if not LCon.Post(URL+'insere/venda',LParameter,LJsonObject,LResult) then
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

          FMsg.Show(TIconDialog.Success,'Produto cadastrado com sucesso',
          '',
          'Ok',
          procedure
          begin
            FCallBack;
            self.Close;
          end);

        end);

      end;

    end).Start;

  end,
  'Não');
end;

procedure TfrmVenda.CarregaTela(AIdVenda:Integer; ATipoCarregaTela:TTipoCarreTela; ACallBack:TProc);
begin
  FIdVenda:= AIdVenda;
  FTipoCarregaTela:= ATipoCarregaTela;
  FCallBack:= ACallBack;

  if ATipoCarregaTela = TTipoCarreTela.VisualizarVenda then
  begin
    CarregaVenda;
    btnCadastrar.Visible:= false;
  end;

  if ATipoCarregaTela = TTipoCarreTela.NovaVenda then
    btnCadastrar.Visible:= true;
end;

procedure TfrmVenda.CarregaVenda;
var
 LCon:TConnection;
 LParam: TParameter;
 LResult:string;
 LJsonObject:TJSONObject;
 LJsonArray:TJSONArray;
begin

  LCon:= TConnection.Create;
  try
    LParam.Token:= frmPrincipal.FToken;


    if not LCon.Get(URL+'lista/venda/'+FIdVenda.ToString,LParam,LResult) then
    begin
      TThread.Synchronize(nil,
      procedure
      begin
        FMsg.Show(TIconDialog.Error,'erro na requisição','');
        exit;
      end);
    end;

    LJsonObject:= TJSONObject.ParseJSONValue(LResult) as TJSONObject;

  finally
    FreeAndNil(LCon);
  end;

  TThread.Synchronize(nil,
  procedure
  begin

    edtCliente.Text := LJsonObject.GetValue<string>('nomeCliente');
    FCodCliente := LJsonObject.GetValue<integer>('codCliente');

    LJsonArray:= LJsonObject.GetValue<TJSONArray>('items');

    if LJsonArray.Count > 0 then
    begin

      edtProduto.Text := LJsonArray.Items[0].GetValue<string>('descricao');
      FCodProduto := LJsonArray.Items[0].GetValue<integer>('codProduto');

    end;

  end);

end;

procedure TfrmVenda.CriaComboboxCliente;
begin
  FComboCliente := TCustomCombo.Create(self);
  FComboCliente.TitleMenuText := 'Selecione o cliente';
  FComboCliente.SubTitleMenuText := '';
  FComboCliente.BackgroundColor := $FFF2F2F8;
  FComboCliente.OnClick := ItemClickCliente;
  FComboCliente.OnClose := OnCloseItem;
end;

procedure TfrmVenda.CriaComboboxProduto;
begin
  FComboProduto := TCustomCombo.Create(self);
  FComboProduto.TitleMenuText := 'Selecione o produto';
  FComboProduto.SubTitleMenuText := '';
  FComboProduto.BackgroundColor := $FFF2F2F8;
  FComboProduto.OnClick := ItemClickProduto;
  FComboProduto.OnClose := OnCloseItem;
end;

procedure TfrmVenda.edtClienteClick(Sender: TObject);
begin
  inherited;
  CriaComboboxCliente;
  PopulaComboboxCliente;
end;

procedure TfrmVenda.edtProdutoClick(Sender: TObject);
begin
  inherited;
  CriaComboboxProduto;
  PopulaComboboxProduto;
end;

{$IFDEF MSWINDOWS}
procedure TfrmVenda.ItemClickCliente(Sender: TObject);
{$ELSE}
procedure TfrmVenda.ItemClickCliente(Sender: TObject; const Point: TPointF);
{$ENDIF}
begin
  edtCliente.Text := FComboCliente.DescrItem;
  FCodCliente := StrToInt(FComboCliente.CodItem);
  FComboCliente.HideMenu;
end;

{$IFDEF MSWINDOWS}
procedure TfrmVenda.ItemClickProduto(Sender: TObject);
{$ELSE}
procedure TfrmVenda.ItemClickProduto(Sender: TObject; const Point: TPointF);
{$ENDIF}
begin
  edtProduto.Text := FComboProduto.DescrItem;
  FCodProduto := StrToInt(FComboProduto.CodItem);
  FComboProduto.HideMenu;
end;

procedure TfrmVenda.OnCloseItem(Sender: TObject);
begin
  FreeAndNil(Sender);
end;

procedure TfrmVenda.PopulaComboboxCliente;
var
 LCon:TConnection;
 LParam: TParameter;
 LResult:string;
 LJsonArray:TJSONArray;
begin

  TLoading.Show(self,'Aguarde, carregando clientes');

  TThread.CreateAnonymousThread(
  procedure
  begin

    LCon:= TConnection.Create;
    try
      LParam.Token:= frmPrincipal.FToken;

      if not LCon.Get(URL+'lista/cliente',LParam,LResult) then
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
      for var LJson in LJsonArray do
        FComboCliente.AddItem(LJson.GetValue<string>('cod'),
                              LJson.GetValue<string>('nome'));

      FComboCliente.ShowMenu;
      TLoading.Hide;
    end);

  end).Start;
end;

procedure TfrmVenda.PopulaComboboxProduto;
var
 LCon:TConnection;
 LParam: TParameter;
 LResult:string;
 LJsonArray:TJSONArray;

begin

  TLoading.Show(self,'Aguarde, carregando produtos');

  TThread.CreateAnonymousThread(
  procedure
  begin

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
      FComboProduto.AddItem(LJson.GetValue<string>('cod'), LJson.GetValue<string>('descricao'));

    TThread.Synchronize(nil,
    procedure
    begin
      FComboProduto.ShowMenu;
      TLoading.Hide;
    end);
  end).Start;
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
