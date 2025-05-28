unit heranca.botao;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  heranca.base, System.Skia, FMX.Skia, FMX.Objects, uGosObjects, FMX.Layouts,
  Alcinoe.FMX.Objects, Alcinoe.FMX.Controls;

type
  TfrmHerancaBotao = class(TfrmHerancaBase)
    lytBotao: TLayout;
    lytbtn1: TLayout;
    btnAdd: TLayout;
    GosCircle3: TGosCircle;
    SkSvg1: TSkSvg;
    lytbtn4: TLayout;
    lytbtn2: TLayout;
    lytbtn5: TLayout;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmHerancaBotao: TfrmHerancaBotao;

implementation

{$R *.fmx}

end.
