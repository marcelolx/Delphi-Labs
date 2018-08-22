unit Server;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  mORMot, SynLog, mORMotSQLite3, mORMotHttpServer, SynSQLite3Static, Vcl.StdCtrls;

type
  TFrmServer = class(TForm)
    btnStart: TButton;
    procedure btnStartClick(Sender: TObject);
  strict private
    fModeloDados: TSQLModel;
    fBaseDados: TSQLRestServerDB;
    fServidorHttp: TSQLHttpServer;

    procedure ConfigurarLog;
    procedure InicializarBancoDeDados;
    procedure InicializarServidorHttp;
  public
    { Public declarations }
  end;

var
  FrmServer: TFrmServer;

implementation

uses
  ModeloImpl;

{$R *.dfm}

{ TFrmServer }

procedure TFrmServer.btnStartClick(Sender: TObject);
begin
  ConfigurarLog;
  InicializarBancoDeDados;
  InicializarServidorHttp;
end;

procedure TFrmServer.ConfigurarLog;
begin
  TSQLLog.Family.Level := LOG_VERBOSE;
end;



procedure TFrmServer.InicializarBancoDeDados;
begin
  fModeloDados := TModelo.Create.Ref.CriarModelo;
  fBaseDados   := TSQLRestServerDB.Create(fModeloDados, 'basedadossql3.db3');
  fBaseDados.CreateMissingTables;
end;



procedure TFrmServer.InicializarServidorHttp;
begin
  fServidorHttp := TSQLHttpServer.Create('8080', [fBaseDados], 'localhost');
end;

end.
