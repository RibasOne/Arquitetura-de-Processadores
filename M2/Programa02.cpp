// Disciplina: Arquitetura e Organização de Computadores
// Atividade: Avaliação 03 – Programação de Procedimentos
// Grupo: - Cauã Ribas
//	    - Nilson Andrade
//	    - Haran Souza
// 

#include <iostream>

using namespace std;

int vet_soma_rec(int vet[], int pos) { 
    if(pos < 0){
        return 0;
    }
    return vet[pos] + vet_soma_rec (vet, pos - 1);
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

    cout << "\nResultado da soma dos elementos do vetor: " << vet_soma_rec(vet, tam);

    return 0;
}