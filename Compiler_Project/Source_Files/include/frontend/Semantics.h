#ifndef SEMANTICS_H_
#define SEMANTICS_H_

#include <map>

#include "uCBaseVisitor.h"
#include "antlr4-runtime.h"

#include "intermediate/symtab/SymtabStack.h"
#include "intermediate/symtab/SymtabEntry.h"
#include "intermediate/symtab/Predefined.h"
#include "intermediate/type/Typespec.h"
#include "intermediate/util/BackendMode.h"
#include "frontend/SemanticErrorHandler.h"

namespace frontend {

    using namespace std;
    using namespace intermediate::symtab;
    using namespace intermediate::type;

    class Semantics : public uCBaseVisitor
    {
    private:
        string programName;
        BackendMode mode;
        SymtabStack *symtabStack;
        SymtabEntry *programId;
        SemanticErrorHandler error;

        map<string, Typespec *> *typeTable;

        /**
         * Return the number of values in a datatype.
         * @param type the datatype.
         * @return the number of values.
         */
        int typeCount(Typespec *type);

        /**
         * Determine whether or not an expression is a variable only.
         * @param exprCtx the ExpressionContext.
         * @return true if it's an expression only, else false.
         */
        bool expressionIsVariable(uCParser::ExpressionContext *exprCtx);

        /**
         * Perform semantic operations on procedure and function call arguments.
         * @param listCtx the ArgumentListContext.
         * @param parameters the vector of parameters to fill.
         */
        void checkCallArguments(uCParser::ArgumentListContext *listCtx,
                                vector<SymtabEntry *> *parms);

        /**
         * Determine the datatype of a variable that can have modifiers.
         * @param varCtx the VariableContext.
         * @param varType the variable's datatype without the modifiers.
         * @return the datatype with any modifiers.
         */
        Typespec *variableDatatype(uCParser::VariableContext *varCtx,
                                   Typespec *varType);

        void postErrorCheck();


    public:
        Semantics(BackendMode mode,string programName) : mode(mode), programId(nullptr), programName(programName)
        {
            // Create and initialize the symbol table stack.
            symtabStack = new SymtabStack();
            Predefined::initialize(symtabStack);

            typeTable = new map<string, Typespec *>();
            (*typeTable)["integer"] = Predefined::integerType;
            (*typeTable)["real"]    = Predefined::realType;
            (*typeTable)["boolean"] = Predefined::booleanType;
            (*typeTable)["char"]    = Predefined::charType;
            (*typeTable)["string"]  = Predefined::stringType;
            (*typeTable)["void"]  = Predefined::voidType;
        }

        /**
         * Get the symbol table entry of the program identifier.
         * @return the entry.
         */
        SymtabEntry *getProgramId() { return programId; }

        /**
         * Get the count of semantic errors.
         * @return the count.
         */
        int getErrorCount() const;

        Object visitProgram(uCParser::ProgramContext *ctx) override;
        Object visitVariableDeclaration(uCParser::VariableDeclarationContext *ctx) override;
        Object visitTypeIdentifier(uCParser::TypeIdentifierContext *ctx) override;
        Object visitLhs(uCParser::LhsContext *ctx) override;
        Object visitAssignVariable(uCParser::AssignVariableContext *ctx) override;
        Object visitDecrementVariable(uCParser::DecrementVariableContext *ctx) override;
        Object visitIncrementVariable(uCParser::IncrementVariableContext *ctx) override;

        Object visitFunctionDeclaration(uCParser::FunctionDeclarationContext *ctx) override;
        Object visitFunctionDefinition(uCParser::FunctionDefinitionContext *ctx) override;
        Object visitParameterDeclarationsList(uCParser::ParameterDeclarationsListContext *ctx) override;
        Object visitParameterDeclaration(uCParser::ParameterDeclarationContext *ctx) override;

        Object visitDoWhileLoop(uCParser::DoWhileLoopContext *ctx) override;
        Object visitWhileLoop(uCParser::WhileLoopContext *ctx) override;
        Object visitForLoop(uCParser::ForLoopContext *ctx) override;
        Object visitIfStatement(uCParser::IfStatementContext *ctx) override;
        Object visitSwitchStatement(uCParser::SwitchStatementContext *ctx) override;

        Object visitFunctionCall(uCParser::FunctionCallContext *ctx) override;
        Object visitFunctionCallFactor(uCParser::FunctionCallFactorContext *ctx) override;
        Object visitReturnStatement(uCParser::ReturnStatementContext *ctx) override;

        Object visitExpression(uCParser::ExpressionContext *ctx) override;
        Object visitSimpleExpression(uCParser::SimpleExpressionContext *ctx) override;
        Object visitTerm(uCParser::TermContext *ctx) override;
        Object visitVariableFactor(uCParser::VariableFactorContext *ctx) override;
        Object visitVariable(uCParser::VariableContext *ctx) override;
        Object visitVariableIdentifier(uCParser::VariableIdentifierContext *ctx) override;
        Object visitNumberFactor(uCParser::NumberFactorContext *ctx) override;
        Object visitCharacterFactor(uCParser::CharacterFactorContext *ctx) override;
        Object visitStringFactor(uCParser::StringFactorContext *ctx) override;
        Object visitNotFactor(uCParser::NotFactorContext *ctx) override;
        Object visitParenthesizedFactor(uCParser::ParenthesizedFactorContext *ctx) override;

    };

} // namespace frontend

#endif /* SEMANTICS_H_ */
