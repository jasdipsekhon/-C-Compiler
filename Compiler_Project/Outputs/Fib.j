.class public Fib
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
	putstatic	Fib/_sysin Ljava/util/Scanner;
	return

.limit locals 0
.limit stack 3
.end method

;
; Main class constructor
;
.method public <init>()V
.var 0 is this LFib;

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

.var 1 is fib_n I
.var 0 is i I
	iconst_0
	istore_1
	iconst_0
	istore_0
;
; 004 inti
;
L001:
;
; 006 print("Enter Number:")
;
	getstatic	java/lang/System/out Ljava/io/PrintStream;
	ldc	"Enter Number:"
	invokevirtual	java/io/PrintStream/print(Ljava/lang/String;)V
;
; 007 read(i)
;
	getstatic	Fib/_sysin Ljava/util/Scanner;
	invokevirtual	java/util/Scanner/nextInt()I
	istore_0
	iload_0
	iconst_0
	if_icmpge	L005
	iconst_0
	goto	L006
L005:
	iconst_1
L006:
	iconst_0
	if_icmpeq	L004
;
; 009 intfib_n=fib(i)
;
	iload_0
	invokestatic	Fib/fib(I)I
	istore_1
;
; 010 println("The ",i,(i==1)?"st":((i==2)?"nd":(i==3?"rd":"th"))," Fibbonac ...
;
	getstatic	java/lang/System/out Ljava/io/PrintStream;
	ldc	"The %d%s Fibbonachi number is: %d\n"
	iconst_3
	anewarray	java/lang/Object
	dup
	iconst_0
	iload_0
	invokestatic	java/lang/Integer/valueOf(I)Ljava/lang/Integer;
	aastore
	dup
	iconst_1
	iload_0
	iconst_1
	if_icmpeq	L009
	iconst_0
	goto	L010
L009:
	iconst_1
L010:
	iconst_0
	if_icmpeq	L007
	ldc	"st"
	goto	L008
L007:
	iload_0
	iconst_2
	if_icmpeq	L013
	iconst_0
	goto	L014
L013:
	iconst_1
L014:
	iconst_0
	if_icmpeq	L011
	ldc	"nd"
	goto	L012
L011:
	iload_0
	iconst_3
	if_icmpeq	L017
	iconst_0
	goto	L018
L017:
	iconst_1
L018:
	iconst_0
	if_icmpeq	L015
	ldc	"rd"
	goto	L016
L015:
	ldc	"th"
L016:
L012:
L008:
	aastore
	dup
	iconst_2
	iload_1
	invokestatic	java/lang/Integer/valueOf(I)Ljava/lang/Integer;
	aastore
	invokevirtual	java/io/PrintStream/printf(Ljava/lang/String;[Ljava/lang/Object;)Ljava/io/PrintStream;
	pop
	goto	L003
L004:
L003:
;
; 013 println()
;
	getstatic	java/lang/System/out Ljava/io/PrintStream;
	invokevirtual	java/io/PrintStream.println()V
	iload_0
	iconst_0
	if_icmpge	L019
	iconst_0
	goto	L020
L019:
	iconst_1
L020:
	iconst_1
	if_icmpeq	L001
L002:

	return

.limit locals 2
.limit stack 13
.end method

;
; FUNCTION fib
;
.method private static fib(I)I

.var 0 is in I
	iload_0
	iconst_0
	if_icmpeq	L023
	iconst_0
	goto	L024
L023:
	iconst_1
L024:
	iconst_0
	if_icmpeq	L022
;
; 020 return0
;
	iconst_0
	ireturn
	goto	L021
L022:
	iload_0
	iconst_1
	if_icmpeq	L026
	iconst_0
	goto	L027
L026:
	iconst_1
L027:
	iconst_0
	if_icmpeq	L025
;
; 023 return1
;
	iconst_1
	ireturn
	goto	L021
L025:
;
; 026 returnfib(in-2)+fib(in-1)
;
	iload_0
	iconst_2
	isub
	invokestatic	Fib/fib(I)I
	iload_0
	iconst_1
	isub
	invokestatic	Fib/fib(I)I
	iadd
	ireturn
L021:

	ireturn

.limit locals 1
.limit stack 4
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

	invokestatic	Fib/main()V

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
