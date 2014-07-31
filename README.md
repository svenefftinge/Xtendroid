Xtendroid
=========

Xtendroid is an Android library that combines the power of [Xtend][] (think: CoffeeScript for Java) with some utility classes/annotations for productive Android development. With Xtendroid, you can spend a lot less time writing boilerplate code and benefit from the tooling support provided by the Xtend framework and Eclipse IDE. 

Xtend code looks like Ruby or Groovy code, but is fully statically-typed and compiles to readable Java code. Infact most Java code is valid Xtend code too, making the learning curve very easy for Java developers. You can debug the original Xtend code or the generated Java code. The runtime library is very thin and includes [Google Guava][]. Xtend's extension methods and active annotations gives it meta-programming capabilities that are perfectly suited for Android development, and this is what Xtendroid takes advantage of. Xtend also provides lambdas, functional programming constructs, string templating, [and more][xtend-doc]. You could say that Xtend is Swift for Android.

Note that Xtend and Xtendroid are currently only supported in Eclipse (Xtend is an Eclipse project), although projects using them can be compiled with Maven or Gradle.

Introduction
------------

If you display toasts often, you know that typing out ```Toast.makeText(...).show();``` is a pain, and it's not easy to add it to a base class, since Activities (and Fragments) may extend multiple base classes (like ListActivity, FragmentActivity, etc.). Here's the easy way using Xtendroid:

```xtend
import static extension org.xtendroid.utils.AlertUtils.*  // mix-in our alert utils

// elsewhere
toast("My short message")
toastLong("This message displays for longer")
```

Where is the reference to the Context object? It is implicit, thanks to Xtend:

```xtend
// this:
toast(context, "My message")

// in Xtend is equivalent to:
context.toast("My message")

// which, in an Activity is the same as:
this.toast("My message")

// But "this" is implicit, so we can shorten it to:
toast("My message")
```

The above magic, as well as the mix-in style ability of the ```import static extension``` of Xtend, is used to great effect in Xtendroid. 

In addition, Xtendroid implements several [Active Annotations][] (think of them as code generators) which remove most of the boilerplate-code that's associated with Android development. Here's an example of one of the most powerful Xtendroid annotations, ```@AndroidActivity```, which automatically extends the ```Activity``` class, loads the layout into the activity, parses the specified layout file, and creates getters/setters for each of the views contained there-in, at **edit-time**! You will immediately get code-completion and outline for your views! Any method annotated with ```@OnCreate``` is called at runtime once the views are ready, although as with everything in Xtendroid, you are free to implement the ```onCreate()``` method yourself.

```xtend
@AndroidActivity(R.layout.my_activity) class MyActivity {

	@OnCreate
	def init(Bundle savedInstanceState) {
		myTextView.text = "some text"
	}

}
``` 

Note that the Active Annotations run at compile-time and simply generate the usual Java code for you, so there is no runtime performance impact. View this video of how this works and how well it integrates with the Eclipse IDE: http://vimeo.com/77024959

Xtendroid combines extension methods, active annotations, and convention-over-configuration (convention-over-code) to provide you with a highly productive environment for Android development, where you are still writing standard Android code, but without all that boilerplate.

Documentation
-------------

View the documentation [here](/Xtendroid/docs/index.md).

Samples
-------

There are several examples in the examples folder: https://github.com/tobykurien/Xtendroid/tree/master/examples

For an example of a live project that uses this library, see the Webapps project: https://github.com/tobykurien/webapps

Getting Started
===============

Method 1:
---------
- Download the latest release from https://github.com/tobykurien/Xtendroid/tree/master/Xtendroid/release
- Copy the JAR file into your Android project's `libs` folder
- If you are using an existing or new Android project:
-- Right-click on your project -> Properties -> Java Build Path 
-- Click Libraries -> Add library -> Xtend Library
- Now you can use it as shown in the examples above.


Method 2:
---------
- Git clone this repository and import it using Eclipse. 
- Add it as a library project to your Android project:
-- Right-click your project -> Properties -> Android -> (Library) Add -> Xtendroid
- If you are using an existing or new Android project:
-- Right-click on your project -> Properties -> Java Build Path 
-- Click Libraries -> Add library -> Xtend Library
- Now you can use it as shown in the examples above.

Xtend
=====

For more about the Xtend language, see http://xtend-lang.org

Gotchas
=======

There are currently some bugs with the Xtend editor that can lead to unexpected behaviour (e.g. compile errors). 
Here are the current bugs you should know about:

- [Android: Editor not refreshing R class](https://bugs.eclipse.org/bugs/show_bug.cgi?id=433358)
- [Android: First-opened Xtend editor shows many errors and never clears those errors after build ](https://bugs.eclipse.org/bugs/show_bug.cgi?id=433589)
- [Android: R$array does not allow dot notation, although R$string and others do](https://bugs.eclipse.org/bugs/show_bug.cgi?id=437660)

[Xtend]: http://xtend-lang.org
[xtend-doc]: http://www.eclipse.org/xtend/documentation.html
[Google Guava]: https://code.google.com/p/guava-libraries/
[Active Annotations]: http://www.eclipse.org/xtend/documentation.html#activeAnnotation
