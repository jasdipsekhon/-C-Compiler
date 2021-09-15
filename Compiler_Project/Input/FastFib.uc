int fib(int index);
void printList(int[] list,int len);

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

//Iterative Fibbonachi function
int fib(int index){
	int arrLen = (index<=1)?2:index+1;
	int arr[arrLen];
	arr[0] = 0;
	arr[1] = 1;
	for(int i=2;i<=index;i++){
		arr[i] = arr[i-2] + arr[i-1];
	}
	print("Fib array: "); // <- For visualization/demonstration purposes
	printList(arr,arrLen);
	return arr[index];
}

//Print 2-dimentional matrix
void printList(int[] list,int len){
    print("[");
    for(int k=0;k<len;k++){
        print(list[k]);
        if(k < len-1){
            print(",");
        }
    }
    println("]");
    return;
}
