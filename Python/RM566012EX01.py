def main():
    print("Bem-vindo à votação para escolha do dia da live da Bidu!")
    print("Por favor, informe qual dia da semana é o melhor para a realização das lives:")
    print("Opções: segunda feira, terça feira, quarta feira, quinta feira, sexta feira\n")
    
    dias_validos = ["segunda feira", "terça feira", "quarta feira", "quinta feira", "sexta feira"]
    votos = {dia: 0 for dia in dias_validos}
    
    while True:
        try:
            num_colaboradores = int(input("Quantos colaboradores irão participar da votação? "))
            if num_colaboradores <= 0:
                print("Por favor, insira um número positivo de colaboradores.")
                continue
            break
        except ValueError:
            print("Por favor, insira um número válido.")
    
    for i in range(1, num_colaboradores + 1):
        while True:
            voto = input(f"Colaborador {i}, qual seu dia preferido? ").strip().lower()
            if voto in dias_validos:
                votos[voto] += 1
                break
            else:
                print("Dia inválido. Por favor, escolha entre: segunda-feira, terça-feira, quarta-feira, quinta-feira ou sexta-feira.")
    
    max_votos = max(votos.values())
    dias_vencedores = [dia for dia, votos in votos.items() if votos == max_votos]
    
    print("\nResultado da votação:")
    for dia in dias_validos:
        print(f"{dia.capitalize()}: {votos[dia]} voto(s)")
    
    if len(dias_vencedores) > 1:
        print("\nHouve um empate entre os seguintes dias:")
        for dia in dias_vencedores:
            print(f"- {dia.capitalize()}")
        print("Será necessária uma nova votação para desempatar.")
    else:
        print(f"\nO dia escolhido para a live é: {dias_vencedores[0].capitalize()} com {max_votos} voto(s)!")
if __name__ == "__main__":  
    main()
input()