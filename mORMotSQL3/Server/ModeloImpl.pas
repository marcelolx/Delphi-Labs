unit ModeloImpl;

interface

uses
  Modelo,
  mORMot;

type
  TModelo = class(TInterfacedObject, IModelo)
  public
    function Ref: IModelo;

    function CriarModelo: TSQLModel;
  end;

implementation

uses
  Pessoa;

{ TModelo }

function TModelo.CriarModelo: TSQLModel;
begin
  Result := TSQLModel.Create([TSQLPessoa]);
end;



function TModelo.Ref: IModelo;
begin
  Result := Self;
end;

end.
