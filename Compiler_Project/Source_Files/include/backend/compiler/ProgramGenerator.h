#ifndef PROGRAMGENERATOR_H_
#define PROGRAMGENERATOR_H_

#include "backend/compiler/ASMCodeGenerator.h"

namespace backend { namespace compiler {

class ProgramGenerator : public CodeGenerator
{
private:
    SymtabEntry *programId;  // symbol table entry of the program name
    int programLocalsCount;  // count of program local variables

public:
    /*
     * Constructor.
     * @param the parent generator.
     * @param compiler the compiler to use.
     */
    ProgramGenerator(CodeGenerator *parent, Compiler *compiler,string outputDir="")
        : CodeGenerator(parent, compiler,outputDir),
          programId(nullptr), programLocalsCount(5) // 5 because _elapsed is long
    {
        localStack = new LocalStack();
    }

    void emitProgram(uCParser::ProgramContext *ctx);
    void emitRoutine(uCParser::FunctionDefinitionContext *ctx);

private:
    void emitProgramVariables();
    void emitInputScanner();
    void emitConstructor();
    void emitSubroutines(uCParser::ProgramContext *ctx);
    void emitMainMethod(uCParser::ProgramContext *ctx);
    void emitMainPrologue(SymtabEntry* programId);
    void emitMainEpilogue();
    void emitFunction(uCParser::FunctionDefinitionContext *ctx);
    void emitFunctionHeader(SymtabEntry *routineId);
    void emitFunctionLocals(SymtabEntry *routineId);
    void emitFunctionReturn(SymtabEntry *routineId);
    void emitFunctionEpilogue();
};

}} // namespace backend::compiler

#endif /* PROGRAMGENERATOR_H_ */
