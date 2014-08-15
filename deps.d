import std.stdio;
import std.file;
import std.path;
import std.process;
import std.string;

enum depsDirName="dependencies";

void getWithGit(string targetFolder,string sourceRepo){
    if(!exists(buildPath(targetFolder,".git"))){
        system("git clone %s %s --depth=1".format(sourceRepo,targetFolder));
    }else{
        auto currDir=getcwd();
        chdir(targetFolder);
        system("git pull origin master");
        system("git checkout master");
        chdir(currDir);
    }
}

int main(string[] args){
    if(!exists(depsDirName))
        mkdir(depsDirName);
    auto depsDirPath=absolutePath(depsDirName);

    chdir(depsDirPath);
    getWithGit("Derelict3","git://github.com/aldacron/Derelict3.git");
    getWithGit("gl3n","git://github.com/Dav1dde/gl3n.git");

    chdir(buildPath(depsDirPath,"Derelict3","build"));
    system("dmd build.d");
    system(buildPath(".","build"));

    chdir(buildPath(depsDirPath,"gl3n"));
    system("make");

    return 0;
}
