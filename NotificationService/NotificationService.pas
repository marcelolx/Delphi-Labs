unit NotificationService;

interface

uses
  Generics.Collections;

type
  TNotifyKeyValueEvent = procedure(const AKey: Variant; var AValue: TObject) of object;

  INotificationService = interface
  ['{6D22D05D-8426-42E5-ABC5-49A7C7133846}']
    procedure SendMessage(const AKey: Variant; var AValue: TObject; const AMessageID: TGUID);
    procedure Subscribe(const AEvent: TNotifyKeyValueEvent; const AMessageID: TGUID);
    procedure UnSubscribe(const AEvent: TNotifyKeyValueEvent);
  end;

  TNotificationService = class(TInterfacedObject, INotificationService)
  strict private
    fDicionarioInscritos: TDictionary<TNotifyKeyValueEvent, TGUID>;
  protected
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
  public
    constructor Create;
    destructor Destroy; override;
    procedure SendMessage(const AKey: Variant; var AValue: TObject; const AMessageID: TGUID);
    procedure Subscribe(const AEvent: TNotifyKeyValueEvent; const AMessageID: TGUID);
    procedure UnSubscribe(const AEvent: TNotifyKeyValueEvent);
  end;

function GetNotificationService: INotificationService;

implementation

uses
  System.SysUtils;

var
  fInstance: TNotificationService;


function GetNotificationService: INotificationService;
begin
  if fInstance = nil then
    fInstance := TNotificationService.Create;

  Result := fInstance;
end;



constructor TNotificationService.Create;
begin
  fDicionarioInscritos := TDictionary<TNotifyKeyValueEvent, TGUID>.Create;
end;



destructor TNotificationService.Destroy;
begin
  fDicionarioInscritos.Free;
  inherited;
end;



function TNotificationService.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
end;



procedure TNotificationService.SendMessage(const AKey: Variant; var AValue: TObject; const AMessageID: TGUID);
var
  fPair: TPair<TNotifyKeyValueEvent, TGUID>;
begin
  for fPair in fDicionarioInscritos do
  begin
    if (fPair.Value = AMessageID) then
      fPair.Key(AKey, AValue);
  end;
end;



procedure TNotificationService.Subscribe(const AEvent: TNotifyKeyValueEvent; const AMessageID: TGUID);
begin
  fDicionarioInscritos.AddOrSetValue(AEvent, AMessageID);
end;



procedure TNotificationService.UnSubscribe(const AEvent: TNotifyKeyValueEvent);
begin
  fDicionarioInscritos.Remove(AEvent);
end;



function TNotificationService._AddRef: Integer;
begin
  Result := 0;
end;



function TNotificationService._Release: Integer;
begin
  Result := 0;
end;

initialization

finalization

fInstance.Free;

end.
