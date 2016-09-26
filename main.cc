#include <stdio.h>
#include <stdlib.h>

int s1,s2,s3;
unsigned t[448];


char buf1[1025];
char buf2[1025];
char tablica[100];
int tablica2[2000];
int tablica3[400];


void read_init();
void read_rotors();
int read(FILE *file);

struct ustawienia
{
	int *bufor2;
	int *bufor3;
	int t4;
	int t5;
	int t6;
};

extern "C"void kodowanie(char *buf1, char *buf2, ustawienia *ust);

int main()
{
  FILE *plain, *cipher;
  read_init();
  read_rotors();

struct ustawienia ust;


ust.bufor2 = tablica2;
ust.bufor3 = tablica3;
ust.t4 = s1;
ust.t5 = s2;
ust.t6 = s3;


 if(!(plain=fopen("plaintext.txt","rt")))
  {
    printf("Blad przy otwieraniu pliku plaintext.txt\n");
    exit(0);
  }
  if(!(cipher=fopen("ciphertext.txt","w+"))){
    printf("Blad przy otwieraniu pliku ciphertext.txt\n");
    exit(0);
    }
 int i = 0;
//kogda konec,to nuzhno ostanowit
do{
    fgets(buf1,1024,plain);

	kodowanie(buf1,buf2,&ust);
    fputs(buf2,cipher);
}while(buf1[0] != 13);


  fclose(plain);
  fclose(cipher);

}

void read_init()
{
  FILE *init;
  init = fopen("init.txt","rt");
  if(!init)
  {
    printf("Blad przy otwieraniu init.txt\n");
    exit(0);
  }
  else
  {
    s1=read(init);
   // printf("s1 = %d",s1);
    s2=read(init);
   // printf("s2 = %d",s2);
    s3=read(init);

   // printf("s3 = %d",s3);
    fclose(init);
  }
}

void read_rotors()
{
  FILE *rotors;
  rotors = fopen("rotors.txt","rt");
  if(!rotors)
  {
    printf("Blad przy otwieraniu rotors.txt\n");
    exit(0);
  }
  else{

  int i = 0;
  int count = 0;
  int count1 = 0;
  while( i < 189 ){
        int a, b; //zmienne pomocnicze


        fgets(tablica, 100, rotors);
        a = tablica[0];
        if ( a > 57 || a < 48){
        i++;
        continue;
        }
        else{

        b = (tablica[3] - 48) * 10;
        b += (tablica[4]- 48);

       if ( i < 108){
        tablica2[count] = b;
        // printf("a = %d \n", tablica2[count]);
        count++;
        }
        else {

        tablica3[count1] = b;
        //printf("b = %d \n", tablica3[count1]);
        count1++;
        }

        i++;
        }


}

  }


  fclose(rotors);
}

int read(FILE *file)
{
  if(!file)
  {
    printf("Blad w trakcie czytania pliku\n");
    exit(0);
  }
  else
  {
    char c;
    int ret=0;
    c=getc(file);

    if ( c == '\n'){
    c=getc(file);
    }
    ret+=(c-'0')*10;
    c=getc(file);
    ret+=c-'0';
    c=getc(file);
    return ret;
  }
}
