#include <vector>

#include "uCBaseVisitor.h"
#include "antlr4-runtime.h"

#include "backend/compiler/Directive.h"
#include "backend/compiler/Instruction.h"
#include "backend/compiler/Compiler.h"
#include "backend/compiler/ProgramGenerator.h"
#include "backend/compiler/StructuredDataGenerator.h"
#include "intermediate/symtab/Predefined.h"

namespace backend { namespace compiler {

using namespace std;

void ProgramGenerator::emitProgram(uCParser::ProgramContext *ctx){
    //Hack due to non-existant program identifier in C/C++
    programId = ctx->entry;
    Symtab *programSymtab = programId->getRoutineSymtab();

    localVariables = new LocalVariables(programLocalsCount);

    emitDirective(CLASS_PUBLIC,programName);
    emitDirective(SUPER,"java/lang/Object");

    emitProgramVariables();
    emitInputScanner();
    emitConstructor();
    emitSubroutines(ctx);

    emitMainMethod(ctx);
}

void ProgramGenerator::emitRoutine(uCParser::FunctionDefinitionContext *ctx){
    SymtabEntry *routineId = ctx->functionDeclaration()->functionIdentifier()->entry;
    Symtab *routineSymtab = routineId->getRoutineSymtab();

    emitFunctionHeader(routineId);
    emitFunctionLocals(routineId);

    // Generate code to allocate any arrays, records, and strings.
    //Moved to initialize arrays dynamically during runtime
    //StructuredDataGenerator structuredCode(this, compiler);
    //structuredCode.emitData(routineId);

    localVariables = new LocalVariables(routineSymtab->getMaxSlotNumber());

    // Emit code for the compound statement.
    uCParser::ControlScopeContext *stmtCtx = (uCParser::ControlScopeContext *) routineId->getExecutable();
    compiler->visit(stmtCtx);

    emitFunctionReturn(routineId);
    emitFunctionEpilogue();
}

void ProgramGenerator::emitProgramVariables(){
    Symtab *symtab = programId->getRoutineSymtab();
    vector<SymtabEntry *> ids = symtab->sortedEntries();

    emitLine();
    emitDirective(FIELD_PRIVATE_STATIC, "_sysin", "Ljava/util/Scanner;");

    // Loop over all the program's identifiers and
    // emit a .field directive for each variable.
    for (SymtabEntry *id : ids)
    {
        if (id->getKind() == VARIABLE)
        {
            emitDirective(FIELD_PRIVATE_STATIC, id->getName(),
                          typeDescriptor(id));
        }
    }
}

void ProgramGenerator::emitInputScanner(){
    emitLine();
    emitComment("Runtime input scanner");
    emitDirective(METHOD_STATIC, "<clinit>()V");
    emitLine();

    emit(NEW, "java/util/Scanner");
    emit(DUP);
    emit(GETSTATIC, "java/lang/System/in Ljava/io/InputStream;");
    emit(INVOKESPECIAL, "java/util/Scanner/<init>(Ljava/io/InputStream;)V");
    emit(PUTSTATIC, programName + "/_sysin Ljava/util/Scanner;");
    emit(RETURN);

    emitLine();
    emitDirective(LIMIT_LOCALS, 0);
    emitDirective(LIMIT_STACK,  3);
    emitDirective(END_METHOD);

    localStack->reset();
}

void ProgramGenerator::emitConstructor(){
    emitLine();
    emitComment("Main class constructor");
    emitDirective(METHOD_PUBLIC, "<init>()V");
    emitDirective(VAR, "0 is this L" + programName + ";");
    emitLine();

    emit(ALOAD_0);
    emit(INVOKESPECIAL, "java/lang/Object/<init>()V");
    emit(RETURN);

    emitLine();
    emitDirective(LIMIT_LOCALS, 1);
    emitDirective(LIMIT_STACK,  1);
    emitDirective(END_METHOD);

    localStack->reset();
}

void ProgramGenerator::emitSubroutines(uCParser::ProgramContext *ctx){
    for(uCParser::FunctionDefinitionContext *fCtx : ctx->functionDefinition()){
        string fName = fCtx->functionDeclaration()->functionIdentifier()->getText();
        compiler = new Compiler(compiler);
        compiler->visit(fCtx);
    }
}

void ProgramGenerator::emitMainMethod(uCParser::ProgramContext *ctx){
    emitLine();
    emitComment("MAIN");
    emitDirective(METHOD_PUBLIC_STATIC,
                  "main([Ljava/lang/String;)V");

    emitMainPrologue(programId);

    // Emit code to allocate any arrays, records, and strings.
    StructuredDataGenerator structureCode(this, compiler);
    structureCode.emitData(programId);

    //Initialize any global variables that are assigned values
    for(uCParser::AssignmentStatementContext *assignCtx : ctx->assignmentStatement()){
        compiler->visit(assignCtx);
    }

    //Re-visit global arrays + initialize their runtime values
    for(uCParser::VariableDeclarationContext *decCtx : ctx->variableDeclaration()){
        if(decCtx->variableIdentifier(0)->type == nullptr){
            continue;
        }
        else if(decCtx->variableIdentifier(0)->type->getForm() == ARRAY){
            structureCode.emitInit(decCtx->variableIdentifier(0)->entry);
        }
    }

    // Emit code for main method
    emitLine();

    //Emit code to call main method
    // In C Main method is always "void main()"
    string mainFunction = programName + "/" + "main" + "(" + "" + ")" + "V";
    emit(Instruction::INVOKESTATIC,mainFunction);

    emitMainEpilogue();
}

void ProgramGenerator::emitMainPrologue(SymtabEntry *programId){
    emitDirective(VAR, "0 is args [Ljava/lang/String;");
    emitDirective(VAR, "1 is _start Ljava/time/Instant;");
    emitDirective(VAR, "2 is _end Ljava/time/Instant;");
    emitDirective(VAR, "3 is _elapsed J");

    // Runtime timer.
    emitLine();
    emit(INVOKESTATIC, "java/time/Instant/now()Ljava/time/Instant;");
    localStack->increase(1);
    emit(ASTORE_1);
}

void ProgramGenerator::emitMainEpilogue(){
    // Print the execution time.
    emitLine();
    emit(INVOKESTATIC, "java/time/Instant/now()Ljava/time/Instant;");
    localStack->increase(1);
    emit(ASTORE_2);
    emit(ALOAD_1);
    emit(ALOAD_2);
    emit(INVOKESTATIC,
         string("java/time/Duration/between(Ljava/time/temporal/Temporal;") +
         string("Ljava/time/temporal/Temporal;)Ljava/time/Duration;"));
    localStack->decrease(1);
    emit(INVOKEVIRTUAL, "java/time/Duration/toMillis()J");
    localStack->increase(1);
    emit(LSTORE_3);
    emit(GETSTATIC, "java/lang/System/out Ljava/io/PrintStream;");
    emit(LDC, "\"\\n[%,d milliseconds execution time.]\\n\"");
    emit(ICONST_1);
    emit(ANEWARRAY, "java/lang/Object");
    emit(DUP);
    emit(ICONST_0);
    emit(LLOAD_3);
    emit(INVOKESTATIC, "java/lang/Long/valueOf(J)Ljava/lang/Long;");
    emit(AASTORE);
    emit(INVOKEVIRTUAL,
         string("java/io/PrintStream/printf(Ljava/lang/String;") +
         string("[Ljava/lang/Object;)Ljava/io/PrintStream;"));
    localStack->decrease(2);
    emit(POP);

    emitLine();
    emit(RETURN);
    emitLine();

    emitDirective(LIMIT_LOCALS, localVariables->count());
    emitDirective(LIMIT_STACK,  static_cast<int>(localStack->capacity()*2));
    emitDirective(END_METHOD);

    close();  // the object file
}

void ProgramGenerator::emitFunction(uCParser::FunctionDefinitionContext *ctx){
    SymtabEntry *routineId = ctx->functionDeclaration()->functionIdentifier()->entry;
    Symtab *routineSymtab = routineId->getRoutineSymtab();

    emitFunctionHeader(routineId);
    emitFunctionLocals(routineId);

    // Generate code to allocate any arrays, records, and strings.
    StructuredDataGenerator structuredCode(this, compiler);
    structuredCode.emitData(routineId);

    localVariables = new LocalVariables(routineSymtab->getMaxSlotNumber());

    // Emit code for the compound statement.
    uCParser::ControlScopeContext *stmtCtx = (uCParser::ControlScopeContext *) routineId->getExecutable();
    compiler->visit(stmtCtx);

    emitFunctionReturn(routineId);
    emitFunctionEpilogue();
}

void ProgramGenerator::emitFunctionHeader(SymtabEntry *routineId){
    string routineName = routineId->getName();
    vector<SymtabEntry *> *parmIds = routineId->getRoutineParameters();
    string header(routineName + "(");

    // Parameter and return type descriptors.
    if (parmIds != nullptr)
    {
        for (SymtabEntry *parmId : *parmIds)
        {
            header += typeDescriptor(parmId);
        }
    }
    header += ")" + typeDescriptor(routineId);

    emitLine();
    if (routineId->getKind() == PROCEDURE)
    {
        emitComment("PROCEDURE " + routineName);
    }
    else
    {
        emitComment("FUNCTION " + routineName);
    }

    emitDirective(METHOD_PRIVATE_STATIC, header);
}

void ProgramGenerator::emitFunctionLocals(SymtabEntry *routineId){
    Symtab *symtab = routineId->getRoutineSymtab();
    vector<SymtabEntry *> ids = symtab->sortedEntries();

    emitLine();

    // Loop over all the routine's identifiers and
    // emit a .var directive for each variable and formal parameter.
    for (SymtabEntry *id : ids)
    {
        Kind kind = id->getKind();

        if ((kind == VARIABLE) || (kind == VALUE_PARAMETER)
            || (kind == REFERENCE_PARAMETER))
        {
            int slot = id->getSlotNumber();
            emitDirective(VAR, to_string(slot) + " is " + id->getName(),
                          typeDescriptor(id));
        }
    }

    //Ran into some weird problems when not explicitly initialized, initialize non-array values to zero
    StructuredDataGenerator structuredCode(this, compiler);
    for(SymtabEntry *id : ids){
        Kind kind = id->getKind();
        Typespec *type = id->getType();

        if(kind != VALUE_PARAMETER && kind != REFERENCE_PARAMETER) {
            if (type->getForm() == SCALAR) {
                emitInitLocal(type, id->getSlotNumber());
            }
        }
    }
}

void ProgramGenerator::emitFunctionReturn(SymtabEntry *routineId){
    emitLine();

    // Function: Return the value in the implied function variable.
    if (routineId->getKind() == FUNCTION)
    {
        Typespec *type = routineId->getType();

        // Get the slot number of the function variable.
        string varName = routineId->getName();
        //Pushing value to stack will be handled by return statement

        //SymtabEntry *varId = routineId->getRoutineSymtab()->lookup(varName);
        //emitLoadLocal(type, varId->getSlotNumber());
        emitReturnValue(type);
    }

    // Procedure: Just return.
    else{
        emit(RETURN);
    }
}

void ProgramGenerator::emitFunctionEpilogue(){
    emitLine();
    emitDirective(LIMIT_LOCALS, localVariables->count());
    emitDirective(LIMIT_STACK,  static_cast<int>(localStack->capacity()*1.5));
    emitDirective(END_METHOD);
}

}} // namespace backend::compiler
