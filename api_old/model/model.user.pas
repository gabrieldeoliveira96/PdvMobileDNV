unit model.user;

interface

uses
  System.SysUtils, System.Classes, model.con, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.ConsoleUI.Wait,
  System.JSON, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef, DataSet.Serialize;

type
  TmodelUser = class(TDM)
    qUser: TFDQuery;
    qUserid: TIntegerField;
    qUsernome: TStringField;
    qUseremail: TStringField;
    qUsersenha: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
    function GetAllUser:TJSONArray;
    function GetUser(AId:integer):TJSONObject;
    function PostUser(AJson:TJSONObject):TJSONObject;
  end;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TmodelUser }

function TmodelUser.GetAllUser: TJSONArray;
begin

  qUser.Close;
  qUser.MacroByName('table').AsRaw:= 'user';
  qUser.Open;

  Result:= qUser.ToJSONArray;


end;

function TmodelUser.GetUser(AId: integer): TJSONObject;
begin

  qUser.Close;
  qUser.MacroByName('table').AsRaw:=
    'user where id = '+aid.ToString.QuotedString;
  qUser.Open;

  Result:= qUser.ToJSONObject;

end;

function TmodelUser.PostUser(AJson: TJSONObject): TJSONObject;
begin
  qUser.Close;
  qUser.MacroByName('table').AsRaw:= 'user';
  qUser.Open;

  qUser.Append;
  qUsernome.AsString:= AJson.GetValue<string>('nome');
  qUseremail.AsString:= AJson.GetValue<string>('email');
  qUsersenha.AsString:= AJson.GetValue<string>('senha');
  qUser.Post;

  Result:= qUser.ToJSONObject;

end;

end.
