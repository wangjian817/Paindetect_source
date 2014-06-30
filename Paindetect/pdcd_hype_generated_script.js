//	HYPE.documents["pdcd"]

(function HYPE_DocumentLoader() {
	var resourcesFolderName = "";
	var documentName = "pdcd";
	var documentLoaderFilename = "pdcd_hype_generated_script.js";

	// find the URL for this script's absolute path and set as the resourceFolderName
	try {
		var scripts = document.getElementsByTagName('script');
		for(var i = 0; i < scripts.length; i++) {
			var scriptSrc = scripts[i].src;
			if(scriptSrc != null && scriptSrc.indexOf(documentLoaderFilename) != -1) {
				resourcesFolderName = scriptSrc.substr(0, scriptSrc.lastIndexOf("/"));
				break;
			}
		}
	} catch(err) {	}

	// Legacy support
	if (typeof window.HYPE_DocumentsToLoad == "undefined") {
		window.HYPE_DocumentsToLoad = new Array();
	}
 
	// load HYPE.js if it hasn't been loaded yet
	if(typeof HYPE_108 == "undefined") {
		if(typeof window.HYPE_108_DocumentsToLoad == "undefined") {
			window.HYPE_108_DocumentsToLoad = new Array();
			window.HYPE_108_DocumentsToLoad.push(HYPE_DocumentLoader);

			var headElement = document.getElementsByTagName('head')[0];
			var scriptElement = document.createElement('script');
			scriptElement.type= 'text/javascript';
			scriptElement.src = resourcesFolderName + '/' + 'HYPE.js?hype_version=108';
			headElement.appendChild(scriptElement);
		} else {
			window.HYPE_108_DocumentsToLoad.push(HYPE_DocumentLoader);
		}
		return;
	}
	
	// guard against loading multiple times
	if(HYPE.documents[documentName] != null) {
		return;
	}
	
	var hypeDoc = new HYPE_108();
	
	var attributeTransformerMapping = {b:"i",c:"i",bC:"i",d:"i",aS:"i",M:"i",e:"f",aT:"i",f:"d",N:"i",O:"i",g:"c",aU:"i",P:"i",Q:"i",aV:"i",R:"c",aW:"f",aI:"i",S:"i",T:"i",l:"d",aX:"i",aJ:"i",m:"c",n:"c",aK:"i",X:"i",aZ:"i",aL:"i",Y:"i",A:"c",B:"c",C:"c",D:"c",t:"i",E:"i",G:"c",bA:"c",a:"i",bB:"i"};

var scenes = [{initialValues:{"457":{b:416,z:"9",K:"Solid",c:140,bC:0,L:"Solid",d:132,aS:6,J:"Solid",bD:"none",M:1,aT:6,N:1,O:1,g:"#5E5F5F",aU:6,P:1,aV:6,j:"absolute",k:"div",X:0,aZ:0,A:"#A0A0A0",Y:140,B:"#A0A0A0",aM:"457_hover",r:"inline",Z:"break-word",C:"#A0A0A0",s:"Helvetica,Arial,Sans-Serif",aN:"457_pressed",D:"#A0A0A0",t:24,E:0,aA:{goToURL:"http://cn.k519.org/126b228788f375b0cf7b898dd17df603/cv/about",type:5,openInNewWindow:false},F:"center",G:"#FFFFFF",aP:"pointer",w:"\u5173\u4e8e\u6211\u4eec",bA:"#000000",x:"visible",I:"Solid",a:392,y:"preserve",bB:0},"458":{b:416,z:"10",K:"Solid",c:140,bC:0,L:"Solid",d:132,aS:6,J:"Solid",bD:"none",M:1,aT:6,N:1,O:1,g:"#5E5F5F",aU:6,P:1,aV:6,j:"absolute",k:"div",X:0,aZ:0,A:"#A0A0A0",Y:35.3835,B:"#A0A0A0",aM:"458_hover",r:"inline",Z:"break-word",C:"#A0A0A0",s:"Helvetica,Arial,Sans-Serif",aN:"458_pressed",D:"#A0A0A0",t:24,E:0,aA:{goToURL:"http://cn.k519.org/126b228788f375b0cf7b898dd17df603/neuro/zj",type:5,openInNewWindow:false},F:"center",G:"#FFFFFF",aP:"pointer",w:"<div><br></div><div>\u795e\u7ecf\u4e91<br></div><div>\u6587\u732e\u9891\u9053</div>",bA:"#000000",x:"visible",I:"Solid",a:546,y:"preserve",bB:0},"455":{b:416,z:"7",K:"Solid",c:140,bC:0,L:"Solid",d:132,aS:6,J:"Solid",bD:"none",M:1,aT:6,N:1,O:1,g:"#5E5F5F",aU:6,P:1,aV:6,j:"absolute",k:"div",X:0,aZ:0,A:"#A0A0A0",Y:140,B:"#A0A0A0",aM:"455_hover",r:"inline",Z:"break-word",C:"#A0A0A0",s:"Helvetica,Arial,Sans-Serif",aN:"455_pressed",D:"#A0A0A0",t:24,E:0,aA:{goToURL:"http://input",type:5,openInNewWindow:false},F:"center",G:"#FFFFFF",aP:"pointer",w:"\u8f93\u5165\u6570\u636e",bA:"#000000",x:"visible",I:"Solid",a:84,y:"preserve",bB:0},"456":{b:416,z:"8",K:"Solid",c:140,bC:0,L:"Solid",d:132,aS:6,J:"Solid",bD:"none",M:1,aT:6,N:1,O:1,g:"#625D5D",aU:6,P:1,aV:6,j:"absolute",k:"div",X:0,aZ:0,A:"#A0A0A0",Y:140,B:"#A0A0A0",aM:"456_hover",r:"inline",Z:"break-word",C:"#A0A0A0",s:"Helvetica,Arial,Sans-Serif",aN:"456_pressed",D:"#A0A0A0",t:24,E:0,aA:{type:5,goToURL:"http://record",openInNewWindow:false},F:"center",G:"#FFFFFF",aP:"pointer",w:"\u6570\u636e\u5206\u6790",bA:"#000000",x:"visible",I:"Solid",a:238,y:"preserve",bB:0},"64":{o:"content-box",h:"tengtong.png",x:"visible",a:281,q:"100% 100%",b:193,j:"absolute",r:"inline",c:226,z:"6",k:"div",d:164}},timelines:{"455_hover":{framesPerSecond:30,animations:[{f:"2",t:0,d:1,i:"g",e:"#ED1C24",r:1,s:"#5E5F5F",o:"455"}],identifier:"455_hover",name:"455_hover",duration:1},"456_hover":{framesPerSecond:30,animations:[{f:"2",t:0,d:1,i:"g",e:"#ED1C24",r:1,s:"#625D5D",o:"456"}],identifier:"456_hover",name:"456_hover",duration:1},"457_hover":{framesPerSecond:30,animations:[{f:"2",t:0,d:1,i:"g",e:"#ED1C24",r:1,s:"#5E5F5F",o:"457"}],identifier:"457_hover",name:"457_hover",duration:1},"458_hover":{framesPerSecond:30,animations:[{f:"2",t:0,d:1,i:"g",e:"#ED1C24",r:1,s:"#5E5F5F",o:"458"}],identifier:"458_hover",name:"458_hover",duration:1},"456_pressed":{framesPerSecond:30,animations:[{f:"2",t:0,d:1,i:"g",e:"#ED1C24",r:1,s:"#625D5D",o:"456"}],identifier:"456_pressed",name:"456_pressed",duration:1},"457_pressed":{framesPerSecond:30,animations:[{f:"2",t:0,d:1,i:"g",e:"#ED1C24",r:1,s:"#5E5F5F",o:"457"}],identifier:"457_pressed",name:"457_pressed",duration:1},"455_pressed":{framesPerSecond:30,animations:[{f:"2",t:0,d:1,i:"g",e:"#ED1C24",r:1,s:"#5E5F5F",o:"455"}],identifier:"455_pressed",name:"455_pressed",duration:1},kTimelineDefaultIdentifier:{framesPerSecond:30,animations:[{f:"2",t:0,d:0,i:"g",e:"#5E5F5F",r:1,s:"#5E5F5F",o:"455"},{f:"2",t:0,d:0.5,i:"g",e:"#ED1C24",s:"#5E5F5F",o:"455"},{f:"2",t:0.5,d:0,i:"g",e:"#ED1C24",s:"#ED1C24",o:"455"},{f:"2",t:0.5,d:0.5,i:"g",e:"#5E5F5F",s:"#ED1C24",o:"455"},{f:"2",t:0.5,d:0.5,i:"g",e:"#ED1C24",r:1,s:"#625D5D",o:"456"},{f:"2",t:1,d:0,i:"g",e:"#5E5F5F",s:"#5E5F5F",o:"455"},{f:"2",t:1,d:0.5333333,i:"g",e:"#5E5F5F",s:"#ED1C24",o:"456"},{f:"2",t:1,d:0.5,i:"g",e:"#ED1C24",r:1,s:"#5E5F5F",o:"457"},{f:"2",t:1.5,d:0.5,i:"g",e:"#5E5F5F",s:"#ED1C24",o:"457"},{f:"2",t:1.5,d:0.5,i:"g",e:"#ED1C24",r:1,s:"#5E5F5F",o:"458"},{f:"2",t:2,d:0.5,i:"g",e:"#5E5F5F",s:"#ED1C24",o:"458"}],identifier:"kTimelineDefaultIdentifier",name:"Main Timeline",duration:2.5},"458_pressed":{framesPerSecond:30,animations:[{f:"2",t:0,d:1,i:"g",e:"#ED1C24",r:1,s:"#5E5F5F",o:"458"}],identifier:"458_pressed",name:"458_pressed",duration:1}},sceneIndex:0,perspective:"600px",oid:"58",onSceneAnimationCompleteAction:{type:5},backgroundColor:"#808080",name:"Untitled Scene 2"}];


	
	var javascripts = [];


	
	var Custom = {};
	var javascriptMapping = {};
	for(var i = 0; i < javascripts.length; i++) {
		try {
			javascriptMapping[javascripts[i].identifier] = javascripts[i].name;
			eval("Custom." + javascripts[i].name + " = " + javascripts[i].source);
		} catch (e) {
			hypeDoc.log(e);
			Custom[javascripts[i].name] = (function () {});
		}
	}
	
	hypeDoc.setAttributeTransformerMapping(attributeTransformerMapping);
	hypeDoc.setScenes(scenes);
	hypeDoc.setJavascriptMapping(javascriptMapping);
	hypeDoc.Custom = Custom;
	hypeDoc.setCurrentSceneIndex(0);
	hypeDoc.setMainContentContainerID("pdcd_hype_container");
	hypeDoc.setResourcesFolderName(resourcesFolderName);
	hypeDoc.setShowHypeBuiltWatermark(1);
	hypeDoc.setShowLoadingPage(false);
	hypeDoc.setDrawSceneBackgrounds(true);
	hypeDoc.setDocumentName(documentName);

	HYPE.documents[documentName] = hypeDoc.API;

	hypeDoc.documentLoad(this.body);
}());

