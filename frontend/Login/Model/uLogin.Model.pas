unit uLogin.Model;

interface

type
  TLoginModel = class
  private
    FUsername: string;
    FSenha: string;

  public
    property Username: string read FUsername write FUsername;
    property Senha: string read FSenha write FSenha;
  end;

 TUserLogado = class
   private
    FLogado: Boolean;

   public
     property Logado: Boolean read FLogado write FLogado;
 end;

implementation

end.
