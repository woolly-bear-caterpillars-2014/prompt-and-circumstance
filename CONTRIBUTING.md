# Style Guide for Prompt and Circumstance


All HTML rendered with data from the databse should be in a `<div>` tag with a class identifying the table and column.  The class name should be camel case as tablename_columnname.  This will allow the CSS development to occur on consistent `<div>` tags, as opposed to having to work with a variety of HTML tags with pre-defined properties (i.e. `<h1>`, `<p>`, etc)

Examples:
```html
<div class="prompt_title">[SAMPLE TEXT]</div>
<div class="prompt_description">[SAMPLE TEXT]</div>

<div class="response_body">[SAMPLE TEXT]</div>
<div class="response_score">[SAMPLE TEXT]</div>
```



### Site Personality

* Fun
* Non-Hacker News / Reddit look
* Clean
* Column structure

Sample Sites:
* [Bitters](http://bitters.bourbon.io)
* [Discourse](http://www.discourse.org)
* [WNYC](http://www.wnyc.org)




