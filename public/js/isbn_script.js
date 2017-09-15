    function nameFunction() {
        // var x is how you make variable
        // document = webpage
        //get element by id = searhc for the tag <> that contains namesList
        var x = document.getElementById("nameList").value;
        //innerHTML
        //ie <p id-"demo""></p>
        document.getElementById("demo").innerHTML = "Enter their names in the boxes below:<br>";
        // variabe loop while i <= variable x 
        // last line 
        for (var i = 1; i <= x; i++) {
            var input = document.createElement("input");
            input.type = "text";
            input.name = "isbn_data[]";
            input.id = "nameJava";

            input.required = true;
            input.placeholder = "Enter Number"
            document.getElementById("demo").appendChild(input).value;
        }
    }