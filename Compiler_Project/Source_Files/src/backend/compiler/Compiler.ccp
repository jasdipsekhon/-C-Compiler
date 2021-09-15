#include "intermediate/symtab/Predefined.h"
#include "backend/compiler/Compiler.h"
#include "backend/compiler/StructuredDataGenerator.h"

namespace backend { namespace compiler {

Object Compiler::loadValue(uCParser::VariableContext *ctx){
    expressionCode->emitLoadValue(ctx);
    return nullptr;
}

Object Compiler::visitProgram(uCParser::ProgramContext *ctx){
    createNewGenerators(code);
    programCode->emitProgram(ctx);
    return nullptr;
}

Object Compiler::visitFunctionDefinition(uCParser::FunctionDefinitionContext *ctx){
    createNewGenerators(code);
    programCode->emitRoutine(ctx);
    return nullptr;
}

Object Compiler::visitVariableDeclaration(uCParser::VariableDeclarationContext *ctx){
    if(!ctx->length().empty()) {
        //Only need to dynamically allocate array types
        StructuredDataGenerator structuredCode(programCode, this);
        structuredCode.emitInit(ctx->variableIdentifier(0)->entry);
    }
    return nullptr;
}

Object Compiler::visitStatement(uCParser::StatementContext *ctx){
    if (ctx->controlStatement() == nullptr){
        statementCode->emitComment(ctx);
    }

    return visitChildren(ctx);
}

Object Compiler::visitAssignVariable(uCParser::AssignVariableContext *ctx){
    if(ctx->lhs()->variable()){
        statementCode->emitAssignment(ctx);
    }
    else{
        statementCode->emitDeclarationAssignment(ctx);
    }

    return nullptr;
}

Object Compiler::visitIncrementVariable(uCParser::IncrementVariableContext *ctx){
    statementCode->emitIncrement(ctx);
    return nullptr;
}

Object Compiler::visitDecrementVariable(uCParser::DecrementVariableContext *ctx){
    statementCode->emitDecrement(ctx);
    return nullptr;
}

Object Compiler::visitIfStatement(uCParser::IfStatementContext *ctx){
    statementCode->emitIf(ctx);
    return nullptr;
}

Object Compiler::visitSwitchStatement(uCParser::SwitchStatementContext *ctx){
    statementCode->emitSwitch(ctx);
    return nullptr;
}

Object Compiler::visitDoWhileLoop(uCParser::DoWhileLoopContext *ctx){
    statementCode->emitDoWhile(ctx);
    return nullptr;
}

Object Compiler::visitWhileLoop(uCParser::WhileLoopContext *ctx){
    statementCode->emitWhile(ctx);
    return nullptr;
}

Object Compiler::visitForLoop(uCParser::ForLoopContext *ctx){
    statementCode->emitFor(ctx);
    return nullptr;
}

Object Compiler::visitFunctionCall(uCParser::FunctionCallContext *ctx){
    statementCode->emitFunctionCall(ctx);
    auto b = ctx->functionIdentifier()->getText();
    auto a = ctx->functionIdentifier()->type;
    if(ctx->functionIdentifier()->type != Predefined::voidType) {
        //We don't want to use the result, so remove it from the stack
        statementCode->emit(Instruction::POP);
    }
    return nullptr;
}

Object Compiler::visitReturnStatement(uCParser::ReturnStatementContext *ctx){
    statementCode->emitReturn(ctx);
    return nullptr;
}

Object Compiler::visitExpression(uCParser::ExpressionContext *ctx){
    expressionCode->emitExpression(ctx);
    return nullptr;
}

Object Compiler::visitVariableFactor(uCParser::VariableFactorContext *ctx){
    expressionCode->emitLoadValue(ctx->variable());
    return nullptr;
}

Object Compiler::visitVariable(uCParser::VariableContext *ctx){
    expressionCode->emitLoadVariable(ctx);
    return nullptr;
}

Object Compiler::visitNumberFactor(uCParser::NumberFactorContext *ctx){
    if (ctx->type == Predefined::integerType)
    {
        expressionCode->emitLoadIntegerConstant(ctx->number());
    }
    else
    {
        expressionCode->emitLoadRealConstant(ctx->number());
    }

    return nullptr;
}

Object Compiler::visitCharacterFactor(uCParser::CharacterFactorContext *ctx){
    char ch = ctx->getText()[1];
    expressionCode->emitLoadConstant(ch);

    return nullptr;
}

Object Compiler::visitStringFactor(uCParser::StringFactorContext *ctx){
    string jasminString = convertString(ctx->getText(), true);
    expressionCode->emitLoadConstant(jasminString);

    return nullptr;
}

Object Compiler::visitFunctionCallFactor(uCParser::FunctionCallFactorContext *ctx){
    statementCode->emitFunctionCall(ctx->functionCall());
    return nullptr;
}

Object Compiler::visitNotFactor(uCParser::NotFactorContext *ctx){
    expressionCode->emitNotFactor(ctx);
    return nullptr;
}

Object Compiler::visitParenthesizedFactor(uCParser::ParenthesizedFactorContext *ctx){
    return visit(ctx->expression());
}

Object Compiler::visitPrintStatement(uCParser::PrintStatementContext *ctx){
    statementCode->emitPrint(ctx);
    return nullptr;
}

Object Compiler::visitPrintlnStatement(uCParser::PrintlnStatementContext *ctx){
    statementCode->emitPrintln(ctx);
    return nullptr;
}

Object Compiler::visitReadStatement(uCParser::ReadStatementContext *ctx){
    statementCode->emitRead(ctx);
    return nullptr;
}

Object Compiler::visitReadlnStatement(uCParser::ReadlnStatementContext *ctx){
    statementCode->emitReadln(ctx);
    return nullptr;
}

}}
