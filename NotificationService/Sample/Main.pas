unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Cliente, System.Generics.Collections;

type
  TForm1 = class(TForm)
    btnExemplo: TButton;
    procedure btnExemploClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  strict private
    fClienteInexistente: TCliente;
    fCacheClientes: TObjectDictionary<Variant, TCliente>;

    procedure AddCacheClientes(const AKey: Variant; var AValue: TObject);
    procedure GetCacheClientes(const AKey: Variant; var AValue: TObject);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  NotificationService, NotificationService.Ids, Documento;

{$R *.dfm}

procedure TForm1.AddCacheClientes(const AKey: Variant; var AValue: TObject);
var
  fCliente: TCliente;
begin
  if (not(fCacheClientes.ContainsKey(AKey))) then
  begin
    fCliente := TCliente.Create;
    TCliente(AValue).CopiarPara(fCliente);
    fCacheClientes.Add(AKey, fCliente);
  end;
end;

procedure TForm1.btnExemploClick(Sender: TObject);
var
  fDocumento: TDocumento;
  fCliente: TCliente;
  fDocumentos: TObjectList<TDocumento>;
  fIndex: Integer;
begin
  fDocumentos := TObjectList<TDocumento>.Create;
  fCliente := TCliente.Create;

  try
    for fIndex := 0 to 10000000 do
    begin
      fDocumento := TDocumento.Create(AddCacheClienteProgramaExemplo, GetCacheClienteProgramaExemplo);

      fCliente.Codigo := 1;
      fCliente.Nome := 'Marcelo';

      fDocumento.Codigo := fIndex;
      fDocumento.Valor := 2 * fIndex;
      fDocumento.Cliente := fCliente;
      fDocumentos.Add(fDocumento);
    end;
  finally
    fCliente.Free;
    fDocumentos.Free;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  fClienteInexistente := TCliente.Create;
  fCacheClientes := TObjectDictionary<Variant, TCliente>.Create([doOwnsValues]);
  GetNotificationService.Subscribe(AddCacheClientes, AddCacheClienteProgramaExemplo);
  GetNotificationService.Subscribe(GetCacheClientes, GetCacheClienteProgramaExemplo);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  GetNotificationService.UnSubscribe(AddCacheClientes);
  GetNotificationService.UnSubscribe(GetCacheClientes);
  fClienteInexistente.Free;
  fCacheClientes.Free;
end;

procedure TForm1.GetCacheClientes(const AKey: Variant; var AValue: TObject);
begin
  fCacheClientes.TryGetValue(AKey, TCliente(AValue));

  if (AValue = nil) then
    AValue := TObject(fClienteInexistente);
end;

end.
