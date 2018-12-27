program Sample;

uses
  Vcl.Forms,
  Main in 'Main.pas' {Form1},
  NotificationService in '..\NotificationService.pas',
  Documento in 'Documento.pas',
  Cliente in 'Cliente.pas',
  NotificationService.Ids in 'NotificationService.Ids.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
