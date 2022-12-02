<%@ Page Language="C#" CodeFile="example.aspx.cs" Inherits="Example.Ipa" %>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>IPA Example - ASP.NET - Advanced</title>
	 <link rel="stylesheet" href="https://unpkg.com/leaflet@1.7.1/dist/leaflet.css"
   integrity="sha512-xodZBNTC5n17Xt2atTPuE1HxjVMSvLVW9ocqUKLsCC5CXdbqCmblAshOMAS6/keqq/sMZMZ19scR4PsZChSR7A=="
   crossorigin=""/>
 <!-- Make sure you put this AFTER Leaflet's CSS -->
 <script src="https://unpkg.com/leaflet@1.7.1/dist/leaflet.js"
   integrity="sha512-XQoYMqMTK8LvdxXYG3nZ448hOEQiglfqkJs1NOQV44cWnUrBc8PkAOcXy20w0vlaXaVUearIOBhiXZ5V3ynxwA=="
   crossorigin=""></script>
	<!-- include the IPA JS Library from pictometry -->
	<script type="text/javascript" src="<% Response.Write(this.ipaJsLibUrl()); %>"></script>
	
	<style>
		#content {
			margin-left: auto; 
			margin-right: auto; 
			border-style: solid; 
			width: 95%; 
			height: 4.5em; 
			text-align: center;
		}
		
		#pictometry {
			margin-left: auto; 
			margin-right: auto; 
			padding: 5px; 
			width: 95%; 
			height: 650px; 
			border-style: hidden;
		}
	</style>	
	
</head>
<body>
	<div id="content">
		<h1 style="display: inline">IPA Demo</h1>
		<br>
		<a href='#' onclick="gotoEastmanHouse()">Go to Eastman House</a> |
		<a href='#' onclick="getLocation()">Get Current Location</a> | 
		Set Location: 
		<input type="text" id="locationText" disabled="disabled" 
			onKeyPress="if (event.keyCode == 13) setLocation();"></input>
		<button type="button" onclick="setLocation();">Go</button>	|		
		Goto Address: 
		<input type="text" id="addressText" disabled="disabled" 
			onKeyPress="if (event.keyCode == 13) gotoAddress();"></input>
		<button type="button" onclick="gotoAddress();">Go</button>
		
	</div>
	<div id="pictometry">
		<iframe id="<% Response.Write(this.iframeId()); %>" width="100%" height="100%" src="#"></iframe>
	</div>	
<div id="map" style="width: 600px; height: 400px;"></div>

	<script type="text/javascript">
		var ipa = new PictometryHost('<% Response.Write(this.iframeId()); %>','<% Response.Write(this.ipaLoadUrl()); %>');
		
		ipa.ready = function() {
		 ipa.showDashboard({
     annotations: false,
     clearMeasurements: false,
	 identifyPoint: false,
	 identifyBox: false
	 
 });
 
 ipa.getImageFilterOptions
		
		 ipa.getLayers(function(layers){
     if(layers.layers.length > 0){

         for(var i = 0; i < layers.layers.length; i++){
             var layer = layers.layers[i];
             if (layer.description == "Contours" ) {
                 var config = {};
                 config.layerId = layer.id;
                 config.show = false;
                 ipa.configureLayersMenu([config]);
                 break;
             }
         }
     }
 });
			document.getElementById('locationText').disabled = false;
			document.getElementById('addressText').disabled = false;
     ipa.setLocation({
         y : 43.152139,
         x : -77.580298
     });			
	 		      ipa.setMapOrientation({
         angle: ipa.MAP_ANGLE.OBLIQUE,
         orientation: ipa.MAP_ORIENTATION.EAST
     });
			ipa.addListener('location', function( location ) {
				alert( location.y + " , " + location.x );
			} );
		 ipa.getLayers(function(layers){
     if(layers.layers.length > 0){

         for(var i = 0; i < layers.layers.length; i++){
             var layer = layers.layers[i];
             if (layer.description == "Streets and Place Names" ) {
                 var config = {};
                 config.layerId = layer.id;
                 config.show = false;
                 ipa.configureLayersMenu([config]);
                 break;
             }
         }
     }
 });
		};

		function gotoEastmanHouse() {
		
			// Set the view location
     ipa.setLocation({
	 X : 47.621496842200756,
	 y : -122.34840345158743,
     });

			return false;
		}

		function setLocation() {
			var location = document.getElementById('locationText');
			var loc = location.value.split(',');
			var lat = loc[0].replace(/^\s+|\s+$/g, "");
			var lon = loc[1].replace(/^\s+|\s+$/g, "");
			
			// Alternate syntax to pass parameters
			ipa.setLocation(lat, lon, 17);
			
			return false;
		}
		
		function gotoAddress() {
			var address = document.getElementById('addressText');
			ipa.gotoAddress(address.value);
			return false;
		}

		function getLocation() {
			ipa.getLocation();
		}
		
		// set the iframe src to load the IPA
		var iframe = document.getElementById('<% Response.Write(this.iframeId()); %>');
		iframe.setAttribute('src', '<% Response.Write(this.signedUrl()); %>');
		


	var map = L.map('map').setView([47.784453448337715, -122.33908582622922], 13);

L.tileLayer('https://svc.pictometry.com/Image/A9ED2692-3EB4-9FA4-7DFA-B59735A2BC41/wmts/PICT-WASNOH20-ps5Q8TTNq4/default/GoogleMapsCompatible/{z}/{x}/{y}.png?', {foo: 'bar', attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'}).addTo(map);



	</script>	
	
</body>
</html>
