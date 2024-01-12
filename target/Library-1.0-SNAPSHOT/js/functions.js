/**
 * 
 */

function filterBooks()
{
	var x = new XMLHttpRequest();
	x.onreadystatechange = function()
	{
		if (x.readyState == 4 && x.status == 200)
		{
			
		}
	};
	
	
}

function filterOnKeyUp()
{
	var text = document.getElementById('filterInput');
	window.location.href = "services/bookServices.jsp?filter=" +text;
}