program InterfaceExample;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Classes,
  I.Rgn.Exemplo in 'I.Rgn.Exemplo.pas',
  Rgn.Exemplo in 'Rgn.Exemplo.pas';

procedure ExecutarAcao1(AIRgnExemplo: IRgnExemplo);
begin
  AIRgnExemplo.ExecutarAcao;
end;

procedure ExecutarAcao2(const AIRgnExemplo: IRgnExemplo);
begin
  AIRgnExemplo.ExecutarAcao;
end;

//------ Correto ----------

procedure ExecutaExemplo_1;
var
  oIRgnExemplo: IRgnExemplo;
begin
  oIRgnExemplo := TRgnExemplo.Create;
  ExecutarAcao1(oIRgnExemplo);
end;


procedure ExecutaExemplo_1_ok;
begin
  ExecutarAcao1(TRgnExemplo.Create);
end;

procedure ExecutaExemplo_2_incorreto_ok;
begin
  ExecutarAcao2(TRgnExemplo.Create as IRgnExemplo);
end;

procedure ExecutaExemplo_2;
var
  oIRgnExemplo: IRgnExemplo;
begin
  oIRgnExemplo := TRgnExemplo.Create;
  ExecutarAcao2(oIRgnExemplo);
end;

procedure ExecutaExemplo_2_incorreto_ok_2;
begin
  ExecutarAcao2(TRgnExemplo.New);
end;

//----------- Errado --------- //

procedure ExecutaExemplo_2_incorreto;
begin
  ExecutarAcao2(TRgnExemplo.Create);
end;


begin
  ReportMemoryLeaksOnShutdown := True;
  try
    Writeln('-------- Exemplo_1 -----------');
    ExecutaExemplo_1;
    Writeln('------------------------------');
    Readln;

    Writeln('-------- Exemplo_1_ok --------');
    ExecutaExemplo_1_ok;
    Writeln('------------------------------');
    Readln;

    Writeln('-------- Exemplo_2 -----------');
    ExecutaExemplo_2;
    Writeln('------------------------------');
    Readln;

    Writeln('-------- Exemplo_2_incorreto_ok -');
    ExecutaExemplo_2_incorreto_ok;
    Writeln('------------------------------');
    Readln;

    Writeln('-------- Exemplo_2_incorreto_ok_2');
    ExecutaExemplo_2_incorreto_ok_2;
    Writeln('------------------------------');
    Readln;

    Writeln('-------- Exemplo_2_Incorreto -');
    ExecutaExemplo_2_incorreto;
    Writeln('------------------------------');
    Readln;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
