.class public Hilbert
.super java/lang/Object

.field private static _sysin Ljava/util/Scanner;
.field private static H [[F
.field private static Hinv [[F
.field private static MAX I
.field private static Z [[F
.field private static i I
.field private static j I
.field private static n I
.field private static ps [I

;
; Runtime input scanner
;
.method static <clinit>()V

	new	java/util/Scanner
	dup
	getstatic	java/lang/System/in Ljava/io/InputStream;
	invokespecial	java/util/Scanner/<init>(Ljava/io/InputStream;)V
	putstatic	Hilbert/_sysin Ljava/util/Scanner;
	return

.limit locals 0
.limit stack 3
.end method

;
; Main class constructor
;
.method public <init>()V
.var 0 is this LHilbert;

	aload_0
	invokespecial	java/lang/Object/<init>()V
	return

.limit locals 1
.limit stack 1
.end method

;
; PROCEDURE main
;
.method private static main()V

;
; 038 n=5
;
	iconst_5
	putstatic	Hilbert/n I
;
; 041 i=0
;
	iconst_0
	putstatic	Hilbert/i I
L001:
	getstatic	Hilbert/i I
	getstatic	Hilbert/n I
	if_icmplt	L003
	iconst_0
	goto	L004
L003:
	iconst_1
L004:
	iconst_0
	if_icmpeq	L002
;
; 042 j=0
;
	iconst_0
	putstatic	Hilbert/j I
L005:
	getstatic	Hilbert/j I
	getstatic	Hilbert/n I
	if_icmplt	L007
	iconst_0
	goto	L008
L007:
	iconst_1
L008:
	iconst_0
	if_icmpeq	L006
;
; 043 H[i][j]=1.0/(i+1+j+1-1)
;
	getstatic	Hilbert/H [[F
	getstatic	Hilbert/i I
	aaload
	getstatic	Hilbert/j I
	fconst_1
	getstatic	Hilbert/i I
	iconst_1
	iadd
	getstatic	Hilbert/j I
	iadd
	iconst_1
	iadd
	iconst_1
	isub
	i2f
	fdiv
	fastore
;
; 042 j++
;
	getstatic	Hilbert/j I
	iconst_1
	iadd
	putstatic	Hilbert/j I
	goto	L005
L006:
;
; 041 i++
;
	getstatic	Hilbert/i I
	iconst_1
	iadd
	putstatic	Hilbert/i I
	goto	L001
L002:
;
; 047 println("Hilbert matrix:")
;
	getstatic	java/lang/System/out Ljava/io/PrintStream;
	ldc	"Hilbert matrix:\n"
	invokevirtual	java/io/PrintStream/print(Ljava/lang/String;)V
;
; 048 printMatrix(H)
;
	getstatic	Hilbert/H [[F
	invokestatic	Hilbert/printMatrix([[F)V
;
; 051 invert(n,H,Hinv)
;
	getstatic	Hilbert/n I
	getstatic	Hilbert/H [[F
	getstatic	Hilbert/Hinv [[F
	invokestatic	Hilbert/invert(I[[F[[F)V
;
; 053 println()
;
	getstatic	java/lang/System/out Ljava/io/PrintStream;
	invokevirtual	java/io/PrintStream.println()V
;
; 054 println("Hilbert matrix inverted:")
;
	getstatic	java/lang/System/out Ljava/io/PrintStream;
	ldc	"Hilbert matrix inverted:\n"
	invokevirtual	java/io/PrintStream/print(Ljava/lang/String;)V
;
; 055 printMatrix(Hinv)
;
	getstatic	Hilbert/Hinv [[F
	invokestatic	Hilbert/printMatrix([[F)V
;
; 058 multiply(n,H,Hinv,Z)
;
	getstatic	Hilbert/n I
	getstatic	Hilbert/H [[F
	getstatic	Hilbert/Hinv [[F
	getstatic	Hilbert/Z [[F
	invokestatic	Hilbert/multiply(I[[F[[F[[F)V
;
; 060 println()
;
	getstatic	java/lang/System/out Ljava/io/PrintStream;
	invokevirtual	java/io/PrintStream.println()V
;
; 061 println("Hilbert matrix multiplied by its inverse:")
;
	getstatic	java/lang/System/out Ljava/io/PrintStream;
	ldc	"Hilbert matrix multiplied by its inverse:\n"
	invokevirtual	java/io/PrintStream/print(Ljava/lang/String;)V
;
; 062 printMatrix(Z)
;
	getstatic	Hilbert/Z [[F
	invokestatic	Hilbert/printMatrix([[F)V
;
; 065 invert(n,Hinv,H)
;
	getstatic	Hilbert/n I
	getstatic	Hilbert/Hinv [[F
	getstatic	Hilbert/H [[F
	invokestatic	Hilbert/invert(I[[F[[F)V
;
; 067 println()
;
	getstatic	java/lang/System/out Ljava/io/PrintStream;
	invokevirtual	java/io/PrintStream.println()V
;
; 068 println("Inverse matrix inverted:")
;
	getstatic	java/lang/System/out Ljava/io/PrintStream;
	ldc	"Inverse matrix inverted:\n"
	invokevirtual	java/io/PrintStream/print(Ljava/lang/String;)V
;
; 069 printMatrix(H)
;
	getstatic	Hilbert/H [[F
	invokestatic	Hilbert/printMatrix([[F)V

	return

.limit locals 0
.limit stack 22
.end method

;
; PROCEDURE singular
;
.method private static singular(I)V

.var 0 is why I
	iload_0
	lookupswitch
	  0: L009
	  1: L010
	  2: L011
	  default: L012
L009:
;
; 082 println("Singular matrix in decompose")
;
	getstatic	java/lang/System/out Ljava/io/PrintStream;
	ldc	"Singular matrix in decompose\n"
	invokevirtual	java/io/PrintStream/print(Ljava/lang/String;)V
;
; 083 return
;
	return
	goto	L012
L010:
;
; 087 println("Matrix with zero row in decompose")
;
	getstatic	java/lang/System/out Ljava/io/PrintStream;
	ldc	"Matrix with zero row in decompose\n"
	invokevirtual	java/io/PrintStream/print(Ljava/lang/String;)V
;
; 088 return
;
	return
	goto	L012
L011:
;
; 092 println("No convergence in improve")
;
	getstatic	java/lang/System/out Ljava/io/PrintStream;
	ldc	"No convergence in improve\n"
	invokevirtual	java/io/PrintStream/print(Ljava/lang/String;)V
;
; 093 return
;
	return
	goto	L012
L012:

	return

.limit locals 1
.limit stack 3
.end method

;
; FUNCTION abs
;
.method private static abs(F)F

.var 0 is x F
	fload_0
	iconst_0
	i2f
	fcmpg
	iflt	L015
	iconst_0
	goto	L016
L015:
	iconst_1
L016:
	iconst_0
	if_icmpeq	L014
;
; 103 return-1*x
;
	iconst_1
	i2f
	fload_0
	fmul
	fneg
	freturn
	goto	L013
L014:
;
; 106 returnx
;
	fload_0
	freturn
L013:

	freturn

.limit locals 1
.limit stack 3
.end method

;
; PROCEDURE decompose
;
.method private static decompose(I[[F[[F)V

.var 1 is A [[F
.var 2 is LU [[F
.var 11 is biggest F
.var 4 is i I
.var 5 is j I
.var 6 is k I
.var 12 is mult F
.var 0 is n I
.var 8 is normrow F
.var 9 is pivot F
.var 7 is pivotindex I
.var 3 is scales [F
.var 10 is size F
	fconst_0
	fstore	11
	iconst_0
	istore	4
	iconst_0
	istore	5
	iconst_0
	istore	6
	fconst_0
	fstore	12
	fconst_0
	fstore	8
	fconst_0
	fstore	9
	iconst_0
	istore	7
	fconst_0
	fstore	10
;
; 117 floatscales[MAX]
;

	getstatic	Hilbert/MAX I
	newarray	float
	astore_3
;
; 118 inti,j,k,pivotindex
;
;
; 119 floatnormrow,pivot,size,biggest,mult
;
;
; 122 i=0
;
	iconst_0
	istore	4
L017:
	iload	4
	iload_0
	if_icmplt	L019
	iconst_0
	goto	L020
L019:
	iconst_1
L020:
	iconst_0
	if_icmpeq	L018
;
; 123 ps[i]=i
;
	getstatic	Hilbert/ps [I
	iload	4
	iload	4
	iastore
;
; 124 normrow=0
;
	iconst_0
	i2f
	fstore	8
;
; 126 j=0
;
	iconst_0
	istore	5
L021:
	iload	5
	iload_0
	if_icmplt	L023
	iconst_0
	goto	L024
L023:
	iconst_1
L024:
	iconst_0
	if_icmpeq	L022
;
; 127 LU[i][j]=A[i][j]
;
	aload_2
	iload	4
	aaload
	iload	5
	aload_1
	iload	4
	aaload
	iload	5
	faload
	fastore
	fload	8
	aload_2
	iload	4
	aaload
	iload	5
	faload
	invokestatic	Hilbert/abs(F)F
	fcmpg
	iflt	L027
	iconst_0
	goto	L028
L027:
	iconst_1
L028:
	iconst_0
	if_icmpeq	L026
;
; 131 normrow=abs(LU[i][j])
;
	aload_2
	iload	4
	aaload
	iload	5
	faload
	invokestatic	Hilbert/abs(F)F
	fstore	8
	goto	L025
L026:
L025:
;
; 126 j++
;
	iload	5
	iconst_1
	iadd
	istore	5
	goto	L021
L022:
	fload	8
	iconst_0
	i2f
	fcmpg
	ifne	L031
	iconst_0
	goto	L032
L031:
	iconst_1
L032:
	iconst_0
	if_icmpeq	L030
;
; 137 scales[i]=1/normrow
;
	aload_3
	iload	4
	iconst_1
	i2f
	fload	8
	fdiv
	fastore
	goto	L029
L030:
;
; 140 scales[i]=0
;
	aload_3
	iload	4
	iconst_0
	i2f
	fastore
;
; 141 singular(1)
;
	iconst_1
	invokestatic	Hilbert/singular(I)V
L029:
;
; 122 i++
;
	iload	4
	iconst_1
	iadd
	istore	4
	goto	L017
L018:
;
; 146 k=0
;
	iconst_0
	istore	6
L033:
	iload	6
	iload_0
	iconst_1
	isub
	if_icmplt	L035
	iconst_0
	goto	L036
L035:
	iconst_1
L036:
	iconst_0
	if_icmpeq	L034
;
; 147 pivotindex=0
;
	iconst_0
	istore	7
;
; 148 biggest=0
;
	iconst_0
	i2f
	fstore	11
;
; 151 i=k
;
	iload	6
	istore	4
L037:
	iload	4
	iload_0
	if_icmplt	L039
	iconst_0
	goto	L040
L039:
	iconst_1
L040:
	iconst_0
	if_icmpeq	L038
;
; 153 size=abs(LU[ps[i]][k])*scales[ps[i]]
;
	aload_2
	getstatic	Hilbert/ps [I
	iload	4
	iaload
	aaload
	iload	6
	faload
	invokestatic	Hilbert/abs(F)F
	aload_3
	getstatic	Hilbert/ps [I
	iload	4
	iaload
	faload
	fmul
	fstore	10
	fload	11
	fload	10
	fcmpg
	iflt	L043
	iconst_0
	goto	L044
L043:
	iconst_1
L044:
	iconst_0
	if_icmpeq	L042
;
; 156 biggest=size
;
	fload	10
	fstore	11
;
; 157 pivotindex=i
;
	iload	4
	istore	7
	goto	L041
L042:
L041:
;
; 151 i++
;
	iload	4
	iconst_1
	iadd
	istore	4
	goto	L037
L038:
	fload	11
	iconst_0
	i2f
	fcmpg
	ifeq	L047
	iconst_0
	goto	L048
L047:
	iconst_1
L048:
	iconst_0
	if_icmpeq	L046
;
; 162 singular(0)
;
	iconst_0
	invokestatic	Hilbert/singular(I)V
	goto	L045
L046:
	iload	7
	iload	6
	if_icmpne	L051
	iconst_0
	goto	L052
L051:
	iconst_1
L052:
	iconst_0
	if_icmpeq	L050
;
; 167 j=ps[k]
;
	getstatic	Hilbert/ps [I
	iload	6
	iaload
	istore	5
;
; 168 ps[k]=ps[pivotindex]
;
	getstatic	Hilbert/ps [I
	iload	6
	getstatic	Hilbert/ps [I
	iload	7
	iaload
	iastore
;
; 169 ps[pivotindex]=j
;
	getstatic	Hilbert/ps [I
	iload	7
	iload	5
	iastore
	goto	L049
L050:
L049:
;
; 172 pivot=LU[ps[k]][k]
;
	aload_2
	getstatic	Hilbert/ps [I
	iload	6
	iaload
	aaload
	iload	6
	faload
	fstore	9
;
; 175 i=k+1
;
	iload	6
	iconst_1
	iadd
	istore	4
L053:
	iload	4
	iload_0
	if_icmplt	L055
	iconst_0
	goto	L056
L055:
	iconst_1
L056:
	iconst_0
	if_icmpeq	L054
;
; 176 mult=LU[ps[i]][k]/pivot
;
	aload_2
	getstatic	Hilbert/ps [I
	iload	4
	iaload
	aaload
	iload	6
	faload
	fload	9
	fdiv
	fstore	12
;
; 177 LU[ps[i]][k]=mult
;
	aload_2
	getstatic	Hilbert/ps [I
	iload	4
	iaload
	aaload
	iload	6
	fload	12
	fastore
	fload	12
	iconst_0
	i2f
	fcmpg
	ifne	L059
	iconst_0
	goto	L060
L059:
	iconst_1
L060:
	iconst_0
	if_icmpeq	L058
;
; 183 j=k+1
;
	iload	6
	iconst_1
	iadd
	istore	5
L061:
	iload	5
	iload_0
	if_icmplt	L063
	iconst_0
	goto	L064
L063:
	iconst_1
L064:
	iconst_0
	if_icmpeq	L062
;
; 184 LU[ps[i]][j]=LU[ps[i]][j]-(mult*LU[ps[k]][j])
;
	aload_2
	getstatic	Hilbert/ps [I
	iload	4
	iaload
	aaload
	iload	5
	aload_2
	getstatic	Hilbert/ps [I
	iload	4
	iaload
	aaload
	iload	5
	faload
	fload	12
	aload_2
	getstatic	Hilbert/ps [I
	iload	6
	iaload
	aaload
	iload	5
	faload
	fmul
	fsub
	fastore
;
; 183 j++
;
	iload	5
	iconst_1
	iadd
	istore	5
	goto	L061
L062:
	goto	L057
L058:
L057:
;
; 175 i++
;
	iload	4
	iconst_1
	iadd
	istore	4
	goto	L053
L054:
L045:
;
; 146 k++
;
	iload	6
	iconst_1
	iadd
	istore	6
	goto	L033
L034:
	aload_2
	getstatic	Hilbert/ps [I
	iload_0
	iconst_1
	isub
	iaload
	aaload
	iload_0
	iconst_1
	isub
	faload
	iconst_0
	i2f
	fcmpg
	ifeq	L067
	iconst_0
	goto	L068
L067:
	iconst_1
L068:
	iconst_0
	if_icmpeq	L066
;
; 193 singular(0)
;
	iconst_0
	invokestatic	Hilbert/singular(I)V
	goto	L065
L066:
L065:

	return

.limit locals 13
.limit stack 13
.end method

;
; PROCEDURE solve
;
.method private static solve(I[[F[F[F)V

.var 1 is LU [[F
.var 2 is b [F
.var 6 is dot F
.var 4 is i I
.var 5 is j I
.var 0 is n I
.var 3 is x [F
	fconst_0
	fstore	6
	iconst_0
	istore	4
	iconst_0
	istore	5
;
; 201 inti,j
;
;
; 202 floatdot
;
;
; 205 i=0
;
	iconst_0
	istore	4
L069:
	iload	4
	iload_0
	if_icmplt	L071
	iconst_0
	goto	L072
L071:
	iconst_1
L072:
	iconst_0
	if_icmpeq	L070
;
; 206 dot=0
;
	iconst_0
	i2f
	fstore	6
;
; 207 j=0
;
	iconst_0
	istore	5
L073:
	iload	5
	iload	4
	if_icmplt	L075
	iconst_0
	goto	L076
L075:
	iconst_1
L076:
	iconst_0
	if_icmpeq	L074
;
; 208 dot=dot+(LU[ps[i]][j]*x[j])
;
	fload	6
	aload_1
	getstatic	Hilbert/ps [I
	iload	4
	iaload
	aaload
	iload	5
	faload
	aload_3
	iload	5
	faload
	fmul
	fadd
	fstore	6
;
; 207 j++
;
	iload	5
	iconst_1
	iadd
	istore	5
	goto	L073
L074:
;
; 210 x[i]=b[ps[i]]-dot
;
	aload_3
	iload	4
	aload_2
	getstatic	Hilbert/ps [I
	iload	4
	iaload
	faload
	fload	6
	fsub
	fastore
;
; 205 i++
;
	iload	4
	iconst_1
	iadd
	istore	4
	goto	L069
L070:
;
; 214 i=n-1
;
	iload_0
	iconst_1
	isub
	istore	4
L077:
	iload	4
	iconst_0
	if_icmpge	L079
	iconst_0
	goto	L080
L079:
	iconst_1
L080:
	iconst_0
	if_icmpeq	L078
;
; 215 dot=0
;
	iconst_0
	i2f
	fstore	6
;
; 216 j=i+1
;
	iload	4
	iconst_1
	iadd
	istore	5
L081:
	iload	5
	iload_0
	if_icmplt	L083
	iconst_0
	goto	L084
L083:
	iconst_1
L084:
	iconst_0
	if_icmpeq	L082
;
; 217 dot=dot+(LU[ps[i]][j]*x[j])
;
	fload	6
	aload_1
	getstatic	Hilbert/ps [I
	iload	4
	iaload
	aaload
	iload	5
	faload
	aload_3
	iload	5
	faload
	fmul
	fadd
	fstore	6
;
; 216 j++
;
	iload	5
	iconst_1
	iadd
	istore	5
	goto	L081
L082:
;
; 219 x[i]=(x[i]-dot)/LU[ps[i]][i]
;
	aload_3
	iload	4
	aload_3
	iload	4
	faload
	fload	6
	fsub
	aload_1
	getstatic	Hilbert/ps [I
	iload	4
	iaload
	aaload
	iload	4
	faload
	fdiv
	fastore
;
; 214 i--
;
	iload	4
	iconst_1
	isub
	istore	4
	goto	L077
L078:

	return

.limit locals 7
.limit stack 9
.end method

;
; PROCEDURE invert
;
.method private static invert(I[[F[[F)V

.var 1 is A [[F
.var 2 is Ainv [[F
.var 3 is LU [[F
.var 4 is b [F
.var 6 is i I
.var 7 is j I
.var 0 is n I
.var 5 is x [F
	iconst_0
	istore	6
	iconst_0
	istore	7
;
; 228 floatLU[MAX][MAX]
;

	getstatic	Hilbert/MAX I
	getstatic	Hilbert/MAX I
	multianewarray	[[F 2
	astore_3
;
; 229 floatb[MAX]
;

	getstatic	Hilbert/MAX I
	newarray	float
	astore	4
;
; 230 floatx[MAX]
;

	getstatic	Hilbert/MAX I
	newarray	float
	astore	5
;
; 231 inti,j
;
;
; 233 decompose(n,A,LU)
;
	iload_0
	aload_1
	aload_3
	invokestatic	Hilbert/decompose(I[[F[[F)V
;
; 235 j=0
;
	iconst_0
	istore	7
L085:
	iload	7
	iload_0
	if_icmplt	L087
	iconst_0
	goto	L088
L087:
	iconst_1
L088:
	iconst_0
	if_icmpeq	L086
;
; 236 i=0
;
	iconst_0
	istore	6
L089:
	iload	6
	iload_0
	if_icmplt	L091
	iconst_0
	goto	L092
L091:
	iconst_1
L092:
	iconst_0
	if_icmpeq	L090
	iload	6
	iload	7
	if_icmpeq	L095
	iconst_0
	goto	L096
L095:
	iconst_1
L096:
	iconst_0
	if_icmpeq	L094
;
; 238 b[i]=1
;
	aload	4
	iload	6
	iconst_1
	i2f
	fastore
	goto	L093
L094:
;
; 241 b[i]=0
;
	aload	4
	iload	6
	iconst_0
	i2f
	fastore
L093:
;
; 236 i++
;
	iload	6
	iconst_1
	iadd
	istore	6
	goto	L089
L090:
;
; 245 solve(n,LU,b,x)
;
	iload_0
	aload_3
	aload	4
	aload	5
	invokestatic	Hilbert/solve(I[[F[F[F)V
;
; 247 i=0
;
	iconst_0
	istore	6
L097:
	iload	6
	iload_0
	if_icmplt	L099
	iconst_0
	goto	L100
L099:
	iconst_1
L100:
	iconst_0
	if_icmpeq	L098
;
; 248 Ainv[i][j]=x[i]
;
	aload_2
	iload	6
	aaload
	iload	7
	aload	5
	iload	6
	faload
	fastore
;
; 247 i++
;
	iload	6
	iconst_1
	iadd
	istore	6
	goto	L097
L098:
;
; 235 j++
;
	iload	7
	iconst_1
	iadd
	istore	7
	goto	L085
L086:

	return

.limit locals 8
.limit stack 16
.end method

;
; PROCEDURE multiply
;
.method private static multiply(I[[F[[F[[F)V

.var 1 is A [[F
.var 2 is B [[F
.var 3 is P [[F
.var 4 is i I
.var 5 is j I
.var 6 is k I
.var 0 is n I
.var 7 is sum F
	iconst_0
	istore	4
	iconst_0
	istore	5
	iconst_0
	istore	6
	fconst_0
	fstore	7
;
; 257 inti,j,k
;
;
; 258 floatsum
;
;
; 260 i=0
;
	iconst_0
	istore	4
L101:
	iload	4
	iload_0
	if_icmplt	L103
	iconst_0
	goto	L104
L103:
	iconst_1
L104:
	iconst_0
	if_icmpeq	L102
;
; 261 j=0
;
	iconst_0
	istore	5
L105:
	iload	5
	iload_0
	if_icmplt	L107
	iconst_0
	goto	L108
L107:
	iconst_1
L108:
	iconst_0
	if_icmpeq	L106
;
; 262 sum=0.0
;
	fconst_0
	fstore	7
;
; 264 k=0
;
	iconst_0
	istore	6
L109:
	iload	6
	iload_0
	if_icmplt	L111
	iconst_0
	goto	L112
L111:
	iconst_1
L112:
	iconst_0
	if_icmpeq	L110
;
; 265 sum=sum+(A[i][k]*B[k][j])
;
	fload	7
	aload_1
	iload	4
	aaload
	iload	6
	faload
	aload_2
	iload	6
	aaload
	iload	5
	faload
	fmul
	fadd
	fstore	7
;
; 264 k++
;
	iload	6
	iconst_1
	iadd
	istore	6
	goto	L109
L110:
;
; 268 P[i][j]=sum
;
	aload_3
	iload	4
	aaload
	iload	5
	fload	7
	fastore
;
; 261 j++
;
	iload	5
	iconst_1
	iadd
	istore	5
	goto	L105
L106:
;
; 260 i++
;
	iload	4
	iconst_1
	iadd
	istore	4
	goto	L101
L102:

	return

.limit locals 8
.limit stack 6
.end method

;
; PROCEDURE printMatrix
;
.method private static printMatrix([[F)V

.var 0 is M [[F
.var 1 is i I
.var 2 is j I
	iconst_0
	istore_1
	iconst_0
	istore_2
;
; 277 inti=0
;
	iconst_0
	istore_1
L113:
	iload_1
	getstatic	Hilbert/n I
	if_icmplt	L115
	iconst_0
	goto	L116
L115:
	iconst_1
L116:
	iconst_0
	if_icmpeq	L114
;
; 278 print("[")
;
	getstatic	java/lang/System/out Ljava/io/PrintStream;
	ldc	"["
	invokevirtual	java/io/PrintStream/print(Ljava/lang/String;)V
;
; 279 intj=0
;
	iconst_0
	istore_2
L117:
	iload_2
	getstatic	Hilbert/n I
	if_icmplt	L119
	iconst_0
	goto	L120
L119:
	iconst_1
L120:
	iconst_0
	if_icmpeq	L118
;
; 280 print(M[i][j]:11:3)
;
	getstatic	java/lang/System/out Ljava/io/PrintStream;
	ldc	"%11.3f"
	iconst_1
	anewarray	java/lang/Object
	dup
	iconst_0
	aload_0
	iload_1
	aaload
	iload_2
	faload
	invokestatic	java/lang/Float/valueOf(F)Ljava/lang/Float;
	aastore
	invokevirtual	java/io/PrintStream/printf(Ljava/lang/String;[Ljava/lang/Object;)Ljava/io/PrintStream;
	pop
	iload_2
	getstatic	Hilbert/n I
	iconst_1
	isub
	if_icmplt	L123
	iconst_0
	goto	L124
L123:
	iconst_1
L124:
	iconst_0
	if_icmpeq	L122
;
; 282 print(", ")
;
	getstatic	java/lang/System/out Ljava/io/PrintStream;
	ldc	", "
	invokevirtual	java/io/PrintStream/print(Ljava/lang/String;)V
	goto	L121
L122:
L121:
;
; 279 j++
;
	iload_2
	iconst_1
	iadd
	istore_2
	goto	L117
L118:
;
; 285 println("]")
;
	getstatic	java/lang/System/out Ljava/io/PrintStream;
	ldc	"]\n"
	invokevirtual	java/io/PrintStream/print(Ljava/lang/String;)V
;
; 277 i++
;
	iload_1
	iconst_1
	iadd
	istore_1
	goto	L113
L114:

	return

.limit locals 3
.limit stack 10
.end method

;
; MAIN
;
.method public static main([Ljava/lang/String;)V
.var 0 is args [Ljava/lang/String;
.var 1 is _start Ljava/time/Instant;
.var 2 is _end Ljava/time/Instant;
.var 3 is _elapsed J

	invokestatic	java/time/Instant/now()Ljava/time/Instant;
	astore_1

	getstatic	Hilbert/MAX I
	getstatic	Hilbert/MAX I
	multianewarray	[[F 2
	putstatic	Hilbert/H [[F

	getstatic	Hilbert/MAX I
	getstatic	Hilbert/MAX I
	multianewarray	[[F 2
	putstatic	Hilbert/Hinv [[F

	getstatic	Hilbert/MAX I
	getstatic	Hilbert/MAX I
	multianewarray	[[F 2
	putstatic	Hilbert/Z [[F

	getstatic	Hilbert/MAX I
	newarray	int
	putstatic	Hilbert/ps [I
	iconst_5
	putstatic	Hilbert/MAX I

	getstatic	Hilbert/MAX I
	newarray	int
	putstatic	Hilbert/ps [I

	getstatic	Hilbert/MAX I
	getstatic	Hilbert/MAX I
	multianewarray	[[F 2
	putstatic	Hilbert/H [[F

	getstatic	Hilbert/MAX I
	getstatic	Hilbert/MAX I
	multianewarray	[[F 2
	putstatic	Hilbert/Hinv [[F

	getstatic	Hilbert/MAX I
	getstatic	Hilbert/MAX I
	multianewarray	[[F 2
	putstatic	Hilbert/Z [[F

	invokestatic	Hilbert/main()V

	invokestatic	java/time/Instant/now()Ljava/time/Instant;
	astore_2
	aload_1
	aload_2
	invokestatic	java/time/Duration/between(Ljava/time/temporal/Temporal;Ljava/time/temporal/Temporal;)Ljava/time/Duration;
	invokevirtual	java/time/Duration/toMillis()J
	lstore_3
	getstatic	java/lang/System/out Ljava/io/PrintStream;
	ldc	"\n[%,d milliseconds execution time.]\n"
	iconst_1
	anewarray	java/lang/Object
	dup
	iconst_0
	lload_3
	invokestatic	java/lang/Long/valueOf(J)Ljava/lang/Long;
	aastore
	invokevirtual	java/io/PrintStream/printf(Ljava/lang/String;[Ljava/lang/Object;)Ljava/io/PrintStream;
	pop

	return

.limit locals 6
.limit stack 12
.end method
