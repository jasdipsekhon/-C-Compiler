#ifndef STATEMENTGENERATOR_H_
#define STATEMENTGENERATOR_H_

#include <vector>
#include <map>

#include "backend/compiler/ASMCodeGenerator.h"

namespace backend { namespace compiler {

using namespace std;

class StatementGenerator : public CodeGenerator
{
public:
    /**
     * Constructor.
     * @param parent the parent code generator.
     * @param compiler the compiler to use.
     */
    StatementGenerator(CodeGenerator *parent, Compiler *compiler,string outputDir="")
        : CodeGenerator(parent, compiler,outputDir) {}

    void emitAssignment(uCParser::AssignVariableContext *ctx);

    void emitDeclarationAssignment(uCParser::AssignVariableContext *ctx);

    void emitIncrement(uCParser::IncrementVariableContext *ctx);

    void emitDecrement(uCParser::DecrementVariableContext *ctx);

    void emitIf(uCParser::IfStatementContext *ctx);

    void emitSwitch(uCParser::SwitchStatementContext *ctx);

    void emitDoWhile(uCParser::DoWhileLoopContext *ctx);

    void emitWhile(uCParser::WhileLoopContext *ctx);

    void emitFor(uCParser::ForLoopContext *ctx);

    void emitProcedureCall(uCParser::FunctionCallContext *ctx);

    void emitFunctionCall(uCParser::FunctionCallContext *ctx);

    void emitPrint(uCParser::PrintStatementContext *ctx);

    void emitPrintln(uCParser::PrintlnStatementContext *ctx);

    void emitRead(uCParser::ReadStatementContext *ctx);

    void emitReadln(uCParser::ReadlnStatementContext *ctx);

    void emitReturn(uCParser::ReturnStatementContext *ctx);

private:

    void emitCall(SymtabEntry *routineId, uCParser::ArgumentListContext *argListCtx);

    void emitPrint(uCParser::PrintArgumentsContext *argsCtx, bool needLF);

    int createPrintFormat(uCParser::PrintArgumentsContext *argsCtx, string& format,bool needLF);

    void emitArgumentsArray(uCParser::PrintArgumentsContext *argsCtx,int exprCount);

    void emitRead(uCParser::ReadArgumentsContext *argsCtx, bool needSkip);

private:
    //A couple utility tools
    string typeToString(Typespec* type);
    void emitCast(Typespec* from, Typespec* to);
};

}} // namespace backend::compiler

#endif /* STATEMENTGENERATOR_H_ */
