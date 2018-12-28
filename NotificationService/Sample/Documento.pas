unit Documento;

interface

uses
  Cliente;

type
  TDocumento = class
  strict private
    fCodigo: Integer;
    fValor: Currency;
    fCodigoCliente: Integer;

    fAddClienteCacherID, fGetClienteCacherID: TGUID;

    function GetCliente: TCliente;
    procedure SetCliente(const ACliente: TCliente);
  public
    property Codigo: Integer read fCodigo write fCodigo;
    property Valor: Currency read fValor write fValor;
    property Cliente: TCliente read GetCliente write SetCliente;

    constructor Create(const AAddClienteCacherID, AGetClienteCacherID: TGUID); reintroduce;
  end;

implementation

uses
  NotificationService;

{ TDocumento }

constructor TDocumento.Create(const AAddClienteCacherID, AGetClienteCacherID: TGUID);
begin
  fAddClienteCacherID := AAddClienteCacherID;
  fGetClienteCacherID := AGetClienteCacherID;
end;

function TDocumento.GetCliente: TCliente;
begin
  GetNotificationService.SendMessage(fCodigoCliente, TObject(Result), fGetClienteCacherID);
end;

procedure TDocumento.SetCliente(const ACliente: TCliente);
var
  fCliente: TCliente;
begin
  fCliente := ACliente;
  fCodigoCliente := ACliente.Codigo;
  GetNotificationService.SendMessage(ACliente.Codigo, TObject(fCliente), fAddClienteCacherID);
end;

end.
