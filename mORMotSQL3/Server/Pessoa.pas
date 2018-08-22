unit Pessoa;

interface

uses
  mORMot, SynCommons;

type
  TSQLPessoa = class(TSQLRecord)
  private
    fIdade: Integer;
    fNome: RawUTF8;
  published
    property Idade: Integer read fIdade write fIdade;
    property Nome: RawUTF8 read fNome write fNome;
  end;

implementation

end.
