import std.stdio;
import std.getopt;
import std.process;
import std.string;
import std.algorithm;
import std.array;

import paths;

int main(string[] args){
    string[] inputFiles;
    string outputFile;
    getopt(args,
            "input|i",&inputFiles,
            "output|o",&outputFile,
          );

    //Create the arguments for DMD
    auto argsAppender=appender(cast(string[])[]);

    //Add source files from args
    argsAppender.put(map!escapeShellFileName(inputFiles));
    //Add Dandy source files
    argsAppender.put("dandy/**.d");
    argsAppender.put("dandy/**/**.d");
    //Set the object file target dir
    argsAppender.put("-odobj");
    //Set the output file to user selection
    if(outputFile)
        argsAppender.put("-of"~escapeShellFileName(outputFile));
    //Set the Derelict directories
    argsAppender.put("-L-L"~escapeShellFileName(DERELICT3_LIB_PATH));
    argsAppender.put("-L-L"~escapeShellFileName(GL3N_LIB_PATH));
    argsAppender.put([
            //"DerelictSDL",
            //"DerelictSDLImage",
            "DerelictFI",
            "DerelictGL3",
            "DerelictGLFW3",
            "DerelictUtil",
            "gl3n-dmd",
            "dl",
            ].map!(a=>("-L-l"~a)));
    argsAppender.put("-I"~escapeShellFileName(DERELICT3_IMPORT_PATH));
    argsAppender.put("-I"~escapeShellFileName(GL3N_IMPORT_PATH));

    //Run the build command
    auto dmdResult=system("dmd "~argsAppender.data.join(" "));
    return dmdResult;
}
