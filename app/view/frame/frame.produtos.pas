unit frame.produtos;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, System.Skia, FMX.Skia;

type
  TframeProduto = class(TFrame)
    Rectangle1: TRectangle;
    lblProduto: TSkLabel;
    lblDescricao: TSkLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
