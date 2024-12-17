unit heranca.base;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts;

type
  TfrmHerancaBase = class(TForm)
    lytBotao: TLayout;
    lytbtn1: TLayout;
    lytbtn3: TLayout;
    lytbtn4: TLayout;
    lytbtn2: TLayout;
    lytbtn5: TLayout;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmHerancaBase: TfrmHerancaBase;

implementation

{$R *.fmx}

end.
