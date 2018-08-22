program MClient;

uses
  Vcl.Forms,
  Main in 'Main.pas' {Form1},
  Pessoa in '..\Server\Pessoa.pas',
  Modelo in '..\Server\Modelo.pas',
  ModeloImpl in '..\Server\ModeloImpl.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
