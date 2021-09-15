int fib(int in);

void main(){
	int i;
	do{
		print("Enter Number:");
		read(i);
		if(i >= 0){
			int fib_n = fib(i);
			println("The ",i,(i==1)?"st":((i==2)?"nd":(i==3?"rd":"th")),
            " Fibbonachi number is: ",fib_n);
		}
		println();
	}while(i >= 0);
}

//Recursove Fibbonachi function
int fib(int in){
    if(in == 0){
        return 0;
    }
    else if(in == 1){
        return 1;
    }
    else{
        return fib(in-2) + fib(in-1);
    }
}
