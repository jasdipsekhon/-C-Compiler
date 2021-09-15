#ifndef EXPRESSIONGENERATOR_H_
#define EXPRESSIONGENERATOR_H_

#include "backend/compiler/ASMCodeGenerator.h"

namespace backend { namespace compiler {

class ExpressionGenerator : public CodeGenerator
{
public:
    /**
     * Constructor.
     * @param parent the parent code generator.
     * @param compiler the compiler to use.
     */
    ExpressionGenerator(CodeGenerator *parent, Compiler *compiler,string outputDir="")
        : CodeGenerator(parent, compiler,outputDir) {}

    void emitExpression(uCParser::ExpressionContext *ctx);

    void emitSimpleExpression(uCParser::SimpleExpressionContext *ctx);

    void emitTerm(uCParser::TermContext *ctx);

    void emitNotFactor(uCParser::NotFactorContext *ctx);

    void emitLoadValue(uCParser::VariableContext *varCtx);

    Typespec *emitLoadVariable(uCParser::VariableContext *varCtx);

    Typespec *emitLoadArrayElementAccess(uCParser::ModifierContext *modCtx,Typespec *elmtType, bool lastModifier);

    Typespec *emitLoadArrayElementValue(Typespec *elmtType);

    void emitLoadIntegerConstant(uCParser::NumberContext *intCtx);

    void emitLoadRealConstant(uCParser::NumberContext *realCtx);

private:

};

}} // namespace backend::compiler

#endif /* EXPRESSIONGENERATOR_H_ */
