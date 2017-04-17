function load() {
    var request = new XMLHttpRequest()
    request.open('GET', 'test.txt')
    request.onreadystatechange = function(event) {
        if (request.readyState == XMLHttpRequest.DONE) {
            process_file(request.responseText)
        }
    }
    request.send()
}
