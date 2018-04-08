unit Rgn.Exemplo;

interface

uses
  I.Rgn.Exemplo;

type
  TRgnExemplo = class(TInterfacedObject, IRgnExemplo)
  private
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
  public
    class function New: IRgnExemplo;
    procedure ExecutarAcao;
    destructor Destroy; override;
  end;

implementation

uses
  System.SysUtils;

{ TRgnExemplo }

destructor TRgnExemplo.Destroy;
begin
  Writeln('RefCount: ' + FRefCount.ToString);
  Writeln('Destruindo instancia...');
  inherited;
end;

procedure TRgnExemplo.ExecutarAcao;
begin
  Writeln('Executando ação');
end;

class function TRgnExemplo.New: IRgnExemplo;
begin
  Result := Create;
end;

function TRgnExemplo._AddRef: Integer;
begin
  Result := inherited;
  Writeln('_AddRef disparado');
  Writeln('RefCount: ' + FRefCount.ToString);
end;

function TRgnExemplo._Release: Integer;
begin
  Writeln('_Release disparado');
  Result := inherited;
end;

end.
