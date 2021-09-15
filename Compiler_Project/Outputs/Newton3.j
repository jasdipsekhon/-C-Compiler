.class public Newton3
.super java/lang/Object

.field private static _sysin Ljava/util/Scanner;

;
; Runtime input scanner
;
.method static <clinit>()V

	new	java/util/Scanner
	dup
	getstatic	java/lang/System/in Ljava/io/InputStream;
	invokespecial	java/util/Scanner/<init>(Ljava/io/InputStream;)V
	putstatic	Newton3/_sysin Ljava/util/Scanner;
	return

.limit locals 0
.limit stack 3
.end method

;
; Main class constructor
;
.method public <init>()V
.var 0 is this LNewton3;

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

.var 0 is number I
	iconst_0
	istore_0
;
; 009 intnumber=0
;
	iconst_0
	istore_0
L001:
	iload_0
	bipush	25
	if_icmple	L003
	iconst_0
	goto	L004
L003:
	iconst_1
L004:
	iconst_0
	if_icmpeq	L002
;
; 010 printRoot(number,root(number))
;
	iload_0
	iload_0
	i2f
	invokestatic	Newton3/root(F)F
	invokestatic	Newton3/printRoot(IF)V
;
; 009 number++
;
	iload_0
	iconst_1
	iadd
	istore_0
	goto	L001
L002:

	return

.limit locals 1
.limit stack 6
.end method

;
; FUNCTION root
;
.method private static root(F)F

.var 3 is diff F
.var 2 is prev F
.var 1 is r F
.var 0 is x F
	fconst_0
	fstore_3
	fconst_0
	fstore_2
	fconst_0
	fstore_1
;
; 021 floatr,prev,diff
;
;
; 023 r=1
;
	iconst_1
	i2f
	fstore_1
;
; 024 prev=0
;
	iconst_0
	i2f
	fstore_2
L005:
;
; 027 r=(x/r+r)/2
;
	fload_0
	fload_1
	fdiv
	fload_1
	fadd
	iconst_2
	i2f
	fdiv
	fstore_1
;
; 028 diff=r-prev
;
	fload_1
	fload_2
	fsub
	fstore_3
	fload_3
	iconst_0
	i2f
	fcmpg
	iflt	L009
	iconst_0
	goto	L010
L009:
	iconst_1
L010:
	iconst_0
	if_icmpeq	L008
;
; 030 diff=-diff
;
	fload_3
	fneg
	fstore_3
	goto	L007
L008:
L007:
;
; 032 prev=r
;
	fload_1
	fstore_2
	fload_3
	ldc	1.01e-10
	fcmpg
	ifge	L011
	iconst_0
	goto	L012
L011:
	iconst_1
L012:
	iconst_1
	if_icmpeq	L005
L006:
;
; 034 returnr
;
	fload_1
	freturn

	freturn

.limit locals 4
.limit stack 3
.end method

;
; PROCEDURE printRoot
;
.method private static printRoot(IF)V

.var 0 is n I
.var 1 is root F
;
; 041 println("The square root of ",n:2," is ",root:8:4)
;
	getstatic	java/lang/System/out Ljava/io/PrintStream;
	ldc	"The square root of %2d is %8.4f\n"
	iconst_2
	anewarray	java/lang/Object
	dup
	iconst_0
	iload_0
	invokestatic	java/lang/Integer/valueOf(I)Ljava/lang/Integer;
	aastore
	dup
	iconst_1
	fload_1
	invokestatic	java/lang/Float/valueOf(F)Ljava/lang/Float;
	aastore
	invokevirtual	java/io/PrintStream/printf(Ljava/lang/String;[Ljava/lang/Object;)Ljava/io/PrintStream;
	pop

	return

.limit locals 2
.limit stack 9
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

	invokestatic	Newton3/main()V

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
.limit stack 14
.end method
