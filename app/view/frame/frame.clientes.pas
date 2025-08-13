unit frame.clientes;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  System.Skia, FMX.Skia, FMX.Objects, FMX.Layouts;

type
  TFrameClientes = class(TFrame)
    Rectangle1: TRectangle;
    lblCliente: TSkLabel;
    lblEndereco: TSkLabel;
    Layout1: TLayout;
    Layout2: TLayout;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.
