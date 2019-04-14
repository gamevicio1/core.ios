# core.ios
I'm working in a ios framework to make easier the major needs. 

I have experincies creating basic frameworks to php in the past, the last 4 year I have dedicated to create a framework to my apps in Android. 

But now, I started to create native apps to IOS platform and I'll publish some of my code here and accept help and talk about this. I still making better my code before to publish, but I'll give the example of some functionalities

## With
This class have two major uses: Be a interface element selector make easy the casting and be a easier way to associate a action to a element through the target property without using the outlet. It works with button, barButtonItem e label til now.

Example 1: In your ViewController class you should use With.shared.append("button1",myButton).append("label1",myLabel).done . With has a shared instance, so you can use it in any other class in your code like With.shared.label("label1").text = "myText"

Example 2: You can define a action bo button using With.shared.target.append("button1", action: { print("my button was clicked") }).done()

## WebClient
My WebClient class works with sincronous requewst, so it's better to developer who works own threads.

let url = "http://www.site.com"
            let params:[String:Any] = [
                "param1": "S",
                "param2": 50
            ]
            
let s = WebClient(url).with(postContent: params).with(timeoutSeconds: 10).with(retry: 1, waitSeconds: 1).with(debug: false).downloadString()

## SimpleXML
It's not simple works with xml, the simplexml allow you use fake basic xpath expression

let xmlFragment = "... xml contents"

let xml = SimpleXML(xmlFragment)

let status = xml.getString("attribute::status")

let title = xml.getString("details/title")

let numberOfTitles = xml.count("details/title")

Others classes include:
 - Database sqlite support
 - Basic MVC
 - LinearLayout (try mimic the Android LinearLayout element)
 - AsyncTask
 - Dialog custom
 - TypingMask
