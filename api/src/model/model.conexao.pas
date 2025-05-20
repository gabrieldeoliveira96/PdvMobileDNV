unit model.conexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.ConsoleUI.Wait, Data.DB, FireDAC.Comp.Client,
  System.IniFiles;

type
  TdmConexao = class(TDataModule)
    FDConnection1: TFDConnection;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    procedure DataModuleCreate(Sender: TObject);
  private
    procedure LerIni;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmConexao: TdmConexao;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

procedure TdmConexao.DataModuleCreate(Sender: TObject);
begin
  LerIni;
end;

procedure TdmConexao.LerIni;
var
  LArq: TIniFile;
begin
  LArq := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'conf.ini');
  try
    FDConnection1.Params.Values['DriverID'] := 'MySql';
    FDConnection1.Params.Values['Server'] := LArq.ReadString('CONEXAO', 'SERVER','');
    FDConnection1.Params.Values['Database'] := LArq.ReadString('CONEXAO', 'DATABASE','');
    FDConnection1.Params.Values['User_Name'] := LArq.ReadString('CONEXAO', 'USERNAME','');
    FDConnection1.Params.Values['Password'] := LArq.ReadString('CONEXAO', 'PASSWORD','');
    FDConnection1.Params.Values['Porta'] := LArq.ReadString('CONEXAO', 'PORTA','');

    FDConnection1.Connected := true;
  finally
    FreeAndNil(LArq);
  end;
end;

end.
