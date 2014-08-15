module dandy.util.attribute;

/**
 * Creates an attributes of the specified type with the specified name. Creates
 * a private member field of that name with the prefix "m_", a getter property,
 * and unless withSetter is false - a setter property.
 */
mixin template attribute(type,string name,bool withSetter=true){
    mixin(`
            private type m_`~name~`;
            @property type `~name~`(){
                return this.m_`~name~`;
            }`);
    static if(withSetter){
        mixin(`@property void `~name~`(type value){
                    this.m_`~name~`=value;
                }`);
    }
}
