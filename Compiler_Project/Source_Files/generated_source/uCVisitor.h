
    #include <map>
    #include "intermediate/symtab/Symtab.h"
    #include "intermediate/type/Typespec.h"
    using namespace intermediate::symtab;
    using namespace intermediate::type;


// Generated from ../Source_Files/antlr/uC.g4 by ANTLR 4.8

#pragma once


#include "antlr4-runtime.h"
#include "uCParser.h"



/**
 * This class defines an abstract visitor for a parse tree
 * produced by uCParser.
 */
class  uCVisitor : public antlr4::tree::AbstractParseTreeVisitor {
public:

  /**
   * Visit parse trees produced by uCParser.
   */
    virtual antlrcpp::Any visitProgram(uCParser::ProgramContext *context) = 0;

    virtual antlrcpp::Any visitC_statement(uCParser::C_statementContext *context) = 0;

    virtual antlrcpp::Any visitStatement(uCParser::StatementContext *context) = 0;

    virtual antlrcpp::Any visitEmptyStatement(uCParser::EmptyStatementContext *context) = 0;

    virtual antlrcpp::Any visitVariableDeclaration(uCParser::VariableDeclarationContext *context) = 0;

    virtual antlrcpp::Any visitLength(uCParser::LengthContext *context) = 0;

    virtual antlrcpp::Any visitAssignVariable(uCParser::AssignVariableContext *context) = 0;

    virtual antlrcpp::Any visitIncrementVariable(uCParser::IncrementVariableContext *context) = 0;

    virtual antlrcpp::Any visitDecrementVariable(uCParser::DecrementVariableContext *context) = 0;

    virtual antlrcpp::Any visitLhs(uCParser::LhsContext *context) = 0;

    virtual antlrcpp::Any visitRhs(uCParser::RhsContext *context) = 0;

    virtual antlrcpp::Any visitControlScope(uCParser::ControlScopeContext *context) = 0;

    virtual antlrcpp::Any visitControlStatement(uCParser::ControlStatementContext *context) = 0;

    virtual antlrcpp::Any visitDoWhileLoop(uCParser::DoWhileLoopContext *context) = 0;

    virtual antlrcpp::Any visitWhileLoop(uCParser::WhileLoopContext *context) = 0;

    virtual antlrcpp::Any visitForLoop(uCParser::ForLoopContext *context) = 0;

    virtual antlrcpp::Any visitIfStatement(uCParser::IfStatementContext *context) = 0;

    virtual antlrcpp::Any visitSwitchStatement(uCParser::SwitchStatementContext *context) = 0;

    virtual antlrcpp::Any visitSwitchCaseList(uCParser::SwitchCaseListContext *context) = 0;

    virtual antlrcpp::Any visitCaseBranch(uCParser::CaseBranchContext *context) = 0;

    virtual antlrcpp::Any visitDefaultBranch(uCParser::DefaultBranchContext *context) = 0;

    virtual antlrcpp::Any visitFunctionDefinition(uCParser::FunctionDefinitionContext *context) = 0;

    virtual antlrcpp::Any visitFunctionDeclaration(uCParser::FunctionDeclarationContext *context) = 0;

    virtual antlrcpp::Any visitFunctionIdentifier(uCParser::FunctionIdentifierContext *context) = 0;

    virtual antlrcpp::Any visitParameterDeclarationsList(uCParser::ParameterDeclarationsListContext *context) = 0;

    virtual antlrcpp::Any visitParameterDeclaration(uCParser::ParameterDeclarationContext *context) = 0;

    virtual antlrcpp::Any visitParameterIdentifier(uCParser::ParameterIdentifierContext *context) = 0;

    virtual antlrcpp::Any visitReturnStatement(uCParser::ReturnStatementContext *context) = 0;

    virtual antlrcpp::Any visitFunctionCall(uCParser::FunctionCallContext *context) = 0;

    virtual antlrcpp::Any visitArgumentList(uCParser::ArgumentListContext *context) = 0;

    virtual antlrcpp::Any visitArgument(uCParser::ArgumentContext *context) = 0;

    virtual antlrcpp::Any visitPrintStatement(uCParser::PrintStatementContext *context) = 0;

    virtual antlrcpp::Any visitPrintlnStatement(uCParser::PrintlnStatementContext *context) = 0;

    virtual antlrcpp::Any visitPrintArguments(uCParser::PrintArgumentsContext *context) = 0;

    virtual antlrcpp::Any visitPrintArgument(uCParser::PrintArgumentContext *context) = 0;

    virtual antlrcpp::Any visitFieldWidth(uCParser::FieldWidthContext *context) = 0;

    virtual antlrcpp::Any visitDecimalPlaces(uCParser::DecimalPlacesContext *context) = 0;

    virtual antlrcpp::Any visitReadStatement(uCParser::ReadStatementContext *context) = 0;

    virtual antlrcpp::Any visitReadlnStatement(uCParser::ReadlnStatementContext *context) = 0;

    virtual antlrcpp::Any visitReadArguments(uCParser::ReadArgumentsContext *context) = 0;

    virtual antlrcpp::Any visitExpression(uCParser::ExpressionContext *context) = 0;

    virtual antlrcpp::Any visitSimpleExpression(uCParser::SimpleExpressionContext *context) = 0;

    virtual antlrcpp::Any visitTerm(uCParser::TermContext *context) = 0;

    virtual antlrcpp::Any visitVariableFactor(uCParser::VariableFactorContext *context) = 0;

    virtual antlrcpp::Any visitNumberFactor(uCParser::NumberFactorContext *context) = 0;

    virtual antlrcpp::Any visitCharacterFactor(uCParser::CharacterFactorContext *context) = 0;

    virtual antlrcpp::Any visitStringFactor(uCParser::StringFactorContext *context) = 0;

    virtual antlrcpp::Any visitFunctionCallFactor(uCParser::FunctionCallFactorContext *context) = 0;

    virtual antlrcpp::Any visitNotFactor(uCParser::NotFactorContext *context) = 0;

    virtual antlrcpp::Any visitParenthesizedFactor(uCParser::ParenthesizedFactorContext *context) = 0;

    virtual antlrcpp::Any visitVariable(uCParser::VariableContext *context) = 0;

    virtual antlrcpp::Any visitModifier(uCParser::ModifierContext *context) = 0;

    virtual antlrcpp::Any visitIndex(uCParser::IndexContext *context) = 0;

    virtual antlrcpp::Any visitVariableIdentifier(uCParser::VariableIdentifierContext *context) = 0;

    virtual antlrcpp::Any visitNumber(uCParser::NumberContext *context) = 0;

    virtual antlrcpp::Any visitUnsignedNumber(uCParser::UnsignedNumberContext *context) = 0;

    virtual antlrcpp::Any visitSign(uCParser::SignContext *context) = 0;

    virtual antlrcpp::Any visitIntegerConstant(uCParser::IntegerConstantContext *context) = 0;

    virtual antlrcpp::Any visitRealConstant(uCParser::RealConstantContext *context) = 0;

    virtual antlrcpp::Any visitRelOp(uCParser::RelOpContext *context) = 0;

    virtual antlrcpp::Any visitAddOp(uCParser::AddOpContext *context) = 0;

    virtual antlrcpp::Any visitMulOp(uCParser::MulOpContext *context) = 0;

    virtual antlrcpp::Any visitTypeIdentifier(uCParser::TypeIdentifierContext *context) = 0;

    virtual antlrcpp::Any visitCharacterConstant(uCParser::CharacterConstantContext *context) = 0;

    virtual antlrcpp::Any visitStringConstant(uCParser::StringConstantContext *context) = 0;


};

