// This is all a bit more complicated than it needs to be, but it ensures that we only fetch
// each distinct file once from github, rather than making a whole bunch of requests that will
// get us throttled.
var gistIt = function(el, url, rawFile, startLine, endLine, content) {
    var fileName = url.split("/").pop();

    el = $(el);    
    el.html("<div class='codeblock'><pre class='erlang'></pre><div class='codefooter'>"
            + "View this file on GitHub: <a href='" + url + "' title='View this file on GitHub'>"
            + fileName + "</a>" + "</div></div>");

    var pre = $(el).find("pre"),
    lines = content.split("\n");

    if (endLine) {
        for(var i = startLine-1; i <= endLine-1; i++) {
            pre.append(lines[i] + "\n");
        }
    } else {
        pre.append(lines[startLine-1]);
    }

    hljs.highlightBlock(pre[0]);
};

var downloadAllRawFiles = function(rawFileUrls) {
    $.each(rawFileUrls, function(i, x){ 
        $.ajax({ 
            type: 'GET',
            url: "/proxy?url=" + x,
            //Need to do it this way to block before returning the rawFileUrls.
            async:   false,
            success: function (content) {
                    rawFileUrls[x] = content;
                }
            });
    });

    return rawFileUrls;
};

$(document).ready(function(){
    //Highlight static blocks that are not being pulled from github.
    $('pre').each(function(i, block) {
        hljs.highlightBlock(block);
    });

    var blocks = [];
    var rawFiles = [];
    var divs = $('div [data-gistit]');

    divs.each(function() {
        var command, parts, url, lines, start, end, rawFile, fileName;

        command = $(this).data("gistit");
        parts = command.split("?slice=");
        url = parts[0];
        lines = parts[1].split(":");
        start = lines[0];
        end = lines[1];
        rawFile = url.replace("github.com/", "raw.githubusercontent.com/")
                 .replace("/blob/", "/");
        
        if ($.inArray(rawFile, rawFiles) === -1) {
            rawFiles.push(rawFile); //script will be put here when downloaded.
        }

        blocks.push({
            div: this,
            url: url,
            rawFile: rawFile,
            start: start,
            end: end
        });
    });

    rawFiles = downloadAllRawFiles(rawFiles);

    $(blocks).each(function() {
        var content = rawFiles[this.rawFile];
        gistIt(this.div, this.url, this.rawFile, this.start, this.end, content);
    });
});