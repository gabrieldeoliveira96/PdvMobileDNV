unit frame.vendas;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  System.Skia, FMX.Skia, FMX.Objects, FMX.Layouts;

type
  TFrameVendas = class(TFrame)
    Rectangle1: TRectangle;
    lblCliente: TSkLabel;
    lblValor: TSkLabel;
    Layout1: TLayout;
    SkLabel1: TSkLabel;
    lblData: TSkLabel;
    SkLabel3: TSkLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
