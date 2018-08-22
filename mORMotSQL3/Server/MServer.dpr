program MServer;

uses
  Vcl.Forms,
  Server in 'Server.pas' {FrmServer},
  Pessoa in 'Pessoa.pas',
  Modelo in 'Modelo.pas',
  ModeloImpl in 'ModeloImpl.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmServer, FrmServer);
  Application.Run;
end.
