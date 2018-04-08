Exemplos de como injetar dependências para uma regra utilizando interface de maneira correta e incorreta.


Ao criar a regra passando a por parâmetro, como o exemplo abaixo.

```pascal
procedure ExecutaExemplo_2_incorreto;
begin
    ExecutarAcao2(TRgnExemplo.Create);
end;
```

Sendo a procedure ExecutarAcao2 definida desta maneira: 
```pascal
procedure ExecutarAcao2(const AIRgnExemplo: IRgnExemplo);
begin
  AIRgnExemplo.ExecutarAcao;
end;
```

Causa vazamentos de memória, pois os métodos _AddRef e _Release não são chamados. 

Para garantir que o vazamento não ocorra, podemos resolver isso de uma maneira simples:

```pascal
procedure ExecutaExemplo_2_incorreto_ok;
begin
  ExecutarAcao2(TRgnExemplo.Create as IRgnExemplo);
end;
```

Pois ao incluirmos o 

```pascal 
    as IRgnExemplo
```

fazemos com que o _AddRef e _Release sejam chamados, mesmo o parâmetro sendo uma constante.