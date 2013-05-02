module dandy.util;

/**
 * A mixin that implements the singleton pattern.
 *
 * Params:
 *      autoInit =  Determines if using the instance property can generate a new instance.
 */
public mixin template SharedSingleton(bool autoInit=false){
    private static shared typeof(this) singleton_instance=null;

    /**
     * Returns the instance, and creates it if not existing and autoInit==true.
     */
    static @property shared(typeof(this)) instance(){
        if(singleton_instance is null){
            static if(autoInit){
                synchronized{
                    if(singleton_instance is null)
                        singleton_instance=new shared(typeof(this))();
                }
            }
            else
                throw new Exception(typeof(this).stringof~" has not been initialized.");
        }
        return singleton_instance;
    }

    /**
     * Checks if an instance has been initialized.
     */
    public static @property bool hasInstance(){
        return singleton_instance !is null;
    }

    private static void singleton_initInstance(lazy shared(typeof(this)) instance){
        if(singleton_instance is null){
            synchronized{
                if(singleton_instance is null){
                    singleton_instance=instance;
                    return;
                }
            }
        }
        throw new Exception(typeof(this).stringof~" is already initialized.");
    }
}
public mixin template Singleton(bool autoInit=false){
    private static typeof(this) singleton_instance=null;

    /**
     * Returns the instance, and creates it if not existing and autoInit==true.
     */
    static @property typeof(this) instance(){
        if(singleton_instance is null){
            static if(autoInit){
                synchronized{
                    if(singleton_instance is null)
                        singleton_instance=new typeof(this)();
                }
            }
            else
                throw new Exception(typeof(this).stringof~" has not been initialized.");
        }
        return singleton_instance;
    }

    /**
     * Checks if an instance has been initialized.
     */
    public static @property bool hasInstance(){
        return singleton_instance !is null;
    }

    private static void singleton_initInstance(lazy typeof(this) instance){
        if(singleton_instance is null){
            synchronized{
                if(singleton_instance is null){
                    singleton_instance=instance;
                    return;
                }
            }
        }
        throw new Exception(typeof(this).stringof~" is already initialized.");
    }
}
