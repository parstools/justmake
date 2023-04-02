#include <iostream>
#include <fstream>

#include "antlr4-runtime.h"
#include "tree/ParseTreeWalker.h"
#include "JustmakeLexer.h"
#include "JustmakeParser.h"
#include "JustmakeParserBaseListener.h"

using namespace jm_parser;
using namespace antlr4;

class CMakeListnener: public jm_parser::JustmakeParserBaseListener {
    std::unordered_set <std::string> idents;
//    void enterCommand_invocation(CMakeParser::Command_invocationContext *ctx) override {
//        idents.insert(ctx->Identifier()->toString());
//    }
public:
    void printIdents() {
        for (auto id: idents)
            std::cout << id << std::endl;
    }
};

int main(int , const char **) {
    std::ifstream ifs("../test/test1.jumake");
    ANTLRInputStream input(ifs);
    JustmakeLexer lexer(&input);
    CommonTokenStream tokens(&lexer);

    tokens.fill();
    for (auto token : tokens.getTokens()) {
        std::cout << token->toString() << std::endl;
    }

    CMakeListnener listener;
    JustmakeParser parser(&tokens);
    tree::ParseTree* tree = parser.document();
//    std::cout << tree->toStringTree(&parser) << std::endl << std::endl;
    antlr4::tree::ParseTreeWalker::DEFAULT.walk(&listener, tree);
    listener.printIdents();
    return 0;
}