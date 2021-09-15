#==============================C++ Compilter Settings==============================#
CXX := g++
CFLAGS += -w -MMD -MP
CXXFLAGS += -std=c++11
LDFLAGS += -static-libgcc -static-libstdc++ -pthread

#Not likely to change, but added for compatability with certain IDEs
BUILD_DIR := .
ROOT_DIR := ..


#==============================Variables and Directories==============================#
include $(BUILD_DIR)/Makefile.variable

#Add linker flags for C++ antlr runtime
LDFLAGS += -L$(ANTLR_RUNTIME_LIB) -lantlr4-runtime

#Adding paths to application names
APP_PATH := $(BUILD_DIR)/$(APP_NAME)

#Build Directory Settings
APP_OBJ_DIR := $(BUILD_DIR)/$(APP_OBJ_DIR_NAME)
ANTLR_OBJ_DIR := $(BUILD_DIR)/$(ANTLR_OBJ_DIR_NAME)

#==============================Build Rules==============================#
.PHONY: all release debug unit-tests clean antlr parse_tree railroad
.NOTPARALLEL: antlr
#Default to normal build
all: release



#Build antlr output directory if it doesn't exist
$(ANTLR_OUTPUT_DIR):
	@mkdir $(ANTLR_OUTPUT_DIR)

#Uses antlr to create a parser and lexer using c++
antlr: | $(ANTLR_OUTPUT_DIR)
	java -jar $(ANTLR_SRC_DIR)/$(ANTLR_FILE) -no-listener -visitor -encoding UTF-8 -Dlanguage=Cpp -o $(ANTLR_OUTPUT_DIR) -Xexact-output-dir $(ANTLR_SRC_DIR)/$(ANTLR_GRAMMER_NAME).g4

clean_antlr:
	@rm -rf $(ANTLR_OUTPUT_DIR)

#Uses java-version of antlr to generate parse tree and railroad diagrams, since the c++ version doesn't have command-line support outside of eclipse
$(ANTLR_OBJ_DIR):
	@mkdir $(ANTLR_OBJ_DIR)

$(ANTLR_OBJ_DIR)_Java:
	@mkdir $(ANTLR_OBJ_DIR)_Java

#Uses duplicate grammer file [file]_java.g4 without the c++ locals, since they mess up the parse tree generator
parse_tree: | $(ANTLR_OBJ_DIR_NAME)_Java
	java -jar $(ANTLR_SRC_DIR)/$(ANTLR_FILE) -no-listener -visitor -encoding UTF-8 -o $(ANTLR_OBJ_DIR)_Java -Xexact-output-dir $(ANTLR_SRC_DIR)/$(ANTLR_GRAMMER_NAME)_Java.g4
	javac -cp $(ANTLR_OBJ_DIR)_Java:$(ANTLR_SRC_DIR)/$(ANTLR_FILE) $(ANTLR_OBJ_DIR)_Java/$(ANTLR_GRAMMER_NAME)_Java*.java
	java -cp $(ANTLR_OBJ_DIR)_Java:$(ANTLR_SRC_DIR)/$(ANTLR_FILE) org.antlr.v4.gui.TestRig $(ANTLR_GRAMMER_NAME)_Java program -gui $(if $(FILE_PATH),../$(FILE_PATH))

railroad:
	java -jar $(ANTLR_SRC_DIR)/$(ANTLR_RR_FILE) $(ANTLR_SRC_DIR)/$(ANTLR_GRAMMER_NAME).g4



#Target specific variable for includes, No debug flags
release: INCLUDES += $(strip $(foreach DIR,$(ALL_SRC_DIR_APP),-I$(DIR))) -I $(ANTLR_RUNTIME_HEADER)
release: $(APP_PATH)

#Target specific variable for enabling debugging required for GDB
debug: CXXFLAGS += -g
debug: release

#Clean is used to remove all the build files, e.g. forcing recompile
clean:
	@printf "\033[0;36mCleaning Files\033[0m\n"
	@rm -rf $(APP_OBJ_DIR)
	@rm -f $(APP_PATH)
	@rm -rf $(ANTLR_OBJ_DIR)
	@rm -rf output


#Build the app objects directory if it doesn't exist
$(APP_OBJ_DIR):
	@mkdir $(APP_OBJ_DIR)

#Build the test objects directory if it doesn't exist
$(TEST_OBJ_DIR):
	@mkdir $(TEST_OBJ_DIR)


#==============================Dynamic Build Rule==============================#
#Create build rule for object files, strip function used to clean up spacing in terminal window
define MAKE_RULE
# Argument List (In order)
#1 File Name: Includes directory and extention
#2 Object Directory: Where the compiled object files will be placed
$(patsubst %,$(2)/%.o,$(basename $(notdir $(1)))): $(1) | $(2)
	@printf "\033[0;36mBuilding $$(@F)\033[0m\n"
	$$(strip $$(CXX) $$(CFLAGS) $$(CXXFLAGS) $$(EXTRACXXFLAGS) $$(INCLUDES) -o $$@ -c $$<)
endef


#==============================Magic Parsing==============================#
#Generate rules for building application object files
$(foreach EXT,$(EXTENTIONS),\
	$(foreach DIR,$(ALL_SRC_DIR_APP),\
		$(foreach FILE,$(wildcard $(DIR)/*$(EXT)),\
			$(eval $(call MAKE_RULE,$(FILE),$(APP_OBJ_DIR))) )))


#Create list of needed files for application
APP_SRC_LIST := $(strip $(foreach EXT,$(EXTENTIONS),\
				$(foreach DIR,$(ALL_SRC_DIR_APP),\
					$(foreach FILE,$(filter-out $(APP_MAIN) $(TEST_MAIN),$(wildcard $(DIR)/*$(EXT))),\
						$(patsubst %,$(APP_OBJ_DIR)/%.o,$(basename $(notdir $(FILE)))) ))))

#Manually differentiate main object file to prevent multiple-mains
APP_MAIN_OBJ := $(patsubst %,$(APP_OBJ_DIR)/%.o,$(basename $(notdir $(APP_MAIN))))

#Include generated dependancies for detecting header changes
include $(wildcard $(APP_OBJ_DIR)/*.d)


#==============================Main Application Rules==============================#
#Build rule for making main application
$(APP_PATH): $(APP_SRC_LIST) $(APP_MAIN_OBJ)
	@printf "\033[0;36mLinking $(@F)\033[0m\n"
	$(strip $(CXX) -o $@ $^ $(LDFLAGS))
	@printf "\033[0;32mBuild successful\033[0m\n"
