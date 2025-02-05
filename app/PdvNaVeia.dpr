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
  frame.vendas in 'view\frame\frame.vendas.pas' {FrameVendas: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmHerancaBase, frmHerancaBase);
  Application.CreateForm(TfrmHerancaBotao, frmHerancaBotao);
  Application.Run;
end.
