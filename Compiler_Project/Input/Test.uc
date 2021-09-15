//Test seperate declaration and definition
void printList(int[] list,int len);
void printMatrix(int[][] matrix,int dim1, int dim2);


void main(void){
    //Test for array access
    int arr[10];
    arr[0] = 5;
    for(int k=0;k<10;k++){
        arr[k] = k*2;
    }
    printList(arr,10);

    //Test multi-dimention arrays and paramater passing
    println();
    int arr2[10][10];
    for(int a=0;a<10;a++){
        for(int b=0;b<10;b++){
            arr2[a][b] =  (a*10) + (b);
        }
    }
    printMatrix(arr2,10,10);
}


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

void printMatrix(int[][] matrix,int dim1,int dim2){
    for(int i=0;i<dim1;i++){
        print("[");
        for(int j=0;j<dim2;j++){
            print(matrix[i][j]:2);
            if(j < dim2-1){
                print(",");
            }
        }
        println("]");
    }
}
