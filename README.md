## QuickXcoder
An Xcode source editor extension to save Xcoders' time.

## Feature

#### 1. Objective-C Property Place Holder

I have been tired of typing words like ```@property (nonatomic, strong)``` when declaring properties with Objective-C. With QuickXcoder extension installed, I don't have to do that any more.

![image](/Documents/add_property.gif)

#### 2. Objective-C Method Place Holder

Note: This is really a small trick and only efficient with proper key bindings.

![image](/Documents/add_method.gif)

Before this extension, I add an instance method declaration in following steps:

1. Press the ```-``` key that is to the right of ```0``` key.
2. Hold ```Shift``` key and press the ```(``` key that is to the left of ```0``` key.
3. Relocate my hands on keyboard, so that I can go on to type the return type of the method.
4. ...

By setting a key binding with ```Command``` key and the ```-```(to the right of ```0``` key) for creating an instance method declaration, I can type the return type instantly.

The same applies to adding a static method declaration.

#### 3. Section Divider with Pragma

![image](/Documents/add_pragma.gif)

## How to Install

1. Archive and export a package.
2. Run the exported ```QuickXcoder```. (Ignore the crash.)
3. Enable the extension in ```System Preferences -> Extensions -> Xcode Source Editor```.
4. Launch Xcode, the extension will be found in ```Editor``` menu.
5. If needed, set key bindings in ```Xcode -> Preferences -> Key Bindings``` by searching ```Place Holder```.

Tiny feature saves us time.
