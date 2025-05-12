def calcular_ir(dias, valor):
    if dias <= 180:
        aliquota = 0.225
    elif 181 <= dias <= 360:
        aliquota = 0.20
    elif 361 <= dias <= 720:
        aliquota = 0.175
    else:
        aliquota = 0.15
    return valor * aliquota

def main():
    print("Sistema de Cálculo de Imposto de Renda sobre Resgates")
    print("Tipos de investimento:")
    print("1 - CDB (Tributado)")
    print("2 - LCI (Isento)")
    print("3 - LCA (Isento)")

    while True:
        try:
            tipo = int(input("\nDigite o tipo de investimento (1-3): "))
            if tipo in [1, 2, 3]:
                break
            else:
                print("Tipo inválido! Digite 1, 2 ou 3.")
        except ValueError:
            print("Entrada inválida! Digite um número.")

    while True:
        try:
            valor = float(input("Digite o valor a ser resgatado: R$ "))
            if valor > 0:
                break
            else:
                print("O valor deve ser positivo!")
        except ValueError:
            print("Valor inválido! Digite um número.")

    while True:
        try:
            dias = int(input("Digite o número de dias aplicados: "))
            if dias > 0:
                break
            else:
                print("O número de dias deve ser positivo!")
        except ValueError:
            print("Valor inválido! Digite um número inteiro.")

    if tipo == 1:  
        imposto = calcular_ir(dias, valor)
        valor_liquido = valor - imposto
        print("\nResultado do resgate:")
        print(f"Valor bruto resgatado: R$ {valor:.2f}")
        print(f"Dias aplicados: {dias}")
        print(f"Alíquota de IR aplicada: {calcular_ir(dias, 100):.1f}%")
        print(f"Imposto de Renda: R$ {imposto:.2f}")
        print(f"Valor líquido a receber: R$ {valor_liquido:.2f}")
    else:  
        print("\nResultado do resgate:")
        print(f"Valor resgatado: R$ {valor:.2f}")
        print(f"Dias aplicados: {dias}")
        print("Investimento isento de Imposto de Renda")
        print(f"Valor líquido a receber: R$ {valor:.2f}")

if __name__ == "__main__":
    main()
input()