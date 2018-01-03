unit Rgn.Notification.Service;

interface

uses
  Classes,
  Generics.Collections;

type
  TRgnNotificationService = class
  private
    oDicionarioInscritos: TDictionary<TNotifyEvent, TGUID>;
  public
    constructor Create;
    destructor Destroy; override;
    procedure SendMessage(ASender: TObject; AMessageID: TGUID);
    procedure Subscribe(AEvent: TNotifyEvent; AMessageID: TGUID);
    procedure UnSubscribe(AEvent: TNotifyEvent);
  end;

function GetNotificationService: TRgnNotificationService;

implementation

uses
  System.SysUtils;



var
  oInstance: TRgnNotificationService;



function GetNotificationService: TRgnNotificationService;
begin
  if oInstance = nil then
    oInstance := TRgnNotificationService.Create;
  Result := oInstance;
end;



constructor TRgnNotificationService.Create;
begin
  oDicionarioInscritos := TDictionary<TNotifyEvent, TGUID>.Create;
end;



destructor TRgnNotificationService.Destroy;
begin
  FreeAndNil(oDicionarioInscritos);
  inherited;
end;



procedure TRgnNotificationService.SendMessage(ASender: TObject; AMessageID: TGUID);
var
  oPair: TPair<TNotifyEvent, TGUID>;
begin
  for oPair in oDicionarioInscritos do
  begin
    if (oPair.Value = AMessageID) then
      oPair.Key(ASender);
  end;
end;



procedure TRgnNotificationService.Subscribe(AEvent: TNotifyEvent; AMessageID: TGUID);
begin
  oDicionarioInscritos.AddOrSetValue(AEvent, AMessageID);
end;



procedure TRgnNotificationService.UnSubscribe(AEvent: TNotifyEvent);
begin
  oDicionarioInscritos.Remove(AEvent);
end;



initialization



finalization

oInstance.Free;

end.
