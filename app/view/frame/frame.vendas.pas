unit frame.vendas;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  System.Skia, FMX.Skia, FMX.Objects, FMX.Layouts;

type
  TFrameVendas = class(TFrame)
    Rectangle1: TRectangle;
    Layout1: TLayout;
    lblCliente: TSkLabel;
    lblProduto: TSkLabel;
    SkLabel1: TSkLabel;
    lblValor: TSkLabel;
    lblData: TSkLabel;
    SkLabel3: TSkLabel;
    Layout2: TLayout;
    Layout3: TLayout;
    Layout4: TLayout;
    Layout5: TLayout;
    Layout6: TLayout;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
