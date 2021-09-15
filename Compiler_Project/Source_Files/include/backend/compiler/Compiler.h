#ifndef COMPILER_H_
#define COMPILER_H_

#include "uCBaseVisitor.h"
#include "antlr4-runtime.h"

#include "intermediate/symtab/SymtabStack.h"
#include "intermediate/symtab/SymtabEntry.h"
#include "intermediate/type/Typespec.h"
#include "backend/compiler/ProgramGenerator.h"
#include "backend/compiler/StatementGenerator.h"
#include "backend/compiler/ExpressionGenerator.h"

namespace backend { namespace compiler {

        using namespace std;
        using namespace intermediate::symtab;
        using namespace intermediate::type;

        class CodeGenerator;

        class Compiler : public uCBaseVisitor
        {
        private:
            SymtabEntry *programId;  // symbol table entry of the program name
            string programName;      // the program name

            CodeGenerator       *code;            // base code generator
            ProgramGenerator    *programCode;     // program code generator
            StatementGenerator  *statementCode;   // statement code generator
            ExpressionGenerator *expressionCode;  // expression code generator

        public:
            /**
             * Constructor for the base compiler.
             * @param programId the symtab entry for the program name.
             */
            Compiler(SymtabEntry *programId,string outputFile="")
                    : programId(programId), programName(programId->getName()),
                      code(new CodeGenerator(programName, "j", this,outputFile)),
                      programCode(nullptr), statementCode(nullptr),
                      expressionCode(nullptr) {}

            /**
             * Constructor for child compilers of procedures and functions.
             * @param parent the parent compiler.
             */
            Compiler(Compiler *parent,string outputFile="")
                    : programId(parent->programId), programName(parent->programName),
                      code(parent->code), programCode(parent->programCode),
                      statementCode(nullptr), expressionCode(nullptr) {}


            /**
             * Get the name of the object (Jasmin) file.
             * @return the file name.
             */
            string getObjectFileName() { return code->getObjectFileName(); }
            Object loadValue(uCParser::VariableContext *ctx);

            Object visitProgram(uCParser::ProgramContext *ctx) override;
            Object visitFunctionDefinition(uCParser::FunctionDefinitionContext *ctx) override;
            Object visitVariableDeclaration(uCParser::VariableDeclarationContext *ctx) override;
            Object visitStatement(uCParser::StatementContext *ctx) override;
            Object visitAssignVariable(uCParser::AssignVariableContext *ctx) override;
            Object visitIncrementVariable(uCParser::IncrementVariableContext *ctx) override;
            Object visitDecrementVariable(uCParser::DecrementVariableContext *ctx) override;
            Object visitIfStatement(uCParser::IfStatementContext *ctx) override;
            Object visitSwitchStatement(uCParser::SwitchStatementContext *ctx) override;
            Object visitDoWhileLoop(uCParser::DoWhileLoopContext *ctx) override;
            Object visitWhileLoop(uCParser::WhileLoopContext *ctx) override;
            Object visitForLoop(uCParser::ForLoopContext *ctx) override;
            Object visitFunctionCall(uCParser::FunctionCallContext *ctx) override;
            Object visitReturnStatement(uCParser::ReturnStatementContext *ctx) override;
            Object visitExpression(uCParser::ExpressionContext *ctx) override;
            Object visitVariableFactor(uCParser::VariableFactorContext *ctx) override;
            Object visitVariable(uCParser::VariableContext *ctx) override;
            Object visitNumberFactor(uCParser::NumberFactorContext *ctx) override;
            Object visitCharacterFactor(uCParser::CharacterFactorContext *ctx) override;
            Object visitStringFactor(uCParser::StringFactorContext *ctx) override;
            Object visitFunctionCallFactor(uCParser::FunctionCallFactorContext *ctx) override;
            Object visitNotFactor(uCParser::NotFactorContext *ctx) override;
            Object visitParenthesizedFactor(uCParser::ParenthesizedFactorContext *ctx) override;
            Object visitPrintStatement(uCParser::PrintStatementContext *ctx) override;
            Object visitPrintlnStatement(uCParser::PrintlnStatementContext *ctx) override;
            Object visitReadStatement(uCParser::ReadStatementContext *ctx) override;
            Object visitReadlnStatement(uCParser::ReadlnStatementContext *ctx) override;


        private:
            /**
             * Create new child code generators.
             * @param parentGenerator the parent code generator.
             */
            void createNewGenerators(CodeGenerator *parentGenerator,string outputDir="")
            {
                programCode    = new ProgramGenerator(parentGenerator, this,outputDir);
                statementCode  = new StatementGenerator(programCode, this,outputDir);
                expressionCode = new ExpressionGenerator(programCode, this,outputDir);
            }
        };

    }}  // namespace backend::compiler

#endif /* COMPILER_H_ */
