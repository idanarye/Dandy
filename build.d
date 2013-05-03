import std.stdio;
import std.getopt;
import std.process;
import std.string;
import std.algorithm;
import std.array;
import std.path;

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
    //Set the lib directories
    argsAppender.put("-L-L"~buildPath("dependencies","Derelict3","lib"));
    argsAppender.put("-L-L"~buildPath("dependencies","gl3n","lib"));
    argsAppender.put([
            "DerelictFI",
            "DerelictGL3",
            "DerelictGLFW3",
            "DerelictUtil",
            "gl3n-dmd",
            "dl",
            ].map!(a=>("-L-l"~a)));
    argsAppender.put("-I"~buildPath("dependencies","Derelict3","import"));
    argsAppender.put("-I"~buildPath("dependencies","gl3n","import"));

    //Run the build command
    auto dmdResult=system("dmd "~std.string.join(argsAppender.data," "));
    return dmdResult;
}
