//===============Function Declarations===============//
float root(float x);
void printRoot(int n, float root);



//===============Main Program===============//
void main(void){
	for(int number=0;number<=25;number++){
		printRoot(number,root(number));
	}
}



//===============Function Definitions===============//
/**
* Calculates the square root of a number
*/
float root(float x){
	float r, prev, diff;

	r = 1;
	prev = 0;

	do{
		r = (x/r + r)/2;
		diff = r - prev;
		if(diff < 0){
			diff = -diff;
		}
		prev = r;
	}while(diff >= 1.01e-10);
	return r;
}

/**
* Prints the value and it's root
*/
void printRoot(int n, float root){
	println("The square root of ", n:2, " is ", root:8:4);
}
