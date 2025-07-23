unit frame.produtos;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, System.Skia, FMX.Skia, FMX.Layouts;

type
  TframeProduto = class(TFrame)
    Rectangle1: TRectangle;
    Layout1: TLayout;
    lblProduto: TSkLabel;
    lblData: TSkLabel;
    Layout2: TLayout;
    lblDetalhes: TSkLabel;
    lblValor: TSkLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
