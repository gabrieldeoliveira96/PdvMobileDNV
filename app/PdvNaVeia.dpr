program PdvNaVeia;

uses
  System.StartUpCopy,
  FMX.Forms,
  view.principal in 'view\view.principal.pas' {frmPrincipal},
  heranca.base in 'heranca\heranca.base.pas' {frmHerancaBase},
  heranca.botao in 'heranca\heranca.botao.pas' {frmHerancaBotao},
  view.produtos in 'view\view.produtos.pas' {frmProdutos},
  frame.produtos in 'view\frame\frame.produtos.pas' {frameProduto: TFrame},
  view.venda in 'view\view.venda.pas' {frmVenda},
  frame.vendas in 'view\frame\frame.vendas.pas' {FrameVendas: TFrame},
  uFancyDialog in 'feature\uFancyDialog.pas',
  view.cliente in 'view\view.cliente.pas' {frmCliente},
  view.addcliente in 'view\view.addcliente.pas' {frmaddcliente},
  view.login in 'view\view.login.pas' {frmLogin},
  view.splash in 'view\view.splash.pas' {frmSplash},
  uConnection in 'feature\uConnection.pas',
  uLoading in 'feature\uLoading.pas',
  uCombobox in 'feature\uCombobox.pas',
  uConstants in 'feature\uConstants.pas',
  frame.clientes in 'view\frame\frame.clientes.pas' {FrameClientes: TFrame},
  view.addproduto in 'view\view.addproduto.pas' {frmaddproduto};

{$R *.res}

begin
  Application.Initialize;
  Application.FormFactor.Orientations := [TFormOrientation.Portrait];
  Application.CreateForm(TfrmSplash, frmSplash);
  Application.CreateForm(TfrmHerancaBase, frmHerancaBase);
  Application.CreateForm(TfrmHerancaBotao, frmHerancaBotao);
  Application.Run;
end.
