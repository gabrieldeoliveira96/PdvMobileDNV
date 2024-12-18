program PdvNaVeia;

uses
  System.StartUpCopy,
  FMX.Forms,
  view.principal in 'view\view.principal.pas' {frmPrincipal},
  heranca.base in 'heranca\heranca.base.pas' {frmHerancaBase},
  heranca.botao in 'heranca\heranca.botao.pas' {frmHerancaBotao},
  view.produtos in 'view\view.produtos.pas' {frmProdutos},
  frame.produtos in 'view\frame\frame.produtos.pas' {frameProduto: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmHerancaBase, frmHerancaBase);
  Application.CreateForm(TfrmHerancaBotao, frmHerancaBotao);
  Application.CreateForm(TfrmProdutos, frmProdutos);
  Application.Run;
end.
