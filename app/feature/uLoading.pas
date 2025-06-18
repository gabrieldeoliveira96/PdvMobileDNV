unit uLoading;

interface

uses System.SysUtils, System.UITypes, FMX.Types, FMX.Controls, FMX.StdCtrls,
  FMX.Objects, FMX.Effects, FMX.Layouts, FMX.Forms, FMX.Graphics, FMX.Ani,
  FMX.VirtualKeyboard, FMX.Platform;

type
  TLoading = class
  private
    class var Layout: TLayout;
    class var Fundo: TRectangle;
    class var Arco: TArc;
    class var Mensagem: TLabel;
    class var Porcentagem: TLabel;
    class var Animacao: TFloatAnimation;
    class var FVisible:Boolean;
    class var recback : TRectangle;
    class var recfront : TRectangle;
  public
    class procedure Show(const Frm: Tform; const msg: string);
    class procedure Hide;
    class procedure ChangeText(NewText: string); static;
    class procedure Progress(Baixando,Baixado: integer); static;
    class property Visible: boolean read FVisible write FVisible;
  end;

implementation

{ TLoading }

class procedure TLoading.Hide;
begin
  if Assigned(Layout) then
  begin

    try
      if Assigned(Porcentagem) then
        Porcentagem.DisposeOf;

      if Assigned(recfront) then
        recfront.DisposeOf;

      if Assigned(recback) then
        recback.DisposeOf;

      if Assigned(Mensagem) then
        Mensagem.DisposeOf;

      if Assigned(Animacao) then
        Animacao.DisposeOf;

      if Assigned(Arco) then
        Arco.DisposeOf;

      if Assigned(Fundo) then
        Fundo.DisposeOf;

      if Assigned(Layout) then
        Layout.DisposeOf;
    except
    end;
  end;

  Porcentagem := nil;
  Mensagem := nil;
  Animacao := nil;
  Arco := nil;
  Layout := nil;
  Fundo := nil;
  recback := nil;
  recfront := nil;
  FVisible:= false;
end;

class procedure TLoading.Show(const Frm: Tform; const msg: string);
var
  FService: IFMXVirtualKeyboardService;
begin
  try
    // Panel de fundo opaco...
    Fundo := TRectangle.Create(Frm);
    Fundo.Opacity := 0;
    Fundo.Parent := Frm;
    Fundo.Visible := true;
    Fundo.Align := TAlignLayout.Contents;
    Fundo.Fill.Color := TAlphaColorRec.Black;
    Fundo.Fill.Kind := TBrushKind.Solid;
    Fundo.Stroke.Kind := TBrushKind.None;
    Fundo.Visible := true;

    // Layout contendo o texto e o arco...
    Layout := TLayout.Create(Frm);
    Layout.Opacity := 0;
    Layout.Parent := Frm;
    Layout.Visible := true;
    Layout.Align := TAlignLayout.Contents;
    Layout.Width := 250;
    Layout.Height := 78;
    Layout.Visible := true;

    // Arco da animacao...
    Arco := TArc.Create(Frm);
    Arco.Visible := true;
    Arco.Parent := Layout;
    Arco.Align := TAlignLayout.Center;
    Arco.Margins.Bottom := 55;
    Arco.Width := 25;
    Arco.Height := 25;
    Arco.EndAngle := 280;
    Arco.Stroke.Color := $FFFEFFFF;
    Arco.Stroke.Thickness := 2;
    Arco.Position.X := Round((Layout.Width - Arco.Width) / 2);
    Arco.Position.Y := 0;

    // Animacao...
    Animacao := TFloatAnimation.Create(Frm);
    Animacao.Parent := Arco;
    Animacao.StartValue := 0;
    Animacao.StopValue := 360;
    Animacao.Duration := 0.8;
    Animacao.Loop := true;
    Animacao.PropertyName := 'RotationAngle';
    Animacao.AnimationType := TAnimationType.InOut;
    Animacao.Interpolation := TInterpolationType.Linear;
    Animacao.Start;

    // Label do texto...
    Mensagem := TLabel.Create(Frm);
    Mensagem.Parent := Layout;
    Mensagem.Align := TAlignLayout.Center;
    Mensagem.Margins.Top := 60;
    Mensagem.Font.Size := 13;
    Mensagem.Height := 70;
    Mensagem.Width := Frm.Width - 100;
    Mensagem.FontColor := $FFFEFFFF;
    Mensagem.TextSettings.HorzAlign := TTextAlign.Center;
    Mensagem.TextSettings.VertAlign := TTextAlign.Leading;
    Mensagem.StyledSettings := [TStyledSetting.Family, TStyledSetting.Style];
    Mensagem.Text := msg;
    Mensagem.VertTextAlign := TTextAlign.Leading;
    Mensagem.Trimming := TTextTrimming.None;
    Mensagem.TabStop := false;
    Mensagem.SetFocus;

    // Barra de progresso
    recback := TRectangle.Create(Frm);
    recback.Opacity := 0.7;
    recback.Parent := Layout;
    recback.Align := TAlignLayout.Center;
    recback.Fill.Color := TAlphaColorRec.Gray;
    recback.Fill.Kind := TBrushKind.Solid;
    recback.Stroke.Kind := TBrushKind.None;
    recback.Visible := true;
    recback.Height := 20;
    recback.Width := Layout.Width * 0.8; 
    recback.Margins.Top := 70;    
    recback.Margins.Left := 10;
    recback.Margins.Right:= 10;
    recback.XRadius := 5;
    recback.YRadius := 5;
    recback.Visible := false;

    recfront := TRectangle.Create(Frm);
    recfront.Opacity := 1;
    recfront.Parent := recback;
    recfront.Align := TAlignLayout.Left;
    recfront.Fill.Color := TAlphaColorRec.White;
    recfront.Fill.Kind := TBrushKind.Solid;
    recfront.Stroke.Kind := TBrushKind.None;
    recfront.Visible := true;
    recfront.Height := 20;
    recfront.Width := 0;
    recfront.XRadius := 5;
    recfront.YRadius := 5;

    Porcentagem := TLabel.Create(Frm);
    Porcentagem.Parent := recback;
    Porcentagem.Align := TAlignLayout.Contents;
    Porcentagem.Font.Size := 11;
    Porcentagem.Height := 18;
    Porcentagem.FontColor := TAlphaColorRec.Black;
    Porcentagem.TextSettings.HorzAlign := TTextAlign.Center;
    Porcentagem.TextSettings.VertAlign := TTextAlign.Center;
    Porcentagem.StyledSettings := [TStyledSetting.Family, TStyledSetting.Style];
    Porcentagem.VertTextAlign := TTextAlign.center;
    Porcentagem.Trimming := TTextTrimming.None;
    Porcentagem.TabStop := false;


    // Exibe os controles...
    Fundo.AnimateFloat('Opacity', 0.7);
    Layout.AnimateFloat('Opacity', 1);
    Layout.BringToFront;

    FVisible:= true;
    // Esconde o teclado virtual...
    TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService,
      IInterface(FService));
    if (FService <> nil) then
    begin
      FService.HideVirtualKeyboard;
    end;
    FService := nil;
  except
    on e: exception do
      raise Exception.Create('TLoading error: '+e.Message);
  end;
end;

class procedure TLoading.ChangeText(NewText: string);
begin
  if Assigned(Layout) then
  begin

    try
      if Assigned(Mensagem) then
      begin
        Mensagem.Text := NewText;
        recback.Visible := true;
      end;

    except
    end;
  end;
end;

class procedure TLoading.Progress(Baixando, Baixado: integer);
var
  Porcent: double;
begin
  Porcent := 0;
  if Assigned(recfront) then
  begin
    try
      Porcent := Baixado / Baixando;
      recfront.Width := recback.Width * Porcent;
      Porcentagem.Text :=   FormatFloat( '0.00%' ,Porcent * 100);
    except
    end;
  end;
end;
end.
