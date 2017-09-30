# Emscripten PATH, modify this as needed.
EMSCRIPTEN_HOME = ./compiler/emsdk-portable/emscripten/1.37.21

# ----- Build Settings, you shouldn't really need to touch these ------
# Compiler Settings
CXX = $(EMSCRIPTEN_HOME)/em++
CXXFLAGS = -Wall -Wextra -std=c++11


# Directories where the source file will be compiled
BIN_DIR = ./bin
OBJ_DIR = $(BIN_DIR)

# Source file directories
SRC_DIR = ./src/cpp
SRC_DIR_MODELS = $(SRC_DIR)/models
SRC_DIR_VIEWS = $(SRC_DIR)/views
SRC_DIR_CONTROLLERS = $(SRC_DIR)/controllers

# The source file themselves
SOURCES = $(wildcard $(SRC_DIR)/*.cpp)
SOURCES += $(wildcard $(SRC_DIR_MODELS)/*.cpp)
SOURCES += $(wildcard $(SRC_DIR_VIEWS)/*.cpp)
SOURCES += $(wildcard $(SRC_DIR_CONTROLLERS)/*.cpp)

# Object Directory
OBJECTS = $(addprefix $(OBJ_DIR)/, $(notdir $(patsubst %.cpp, %.o, $(SOURCES))))

# The executible file itself
PROJECT = DesignProject
COMPILED_JS = $(BIN_DIR)/$(PROJECT).asm.js

# ----- Actual Build targets. Add new ones as needed. ------
all: $(COMPILED_JS)

$(COMPILED_JS): $(OBJECTS)
	$(CXX) $(CXXFLAGS) $^ -o $(COMPILED_JS)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(OBJ_DIR)/%.o: $(SRC_DIR_MODELS)/%.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(OBJ_DIR)/%.o: $(SRC_DIR_VIEWS)/%.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(OBJ_DIR)/%.o: $(SRC_DIR_CONTROLLERS)/%.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

# ----- Other useful scripts ------
server:
	python3 -m http.server 8080 --bind localhost

clean:
	rm $(BIN_DIR)/$(PROJECT).* $(BIN_DIR)/*.o
