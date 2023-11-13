// Disciplina: Arquitetura e Organização de Computadores
// Atividade: Avaliação 03 – Programação de Procedimentos
// Grupo: - Cauã Ribas
//	    - Nilson Andrade
//	    - Haran Souza
// 

#include <iostream>

using namespace std;

int vet_soma(int vet[], int pos) { 
    int soma=0;
    for (int i=0; i<pos; i++) {
        soma = soma + vet[i];
    }
    return soma;
} 

int main() {

    int tam;
    int vet[tam];

    do{
        cout << "\nInforme o tamanho do vetor (2-100): ";
        cin >> tam;
    }while(tam < 2 || tam > 100);

    for(int i = 0; i < tam; i++)
        vet[i] = i;

    cout << "\nResultado da soma dos elementos do vetor: " << vet_soma(vet, tam);

    return 0;
}