/*
* Use LU decomposition and back-substitution to invert matrices.
* A Hilbert matrix of size 5 serves as an example. Hilbert matrices
* are ill-conditioned and are notoriously difficult to invert accurately.
* This program computes the Hilbert matrix, inverts it, multiples the
* Hilbert matrix by its inverse (resulting in an approximation of the
* identity matrix), and then inverts the inverse (resulting in an
* approximation of the original Hilbert matrix.
*/



//===============Global Variables===============//
//Could be defined in functions, but declared here to mirror original
int MAX = 5;

int ps[MAX];
float H[MAX][MAX];
float Hinv[MAX][MAX];
float Z[MAX][MAX];
int i, j, n;


//===============Function Declarations===============//
void singular(int why);
float abs(float x);
void decompose(int n, float[][] A, float[][] LU);
void solve(int n, float[][] LU, float[] b, float[] x);
void invert(int n, float[][] A, float[][] Ainv);
void multiply(int n, float[][] A, float[][] B, float[][] P);
void printMatrix(float[][] M);



//===============Main Program===============//

void main(void){
	n = 5;

    //Compute the Hilbert matrix.
	for(i=0;i<n;i++){
		for(j=0;j<n;j++){
			H[i][j] = 1.0 / (i+1 + j+1 - 1);
		}
	}

    println("Hilbert matrix:");
    printMatrix(H);

    //Invert the Hilbert matrix.
    invert(n, H, Hinv);

	println();
    println("Hilbert matrix inverted:");
    printMatrix(Hinv);

    //Multiply the Hilbert matrix by its inverse.
    multiply(n, H, Hinv, Z);

	println();
    println("Hilbert matrix multiplied by its inverse:");
    printMatrix(Z);

    //Invert the inverse.
    invert(n, Hinv, H);

	println();
    println("Inverse matrix inverted:");
    printMatrix(H);
}



//===============Function Definitions===============//
/**
* Error messages
*/
void singular(int why){
	switch(why){
		case 0:{
			//SINGULARMATRIX
			println("Singular matrix in decompose");
			return;
		}
		case 1:{
			//ZEROROW
			println("Matrix with zero row in decompose");
			return;
		}
		case 2:{
			//NOCONVERGENCE
			println("No convergence in improve");
			return;
		}
	}
}

/**
* Gets the absolute value of a number
*/
float abs(float x){
	if(x < 0){
		return -1 * x;
	}
	else{
		return x;
	}
}

/**
* Computes triangular matrices L and U and permutation matrix P
* so that LU = PA.  Stores L-I and U in LU.  Vector ps contains
* permuted row indices.  Note that A and LU are often passed the
* same matrix
*/
void decompose(int n, float[][] A, float[][] LU){
	float scales[MAX];
	int i, j, k, pivotindex;
	float normrow, pivot, size, biggest, mult;

	//Initialize ps, LU, and scales
	for(i=0;i<n;i++){
		ps[i] = i;
		normrow = 0;

		for(j=0;j<n;j++){
			LU[i][j] = A[i][j];

			//Find the largest row element
			if(normrow < abs(LU[i][j])){
				normrow = abs(LU[i][j]);
			}
		}

		//Set sclaing factor for row equilibration
		if(normrow != 0){
			scales[i] = 1 / normrow;
		}
		else{
			scales[i] = 0;
			singular(1);
		}
	}

	//Gaussian elimination with partial pivoting
	for(k=0;k<n-1;k++){
		pivotindex = 0;
		biggest = 0;

		//Go down rows from row k
		for(i=k;i<n;i++){
			//Divide by the largest row element
			size = abs(LU[ps[i]][k]) * scales[ps[i]];

			if(biggest < size){
				biggest = size; //biggest scales column element
				pivotindex = i; //row index of this element
			}
		}

		if(biggest == 0){
			singular(0);
		}
		else{
			if(pivotindex != k){
				//Exchange rows
				j = ps[k];
				ps[k] = ps[pivotindex];
				ps[pivotindex] = j;
			}

			pivot = LU[ps[k]][k]; //Pivot element

			//Go down rest of rows
			for(i=k+1;i<n;i++){
				mult = LU[ps[i]][k] / pivot;
				LU[ps[i]][k] = mult;

				if(mult != 0){

					//Inner loop, only columns subscript varries
					//FIXME: Check this
					for(j=k+1;j<n;j++){
						LU[ps[i]][j] = LU[ps[i]][j] - (mult * LU[ps[k]][j]);
					}
				}
			}
		}
	}

	//Check bottom right element of permuted matrix
	if(LU[ps[n-1]][n-1] == 0){
		singular(0);
	}
}

/**
*Solves Ax = b using LU from decompose
*/
void solve(int n, float[][] LU, float[] b, float[] x){
	int i, j;
	float dot;

	//Ly = b : solve for y
	for(i=0;i<n;i++){
		dot = 0;
		for(j=0;j<i;j++){
			dot = dot + (LU[ps[i]][j] * x[j]);
		}
		x[i] = b[ps[i]] - dot;
	}

	//Ux = y : solve for x
	for(i=n-1;i>=0;i--){
		dot = 0;
		for(j=i+1;j<n;j++){
			dot = dot + (LU[ps[i]][j] * x[j]);
		}
		x[i] = (x[i] - dot) / LU[ps[i]][i];
	}
}

/**
* Compute Ainv = inverse(A).  Note that A and Ainv are often
* passed the same matrix
*/
void invert(int n, float[][] A, float[][] Ainv){
	float LU[MAX][MAX];
	float b[MAX];
	float x[MAX];
	int i, j;

	decompose(n, A, LU);

	for(j=0;j<n;j++){
		for(i=0;i<n;i++){
			if(i == j){
				b[i] = 1;
			}
			else{
				b[i] = 0;
			}
		}

		solve(n, LU, b, x);

		for(i=0;i<n;i++){
			Ainv[i][j] = x[i];
		}
	}
}

/**
* Compute P = A x B
*/
void multiply(int n, float[][] A, float[][] B, float[][] P){
	int i, j, k;
	float sum;

	for(i=0;i<n;i++){
		for(j=0;j<n;j++){
			sum = 0.0;

			for(k=0;k<n;k++){
				sum = sum + (A[i][k] * B[k][j]);
			}

			P[i][j] = sum;
		}
	}
}

/**
* Print a matrix
*/
void printMatrix(float[][] M){
	for(int i=0;i<n;i++){
		print("[");
		for(int j=0;j<n;j++){
			print(M[i][j]:11:3);
			if(j < n-1){
				print(", ");
			}
		}
		println("]");
	}
}
