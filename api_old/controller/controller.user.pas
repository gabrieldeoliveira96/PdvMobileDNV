unit controller.user;

interface

uses Horse, model.user, System.SysUtils, System.JSON;

procedure Registry;

procedure Getuser(Req: THorseRequest; Res: THorseResponse);
procedure Postuser(Req: THorseRequest; Res: THorseResponse);


implementation

procedure Getuser(Req: THorseRequest; Res: THorseResponse);
var
 LModelUser:TmodelUser;
begin
  try
    LModelUser:= TmodelUser.Create(nil);
    try
      if req.Params.Count = 1 then
        res.Send(LModelUser.GetUser(req.Params.Items['id'].ToInteger))
      else
        res.Send(LModelUser.GetAllUser);
      res.Status(200);
    finally
      FreeAndNil(LModelUser);
    end;
  except
    res.Status(400);
  end;

end;

procedure Postuser(Req: THorseRequest; Res: THorseResponse);
var
 LModelUser:TmodelUser;
 LJsonBody:TJSONObject;
begin
  try
    LModelUser:= TmodelUser.Create(nil);
    try

      LJsonBody:= req.Body<TJSONObject>;

      res.Send(LModelUser.PostUser(LJsonBody));

      res.Status(200);
    finally
      FreeAndNil(LModelUser);
    end;
  except
    res.Status(400);
  end;


end;

procedure Registry;
begin

  THorse.Get('/user',Getuser);
  THorse.Get('/user/:id',Getuser);
  THorse.Post('/user',Postuser);

end;


end.
