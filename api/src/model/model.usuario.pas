unit model.usuario;

interface

uses
  System.SysUtils, System.Classes, model.conexao, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef, FireDAC.ConsoleUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, System.JSON, FireDAC.VCLUI.Wait, DataSet.Serialize,
  classe.hash.senha;

type
  TdmUsuario = class(TdmConexao)
    qryCadastraUsuario: TFDQuery;
    qryAux: TFDQuery;
    qryCadastraUsuarioCOD: TFDAutoIncField;
    qryCadastraUsuarioNOME: TStringField;
    qryCadastraUsuarioLOGIN: TStringField;
    qryCadastraUsuarioSENHA: TStringField;
    qryCadastraUsuarioSALT: TStringField;
    qryCadastraUsuarioDT_CADASTRO: TDateField;
    qryCadastraUsuarioEMAIL: TStringField;
    qryCadastraUsuarioCELULAR: TStringField;
    qryCadastraUsuarioCEP: TStringField;
    qryCadastraUsuarioENDERECO: TStringField;
    qryCadastraUsuarioNUMERO: TStringField;
    qryCadastraUsuarioCOMPLEMENTO: TStringField;
    qryCadastraUsuarioCIDADE: TStringField;
    qryCadastraUsuarioUF: TStringField;
    qryCadastraUsuarioBAIRRO: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
    function CadastraUsuario(Ajson: TJSONObject): TJSONObject;
    function ValidaLogin(Ajson: TJSONObject): TJSONObject;
  end;

var
  dmUsuario: TdmUsuario;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

{ TdmUsuario }

function TdmUsuario.CadastraUsuario(Ajson: TJSONObject): TJSONObject;
var
  LUsuario: TUsuario;
  LSalt, LHash: string;
begin
  Result := nil;

  qryAux.Close;
  qryAux.SQL.Text := 'select email from user where email = :email';
  qryAux.ParamByName('email').AsString := Ajson.GetValue<string>('email');
  qryAux.Open;

  if qryAux.RecordCount > 0 then
  begin
    Result := TJSONObject.Create;

    Result.AddPair('message', 'Email já cadastrado.');

    exit;
  end;

  try
    if not FDConnection1.InTransaction then
      FDConnection1.StartTransaction;

    try
      qryCadastraUsuario.Open;
      qryCadastraUsuario.Append;

      try

        qryCadastraUsuarioNOME.AsString := Ajson.GetValue<string>('nome');
        qryCadastraUsuarioEMAIL.AsString := Ajson.GetValue<string>('email');

        LUsuario := TUsuario.create;
        LUsuario.Criptografia(Ajson.GetValue<string>('senha').Trim, LHash, LSalt);

        qryCadastraUsuarioSENHA.AsString := LHash;
        qryCadastraUsuarioSALT.AsString := LSalt;

        qryCadastraUsuarioCELULAR.AsString := Ajson.GetValue<string>('celular');
        qryCadastraUsuarioCEP.AsString := Ajson.GetValue<string>('cep');
        qryCadastraUsuarioENDERECO.AsString := Ajson.GetValue<string>('endereco');
        qryCadastraUsuarioNUMERO.AsString := Ajson.GetValue<string>('numero');
        qryCadastraUsuarioCOMPLEMENTO.AsString := Ajson.GetValue<string>('complemento');
        qryCadastraUsuarioCIDADE.AsString := Ajson.GetValue<string>('cidade');
        qryCadastraUsuarioBAIRRO.AsString := Ajson.GetValue<string>('bairro');
        qryCadastraUsuarioUF.AsString := Ajson.GetValue<string>('uf');

        qryCadastraUsuario.Post;

        Result := qryCadastraUsuario.ToJSONObject;

        FDConnection1.Commit;

      except
        if qryCadastraUsuario.State in [dsInsert, dsEdit] then
          qryCadastraUsuario.Cancel;
        raise;
      end;

    except
      if FDConnection1.InTransaction then
        FDConnection1.Rollback;

      raise;
    end;

  except
    on E: Exception do
    begin
      FreeAndNil(result);
      raise Exception.CreateFmt('Erro ao cadastrar usuario: %s', [E.Message]);
    end;
  end;
end;

function TdmUsuario.ValidaLogin(Ajson: TJSONObject): TJSONObject;
var
  LUsuario: TUsuario;
begin
  LUsuario := TUsuario.Create;

  result := LUsuario.ValidarLogin(Ajson.GetValue<string>('login').Trim,
                                  Ajson.GetValue<string>('senha').Trim, FDConnection1);
end;

end.
