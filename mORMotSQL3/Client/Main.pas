unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, Vcl.ExtCtrls,
  mORMotHttpClient, Pessoa, mORMotUI, mORMotUILogin;

type
  TForm1 = class(TForm)
    BtnConectar: TButton;
    grpPessoa: TGroupBox;
    lblId: TLabel;
    EdtId: TEdit;
    btnBuscar: TButton;
    lblNome: TLabel;
    EdtNome: TEdit;
    lblIdade: TLabel;
    EdtIdade: TEdit;
    btnSalvar: TButton;
    btnDeletar: TButton;
    Pnl1: TPanel;
    btnIterar: TButton;
    MemPessoas: TMemo;
    PnlGrid: TPanel;
    GridPessoas: TDrawGrid;
    btnAtualizar: TButton;
    procedure BtnConectarClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnDeletarClick(Sender: TObject);
    procedure btnIterarClick(Sender: TObject);
    procedure btnAtualizarClick(Sender: TObject);
  strict private
    fBaseDados: TSQLHttpClient;
    fPessoas: TSQLPessoa;
    fGrid: TSQLTableToGrid;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  ModeloImpl;

{$R *.dfm}

procedure TForm1.btnAtualizarClick(Sender: TObject);
begin
  Grid.Refresh;
end;



procedure TForm1.btnBuscarClick(Sender: TObject);
var
  fPessoa: TSQLPessoa;
begin
  fPessoa := TSQLPessoa.Create;

  try
    if (fBaseDados.Retrieve(StrToIntDef(EdtId.Text, 0), fPessoa)) then
    begin
      EdtNome.Text  := fPessoa.Nome;
      EdtIdade.Text := IntToStr(fPessoa.Idade);
    end
    else
      ShowMessage('Pessoa não encontrada!');
  finally
    FreeAndNil(fPessoa);
  end;
end;



procedure TForm1.BtnConectarClick(Sender: TObject);

  procedure BuscarPessoas;
  begin
    fPessoas := TSQLPessoa.CreateAndFillPrepare(fBaseDados, 'ID > 0', '');
    fGrid    := TSQLTableToGrid.Create(GridPessoas, fPessoas.FillTable, fBaseDados);
  end;



begin
  fBaseDados := TSQLHttpClient.Create('localhost', '8080', TModelo.Create.Ref.CriarModelo);

  if fBaseDados.ServerTimestampSynchronize then
  begin
    PnlGrid.Enabled := True;
    grpPessoa.Enabled := True;
    BuscarPessoas;
  end
  else
    ShowLastClientError(fBaseDados, 'Servidor não encontrado');
end;



procedure TForm1.btnDeletarClick(Sender: TObject);
begin
  if (StrToIntDef(EdtId.Text, 0) > 0) then
  begin
    if (fBaseDados.Delete(TSQLPessoa, StrToInt(EdtId.Text))) then
    begin
      ShowMessage('Registro ' + EdtId.Text + ' deletado.');
      EdtId.Clear;
      EdtNome.Clear;
      EdtIdade.Clear;
    end;
  end
  else
    ShowMessage('Informe o ID.');

  fGrid.Refresh;
end;



procedure TForm1.btnIterarClick(Sender: TObject);
begin
   while fPessoas.FillOne do
   begin
    MemPessoas.Lines.Add('ID: '+ IntToStr(fPessoas.Id) +
       '; Nome: ' + fPessoas.Nome + '; Idade:' + IntToStr(fPessoas.Idade));
   end;
end;



procedure TForm1.btnSalvarClick(Sender: TObject);

  procedure AtualizarRegistro(const APessoa: TSQLPessoa);
  begin
    if fBaseDados.Update(APessoa) then
      ShowMessage('Registro atualizado.')
    else
      ShowMessage('O registro não foi salvo. Erro: ' + fBaseDados.LastErrorMessage);
  end;

  procedure NovoRegistro(const APessoa: TSQLPessoa);
  begin
    if fBaseDados.Add(APessoa, True) > 0 then
    begin
      ShowMessage('Salvo');
      if StrToIntDef(EdtId.Text, 0) = 0 then
        EdtId.Text := IntToStr(APessoa.ID);
    end
    else
      ShowMessage('O registro não foi salvo. Erro: ' + fBaseDados.LastErrorMessage);
  end;



var
  fPessoa: TSQLPessoa;
begin
  if StrToIntDef(EdtId.Text, 0) > 0 then
    fPessoa := TSQLPessoa.Create(fBaseDados, StrToInt(EdtId.Text))
  else
    fPessoa := TSQLPessoa.Create;

  try
    fPessoa.Nome  := EdtNome.Text;
    fPessoa.Idade := StrToInt(EdtIdade.Text);

    if fPessoa.ID > 0 then
      AtualizarRegistro(fPessoa)
    else
      NovoRegistro(fPessoa);
  finally
    FreeAndNil(fPessoa);
  end;
  fGrid.Refresh;
end;

end.
