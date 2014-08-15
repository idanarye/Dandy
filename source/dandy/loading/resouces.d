module dandy.loading.resouces;

public abstract class Resource{
    public void load();
    public bool isLoaded();

    public final void markForLoading(bool forLoading=true){
    }
}
