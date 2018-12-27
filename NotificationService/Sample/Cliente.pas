unit Cliente;

interface

type
  TCliente = class
  strict private
    fCodigo: Integer;
    fNome: String;
  public
    property Codigo: Integer read fCodigo write fCodigo;
    property Nome: String read fNome write fNome;

    procedure CopiarPara(const ACliente: TCliente);
  end;

implementation

{ TCliente }

procedure TCliente.CopiarPara(const ACliente: TCliente);
begin
  ACliente.Codigo := fCodigo;
  ACliente.Nome := fNome;
end;

end.
